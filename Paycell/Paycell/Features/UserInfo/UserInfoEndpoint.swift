//
//  UserInfoEndpoint.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import Foundation

enum UserInfoEndpoint: Endpoint {
    case get

    var baseURL: String {
        "http://localhost:8080/api/v1/users/U1/snapshot?asOfDate=2025-02-15"
    }

    var path: String { "" }
}
