//
//  UserInfoDTO.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import Foundation

struct UserSpendSummary {
    let name: String
    let segment: String
    let spendToday: Int
    let uniqueCategoriesToday: Int
    let electronicsSpendToday: Double
    let spendLast7Days: Int
}

let userSample = UserSpendSummary(
    name: "Ayşe",
    segment: "Student",
    spendToday: 481,
    uniqueCategoriesToday: 1,
    electronicsSpendToday: 481.0,
    spendLast7Days: 2865
)
