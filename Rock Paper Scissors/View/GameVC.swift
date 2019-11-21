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
    let defaults: UserDefaults = UserDefaults.standard
    var drawScoreInt : Int!
    var userScoreInt : Int!
    var botScoreInt : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawScoreInt = Int(defaults.integer(forKey: SaveKeys.drawScoreKey))
        userScoreInt = Int(defaults.integer(forKey: SaveKeys.userScoreKey))
        botScoreInt = Int(defaults.integer(forKey: SaveKeys.botScoreKey))
        updateScores()
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
            drawScoreInt = drawScoreInt + 1
            defaults.set(drawScoreInt, forKey: SaveKeys.drawScoreKey)
            updateScores()
            return "Draw!"
        } else if (user == "👊🏻" && computer == "✋🏻") || (user == "✋🏻" && computer == "✌🏻") || (user == "✌🏻" && computer == "👊🏻") {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
            })
            whiteLabels()
            botScoreInt = botScoreInt + 1
            defaults.set(botScoreInt, forKey: SaveKeys.botScoreKey)
            updateScores()
            return "You Lose"
        } else {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                self.view.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.6823529412, blue: 0.3764705882, alpha: 1)
            })
            whiteLabels()
            userScoreInt = userScoreInt + 1
            defaults.set(userScoreInt, forKey: SaveKeys.userScoreKey)
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
            self.view.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8039215686, blue: 0.2470588235, alpha: 1)
            self.statusLabel.textColor = #colorLiteral(red: 0.1706000417, green: 0.1706000417, blue: 0.1706000417, alpha: 1)
            self.userScore.textColor = #colorLiteral(red: 0.1706000417, green: 0.1706000417, blue: 0.1706000417, alpha: 1)
            self.botScore.textColor = #colorLiteral(red: 0.1706000417, green: 0.1706000417, blue: 0.1706000417, alpha: 1)
            self.drawScore.textColor = #colorLiteral(red: 0.1706000417, green: 0.1706000417, blue: 0.1706000417, alpha: 1)
        })
        paperBtn.isHidden = false
        scissorsBtn.isHidden = false
        rockBtn.isHidden = false
        userChoice.isHidden = true
        botChoice.text = "🤖"
        statusLabel.text = "Rock , Paper , Scissors?"
    }
    
    func updateScores() {
        userScore.text = "You: \(Int(userScoreInt))"
        drawScore.text = "Draw: \(Int(drawScoreInt))"
        botScore.text = "Bot: \(Int(botScoreInt))"
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
