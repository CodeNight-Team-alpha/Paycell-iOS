//
//  LeaderboardEndpoint.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import Foundation

enum LeaderboardEndpoint: Endpoint {
    case get

    var baseURL: String {
        "http://localhost:8080/api/v1/leaderboard?asOfDate=2025-02-15"
    }

    var path: String { "" }
}
