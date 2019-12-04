//
//  ViewController.swift
//  Rock Paper Scissors
//
//  Created by armin on 8/1/18.
//  Copyright © 2018 armin. All rights reserved.
//

import UIKit
import GameplayKit
import GameKit


class GameVC: UIViewController {
    var playername = GKLocalPlayer.local
    var choice : String!
    let randomChoice = GKRandomDistribution(lowestValue: 0, highestValue: 2)
    @IBOutlet weak var rockBtn: UIButton!
    @IBOutlet weak var paperBtn: UIButton!
    @IBOutlet weak var scissorsBtn: UIButton!
    @IBOutlet weak var botChoice: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var userChoice: UILabel!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var drawScore: UILabel!
    @IBOutlet weak var botScore: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var playAgainBtn: RoundedButton!
    @IBOutlet weak var exitBtn: RoundedButton!
    
    
    @IBAction func playAgainBtn(_ sender: Any) {
        newGame()
    }
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var timer:Timer?
    var timeLeft = 30
    
    
    
   // let defaults: UserDefaults = UserDefaults.standard
    var drawScoreInt : Int = 0
    var userScoreInt : Int = 0
    var botScoreInt : Int = 0
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //drawScoreInt = Int(defaults.integer(forKey: SaveKeys.drawScoreKey))
        //userScoreInt = Int(defaults.integer(forKey: SaveKeys.userScoreKey))
        //botScoreInt = Int(defaults.integer(forKey: SaveKeys.botScoreKey))
        updateScores()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        playAgainBtn.isHidden = true
        exitBtn.isHidden = true
       
    }

    
    @objc func onTimerFires()
       {
           timeLeft -= 1
           timerLbl.text = "\(timeLeft)s"

           if timeLeft <= 0 {
            timer?.invalidate()
               timer = nil
            gameOver()
           }
       }
    
    @IBAction func rockBtnPressed(_ sender: Any) {
        choice = "👊🏻"
        getResult()
    }
    
    @IBAction func paperBtnPressed(_ sender: Any) {
        choice = "✋🏻"
        getResult()
    }
    
    @IBAction func scissors(_ sender: Any) {
        choice = "✌🏻"
        getResult()
        
    }

    func getResult() {
        paperBtn.isHidden = true
        scissorsBtn.isHidden = true
        rockBtn.isHidden = true
        userChoice.isHidden = false
        userChoice.text = choice
        botChoice.text = randomSign().rawValue
        statusLabel.text = calculateResult(user: choice, computer: botChoice.text!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
            self.resetItems()
        })
    }
    
    func randomSign() -> Sign {
        let sign = randomChoice.nextInt()
        if sign == 0 {
            return .rock
        } else if sign == 1 {
            return .paper
        } else {
            return .scissors
        }
    }
    
    func calculateResult(user: String , computer: String) -> String {
        if user == computer {
            //drawScoreInt = drawScoreInt + 1
            
            drawScoreInt += 1
            //defaults.set(drawScoreInt, forKey: SaveKeys.drawScoreKey)
            
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                           self.view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                       })
            
            updateScores()
            return "Draw!"
        } else if (user == "👊🏻" && computer == "✋🏻") || (user == "✋🏻" && computer == "✌🏻") || (user == "✌🏻" && computer == "👊🏻") {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
            })
            whiteLabels()
            botScoreInt += 1
            //defaults.set(botScoreInt, forKey: SaveKeys.botScoreKey)
            updateScores()
            return "You Lose"
        } else {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.view.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.6823529412, blue: 0.3764705882, alpha: 1)
            })
            whiteLabels()
            userScoreInt += 1
            //defaults.set(userScoreInt, forKey: SaveKeys.userScoreKey)
            updateScores()
            return "You win!"
        }
    }
    
    func whiteLabels() {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.userScore.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.botScore.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.drawScore.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.statusLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        })
    }
    
    func resetItems() {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.statusLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.userScore.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.botScore.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.drawScore.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        })
        paperBtn.isHidden = false
        scissorsBtn.isHidden = false
        rockBtn.isHidden = false
        userChoice.isHidden = true
        botChoice.text = "🤖"
        statusLabel.text = "Rock, Paper, Scissors?"
        
    }
    
    func updateScores() {
        userScore.text = "You: \(Int(userScoreInt))"
        drawScore.text = "Draw: \(Int(drawScoreInt))"
        botScore.text = "Bot: \(Int(botScoreInt))"
    }
    
    
    func newGame() {
        resetItems()
        timeLeft = 30
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        playAgainBtn.isHidden = true
        exitBtn.isHidden = true
        userScoreInt=0
        botScoreInt=0
        drawScoreInt=0
        updateScores()
        timerLbl.text = "30s"
    }
    
    func addScoreAndSubmitToGC() {
        // Get the current score
        let score: Int = userScoreInt
        // Get the Leaderboard ID
        let IDn: String = ID.HIGHSCORE
        
        // Create a GKScore object and add the points to it
        let bestScoreInt = GKScore(leaderboardIdentifier: IDn)
        bestScoreInt.value = Int64(score)
        
        // Submit score to GC leaderboard
        GKScore.report([bestScoreInt]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Highscore sent to GameCenter")
            }
        }
    }
    
    func report(score: Int64, ID: String) {
      let reportedScore = GKScore(leaderboardIdentifier: ID)
      reportedScore.value = score
      GKScore.report([reportedScore]) { (error) in
        guard error == nil else {
        print(error?.localizedDescription ?? "")
        return
        }
      print("The score submitted to the game center")
      }
    }
    
    func reportAchievement(percentComplete:Double, ID: String) {
      let achievement = GKAchievement(identifier: ID)
      achievement.percentComplete = percentComplete
      achievement.showsCompletionBanner = true
      GKAchievement.report([achievement]) { (error) in
        print(error?.localizedDescription ?? "")
      }
    }
    func gameOver() {
        
        self.timerLbl.text = "GAME OVER"
        paperBtn.isHidden = true
        scissorsBtn.isHidden = true
        rockBtn.isHidden = true
        
        
        if(botScoreInt > userScoreInt){
            botChoice.text = "👎"
            statusLabel.text = "YOU LOST!"
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
            })
        }
        else if(userScoreInt > botScoreInt) {
            botChoice.text = "👏"
            statusLabel.text = "YOU WON!"
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.view.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.6823529412, blue: 0.3764705882, alpha: 1)
            })
            addScoreAndSubmitToGC()
        }
        else {
            botChoice.text = "🤝"
            statusLabel.text = "TIE!"
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                                      self.view.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
                                  })
        }
        
        playAgainBtn.isHidden = false
        exitBtn.isHidden = false
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
