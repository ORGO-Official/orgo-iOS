//
//  MountainDifficulty.swift
//  orgo
//
//  Created by 김태현 on 2023/09/15.
//

import Foundation

enum MountainDifficulty: String {
    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"
}

extension MountainDifficulty {
    
    var count: Int {
        switch self {
        case .easy: return 1
        case .normal: return 2
        case .hard: return 3
        }
    }
    
}
