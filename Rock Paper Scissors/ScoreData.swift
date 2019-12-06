//
//  ScoreData.swift
//  Rock Paper Scissors
//
//  Created by Carson Uecker-Herman on 12/4/19.
//  Copyright © 2019 armin. All rights reserved.
//

import Foundation
import GameKit

class ScoreData {
    
    func ScoreData() {}
    
    // MARK: Load Achievements
    func loadAchievementProgress() {
    GKAchievement.loadAchievements() { achievements, error in
        guard let achievements = achievements else { return }
          for ach in achievements {
              for (key, _) in Progress {
                  if(ach.identifier == key){
                      Progress.updateValue(ach.percentComplete, forKey: ach.identifier)
                  }
              }
          }
         }
    }
    
    // MARK: Report Achievement
    func reportAchievement(pc: Double, ID: String ) {
        let achievement = GKAchievement(identifier: ID)
        achievement.percentComplete = pc
        achievement.showsCompletionBanner = true
        GKAchievement.report([achievement]) { (error) in
          print(error?.localizedDescription ?? "")
        }
      }
    
    // MARK: Report Score
    func reportScore(score: Int64, ID: String) {
        let reportedScore = GKScore(leaderboardIdentifier: ID)
        reportedScore.value = score
        GKScore.report([reportedScore]) { (error) in
          guard error == nil else {
          print(error?.localizedDescription ?? "")
          return
          }
        }
      }
    

    func getProgressVal(forKey: String) -> Double{
        for (key, val) in Progress {
            if(key == forKey){
                return val
            }
        }
        return 0.0
    }
    
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
        reportAchievement(pc: (getProgressVal(forKey: ID.WIN_100)+ONE_HUNDRED), ID: ID.WIN_100)
        
        loadAchievementProgress()
    }
    
    
    
}
