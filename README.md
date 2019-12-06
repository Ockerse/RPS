Overview
=======
The following tutorial will be using Apple's `GameKit` framework using Swift 5. With GameKit we can create applications that allow us to interact with other iOS users through Game Center's network. Some of the many examples you can implement to your own application are: achievements, leaderboards, and challenges. Through Game Center you are also able to add real time multiplayer or turn based multiplayer. The following screenshots below gives a small glance of what you will be able to create with GameKit. Our game is Rock, Paper, Scissors and is adapted from Rminsh's RPS ([Link to repository](https://github.com/Rminsh/RPS))

![Image](doc/menu_screen_50_1_50.png "Main Menu") ![Image](doc/achievements_screen_50_1_50.png "Achievement Screen") ![Image](doc/leaderboards_screen_50_1_50.png "Leaderboard Screen") 


Getting started
=======

Set up Game Center in XCode project
----
Go to **PROJECT>TARGETS>Signing & Capabilites**<br />
Click the plus sign next to capabilities to add a new capability. In the prompt that pops up search for `Game Center`. When complete it should show up like below.


Register your game with App Store Connect
----
To use Game Center's features you have to authenticate the player with Game Center. Before you can do that your game must be registered with Apple. To register head over to [App Store Connect](https://appstoreconnect.apple.com) website (This does require an Apple Developer Account). 


Once your app is registered, select it and go to **Features>Game Center**

![Image](doc/appstoreGC.png "App Store Game Center")

From here you can manage all of your achievements and leaderboards. When you make a new leaderboard or achievement keep in mind that the identifier you choose cannot be changed later. You will use this identifier in your code to save players progress and data to the leaderboard or achievement that corresponds to the identifier.

You are now ready to start implementing `Game Center` in your code.

Step-by-step coding instructions
=======

Authenticating player
---
The first that you want to think about is authenticating the player, and then sooner you do this the better. The best time is after the loading screen or when the initial `ViewController` gets loaded. 
```swift
 GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
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
```
The code above will present the Game Center login ViewController if the local player has not signed in. If the player has been signed before, the next time they open the game a notification badge will show at the top of the screen welcoming the player back.

You have to add a GameKit delegate to dimiss the Game Center ViewController
```swift
extension MenuViewController: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
```

Game Center identifiers
---
In our code we saved leaderboard and achievement identifiers in a class called **ID**. Each identifier is a constant so that it can be easily used within the entire project. 

```swift
import Foundation
class ID {
    
    // Leaderboards
    static let HIGHSCORE = "ueckerherman.ockerse.rps.leaderboard"
    
    
    //Achievements
    static let WIN_1 = "username.rps.WinOneGame"
    static let WIN_5 = "username.rps.WinFive"
    static let WIN_10 = "username.rps.WinTen"
    static let WIN_15 = "username.rps.WinFifteen"
    static let WIN_20 = "username.rps.WinTwenty"
    static let WIN_100 = "username.rps.WinHundred"
    
}
```


Viewing achievements in Game Center
---
```swift
func showAchievements() {
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .achievements
        present(gcVC, animated: true, completion: nil)
    }
```
This code instantiates the `Game Center ViewController` and assigns it to the delegate. The `viewState` is set to `.achievements` to load the achievements view. Lastly, the `ViewController` is presented to the screen.

Viewing leaderboard in Game Center
---
```swift
func showLeaderboards() {
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .leaderboards
        //gcVC.leaderboardIdentifier = ID.HIGHSCORE
        present(gcVC, animated: true, completion: nil)
    }
```
Similar to the achivements, we can do the same for leaderboards. The only difference is that the `viewState` is set to `.leaderboards` to show leaderboards. Optionally, you can view a specific leaderboard by specifying the `.leaderboardIdentifier` to the identifier of the leaderboard you want.

Submit scores to Game Center
---
```swift
  func reportAchievement(pc: Double, ID: String ) {
        let achievement = GKAchievement(identifier: ID)
          
        achievement.percentComplete = pc
          print("percent complete: \(achievement.percentComplete) for: \(ID)")
    
        achievement.showsCompletionBanner = true
        GKAchievement.report([achievement]) { (error) in
          print(error?.localizedDescription ?? "")
        }
      }
```

Update achievement progress
---
```swift
  func updateAchievementProgress() {
     
        
        
        let ONE_ONE : Double = 1/1 * 100
        let ONE_FIFTH: Double = 1/5 * 100
        let ONE_TEN: Double = 1/10 * 100
        let ONE_FIFTEEN: Double = 1/15 * 100
        let ONE_TWENTY: Double = 1/20 * 100
        let ONE_HUNDRED: Double = 1/100 * 100
        
       
        reportAchievement(pc: getProgressVal(forKey: ID.WIN_1)+ONE_ONE, ID: ID.WIN_1)
        reportAchievement(pc: getProgressVal(forKey: ID.WIN_5)+ONE_FIFTH, ID: ID.WIN_5)
        reportAchievement(pc: getProgressVal(forKey: ID.WIN_10)+ONE_TEN, ID: ID.WIN_10)
        reportAchievement(pc: getProgressVal(forKey: ID.WIN_15)+ONE_FIFTEEN, ID: ID.WIN_15)
        reportAchievement(pc: getProgressVal(forKey: ID.WIN_20)+ONE_TWENTY, ID: ID.WIN_20)
        //print("Progress val: \(getProgressVal(forKey: ID.WIN_100))")
        reportAchievement(pc: (getProgressVal(forKey: ID.WIN_100)+ONE_HUNDRED), ID: ID.WIN_100)
    
        
        loadAchievementProgress()
        
    }
    
    
    
}
```

Conclusions
=======

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

Paragraphs are separated
-----------
by a blank line.


Two spaces at the end of a line  
produces a line break.

Text attributes _italic_, 
**bold**, `monospace`.

Horizontal rule:


---
Strikethrough:
~~strikethrough~~

Bullet list:

  * apples
  * oranges
  * pears

Numbered list:

  1. lather
  2. rinse
  3. repeat

An [example](http://example.com).

![Image](Icon-pictures.png "icon")
test

> Markdown uses email-style > characters for blockquoting.

Inline <abbr title="Hypertext Markup Language">HTML</abbr> is supported.
