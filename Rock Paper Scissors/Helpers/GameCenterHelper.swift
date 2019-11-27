import GameKit

final class GameCenterHelper: NSObject {
  typealias CompletionBlock = (Error?) -> Void
    
  static let helper = GameCenterHelper()
  
  static var isAuthenticated: Bool {
    return GKLocalPlayer.local.isAuthenticated
  }

  var viewController: UIViewController?
  var currentMatchmakerVC: GKTurnBasedMatchmakerViewController?
  
  enum GameCenterHelperError: Error {
    case matchNotFound
  }

  var currentMatch: GKTurnBasedMatch?

  var canTakeTurnForCurrentMatch: Bool {
    guard let match = currentMatch else {
      return true
    }
    
    return match.isLocalPlayersTurn
  }
  
    
  override init() {
    super.init()
    
    GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
      NotificationCenter.default.post(name: .authenticationChanged, object: GKLocalPlayer.local.isAuthenticated)

      if GKLocalPlayer.local.isAuthenticated {
        GKLocalPlayer.local.register(self)
      } else if let vc = gcAuthVC {
        self.viewController?.present(vc, animated: true)
      }
      else {
        print("Error authentication to GameCenter: \(error?.localizedDescription ?? "none")")
      }
    }
  }
  
  func presentMatchmaker() {
    guard GKLocalPlayer.local.isAuthenticated else {
      return
    }
    
    let request = GKMatchRequest()
    
    request.minPlayers = 2
    request.maxPlayers = 2
    request.inviteMessage = "Would you like to play Nine Knights?"
    
    let vc = GKTurnBasedMatchmakerViewController(matchRequest: request)
    vc.turnBasedMatchmakerDelegate = self
    
    currentMatchmakerVC = vc
    viewController?.present(vc, animated: true)
  }
  
    /*
  func endTurn(_ model: GameModel, completion: @escaping CompletionBlock) {
    guard let match = currentMatch else {
      completion(GameCenterHelperError.matchNotFound)
      return
    }
    
    do {
      match.message = model.messageToDisplay
      
      match.endTurn(
        withNextParticipants: match.others,
        turnTimeout: GKExchangeTimeoutDefault,
        match: try JSONEncoder().encode(model),
        completionHandler: completion
      )
    } catch {
      completion(error)
    }
  }
 
 */
    
  
  func win(completion: @escaping CompletionBlock) {
    guard let match = currentMatch else {
      completion(GameCenterHelperError.matchNotFound)
      return
    }
    
    match.currentParticipant?.matchOutcome = .won
    match.others.forEach { other in
      other.matchOutcome = .lost
    }
    
    match.endMatchInTurn(
      withMatch: match.matchData ?? Data(),
      completionHandler: completion
    )
  }
}

extension GameCenterHelper: GKTurnBasedMatchmakerViewControllerDelegate {
  func turnBasedMatchmakerViewControllerWasCancelled(_ viewController: GKTurnBasedMatchmakerViewController) {
    viewController.dismiss(animated: true)
  }
  
  func turnBasedMatchmakerViewController(_ viewController: GKTurnBasedMatchmakerViewController, didFailWithError error: Error) {
    print("Matchmaker vc did fail with error: \(error.localizedDescription).")
  }
}

extension GameCenterHelper: GKLocalPlayerListener {
  func player(_ player: GKPlayer, wantsToQuitMatch match: GKTurnBasedMatch) {
    let activeOthers = match.others.filter { other in
      return other.status == .active
    }
    
    match.currentParticipant?.matchOutcome = .lost
    activeOthers.forEach { participant in
      participant.matchOutcome = .won
    }
    
    match.endMatchInTurn(
      withMatch: match.matchData ?? Data()
    )
  }
  
  func player(_ player: GKPlayer, receivedTurnEventFor match: GKTurnBasedMatch, didBecomeActive: Bool) {
    if let vc = currentMatchmakerVC {
      currentMatchmakerVC = nil
      vc.dismiss(animated: true)
    }
    
    guard didBecomeActive else {
      return
    }
    
    NotificationCenter.default.post(name: .presentGame, object: match)
  }
    
    func loadPhoto(for size: GKPlayer.PhotoSize,
                   withCompletionHandler completionHandler: ((UIImage?, Error?) -> Void)? = nil){
        
    }
    
    
    
    
}

extension Notification.Name {
  static let presentGame = Notification.Name(rawValue: "presentGame")
  static let authenticationChanged = Notification.Name(rawValue: "authenticationChanged")
}
