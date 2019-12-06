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


class GameVC: UIViewController{

    var choice : String!
    let randomChoice = GKRandomDistribution(lowestValue: 0, highestValue: 2)
    var SD = ScoreData()
  
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
   
    @IBOutlet weak var playAgainView: ColorStackView!
    
    @IBOutlet weak var controlsView: UIStackView!
    var win1 = 0.0
    var win5 = 0.0
    var win10 = 0.0
    var win15 = 0.0
    var win20 = 0.0
    var win100 = 0.0
    
    @IBAction func playAgainBtn(_ sender: Any) {
        newGame()
        SD.loadAchievementProgress()
    }
    
    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var timer:Timer?
    var timeLeft = 30
    
    var drawScoreInt : Int = 0
    var userScoreInt : Int = 0
    var botScoreInt : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScores()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        playAgainBtn.isHidden = true
        exitBtn.isHidden = true
        playAgainView.isHidden = true
        controlsView.isHidden = false
    }

    // MARK: Timer
    @objc func onTimerFires()
       {
           timeLeft -= 1
           timerLbl.text = "\(timeLeft)s"

           if timeLeft <= 0 {
            timer?.invalidate()
               timer = nil
            controlsView.isHidden = true
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
    
    //MARK: Calculate Results
    func calculateResult(user: String , computer: String) -> String {
        if user == computer {
            drawScoreInt += 1
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                           self.view.backgroundColor = #colorLiteral(red: 0.6634730851, green: 0.4901956655, blue: 0.14628277, alpha: 1)
            })
            updateScores()
            return "Draw!"
        } else if (user == "👊🏻" && computer == "✋🏻") || (user == "✋🏻" && computer == "✌🏻") || (user == "✌🏻" && computer == "👊🏻") {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.view.backgroundColor = #colorLiteral(red: 0.6596407043, green: 0.1820560495, blue: 0.1526315029, alpha: 1)
            })
            whiteLabels()
            botScoreInt += 1
            updateScores()
            return "You Lose"
        } else {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.view.backgroundColor = #colorLiteral(red: 0.06999487557, green: 0.4483745148, blue: 0.1872373435, alpha: 1)
            })
            whiteLabels()
            userScoreInt += 1
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
            self.view.backgroundColor = #colorLiteral(red: 0.1281678677, green: 0.1445254982, blue: 0.1825574338, alpha: 1)
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
 
    // MARK: Update Scores
    func updateScores() {
        userScore.text = "You: \(Int(userScoreInt))"
        drawScore.text = "Draw: \(Int(drawScoreInt))"
        botScore.text = "Bot: \(Int(botScoreInt))"
    }
    // MARK: New Game
    func newGame() {
        resetItems()
        timeLeft = 30
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
        playAgainBtn.isHidden = true
        exitBtn.isHidden = true
        playAgainView.isHidden = true
        controlsView.isHidden = false
        userScoreInt=0
        botScoreInt=0
        drawScoreInt=0
        updateScores()
        timerLbl.text = "30s"
    
        SD.loadAchievementProgress()
    }
    
    // MARK: Game Over
    func gameOver() {
        controlsView.isHidden = true
        paperBtn.isHidden = true
        scissorsBtn.isHidden = true
        rockBtn.isHidden = true
        self.timerLbl.text = "GAME OVER"
        
        if(botScoreInt > userScoreInt){
            botChoice.text = "👎"
            statusLabel.text = "YOU LOST!"
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.view.backgroundColor = #colorLiteral(red: 0.6596407043, green: 0.1820560495, blue: 0.1526315029, alpha: 1)
            })
        }
        else if(userScoreInt > botScoreInt) {
            botChoice.text = "👏"
            statusLabel.text = "YOU WON!"
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.view.backgroundColor = #colorLiteral(red: 0.06999487557, green: 0.4483745148, blue: 0.1872373435, alpha: 1)
            })
            SD.reportScore(score:Int64(userScoreInt), ID: ID.HIGHSCORE)
            SD.updateAchievementProgress()
        }
        else {
            botChoice.text = "🤝"
            statusLabel.text = "TIE!"
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                                      self.view.backgroundColor = #colorLiteral(red: 0.6634730851, green: 0.4901956655, blue: 0.14628277, alpha: 1)
                                  })
        }
        
        playAgainView.isHidden = false
       playAgainBtn.isHidden = false
       exitBtn.isHidden = false
        
        
        
        SD.loadAchievementProgress()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
