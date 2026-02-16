//
//  PaycellService.swift
//  Paycell
//
//  Created by Ebru Bircan on 16.02.2026.
//

import Foundation

protocol PaycellServiceProtocol {
    
}

final class PaycellService: PaycellServiceProtocol {
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
}
