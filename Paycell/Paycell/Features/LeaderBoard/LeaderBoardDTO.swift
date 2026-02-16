//
//  LeaderBoardDTO.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import Foundation
// Data Model
struct LeaderboardItem {
    let name: String
    let points: Int
    let badgeName: String
}

// Sample Data (8 items)
let leaderboardItems: [LeaderboardItem] = [
    LeaderboardItem(name: "Nur", points: 250, badgeName: "Bronze Cashback"),
    LeaderboardItem(name: "Emine", points: 650, badgeName: "Silver Cashback"),
    LeaderboardItem(name: "Zeynep", points: 1200, badgeName: "Gold Cashback"),
    LeaderboardItem(name: "Merve", points: 450, badgeName: "Bronze Cashback"),
    LeaderboardItem(name: "Arif", points: 700, badgeName: "Silver Cashback"),
    LeaderboardItem(name: "Ayşe", points: 1300, badgeName: "Gold Cashback"),
    LeaderboardItem(name: "Ceylin", points: 500, badgeName: "Bronze Cashback"),
    LeaderboardItem(name: "Taylan", points: 750, badgeName: "Silver Cashback")
]
