//
//  MenuViewController.swift
//  Rock Paper Scissors
//
//  Created by Carson Uecker-Herman on 11/20/19.
//  Copyright © 2019 armin. All rights reserved.
//

import UIKit
import GameKit



class MenuViewController: UIViewController {
    
  

    //var playername :String = GKLocalPlayer.local.displayName
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    
    
    
    
    func showLeaderboards() {
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = ID.LEADERBOARD_ID
        present(gcVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameCenterHelper.helper.viewController = self
        // Do any additional setup after loading the view.
        
        player.text = "\(GKLocalPlayer.local.displayName.self)"
        
    }
    
    @IBAction func localGameBtn(_ sender: Any) {
        
    }
    
    @IBAction func GameCenterBtn(_ sender: Any) {
        showLeaderboards()
    }
      //  GameCenterHelper.helper.presentMatchmaker()
}

func loadPlayers(forIdentifiers identifiers: [String],
                 withCompletionHandler completionHandler: (([GKPlayer]?, Error?) -> Void)? = nil){
    print(identifiers)
}


extension MenuViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
