//
//  ScoreModel.swift
//  GestureCat
//
//  Created by Yury Vozleev on 14.11.2022.
//

import Foundation

struct ScoreModel : Codable {
    var name : String
    var score: Int
    var date: String
}

extension ScoreModel: Comparable {
    static func < (lhs: ScoreModel, rhs: ScoreModel) -> Bool {
        lhs.score < rhs.score
    }
    
    
}
