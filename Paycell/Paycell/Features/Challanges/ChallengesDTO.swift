//
//  ChallengesDTO.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import Foundation

struct ChallengeItem {
    let challengeName: String
    let rewardPoints: Int
    let isCompleted: Bool
}

// Sample Data (4 items)
let challenges: [ChallengeItem] = [
    ChallengeItem(challengeName: "Haftalık Aktif", rewardPoints: 220, isCompleted: true),
    ChallengeItem(challengeName: "Elektronik Bonus", rewardPoints: 180, isCompleted: false),
    ChallengeItem(challengeName: "Kategori Avcısı", rewardPoints: 120, isCompleted: false),
    ChallengeItem(challengeName: "Günlük Harcama", rewardPoints: 60, isCompleted: false)
]
