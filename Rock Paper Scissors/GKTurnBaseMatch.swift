//
//  GKTurnBaseMatch.swift
//  Rock Paper Scissors
//
//  Created by Carson Uecker-Herman on 11/20/19.
//  Copyright © 2019 armin. All rights reserved.
//

import GameKit

extension GKTurnBasedMatch {
  var isLocalPlayersTurn: Bool {
    return currentParticipant?.player == GKLocalPlayer.local
  }
  
  var others: [GKTurnBasedParticipant] {
    return participants.filter {
      return $0.player != GKLocalPlayer.local
    }
  }
}
