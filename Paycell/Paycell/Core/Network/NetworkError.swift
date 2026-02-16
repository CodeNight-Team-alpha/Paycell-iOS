//
//  NetworkError.swift
//  Paycell
//
//  Created by Ebru Bircan on 16.02.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badStatus(code: Int)
    case decodingError(Error)
    case network(Error)
    case noData
    case cancelled
    case unknown
}

extension NetworkError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .badStatus(let code):
            return "Bad status code: \(code)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .network(let error):
            return "Network error: \(error.localizedDescription)"
        case .noData:
            return "No data returned"
        case .cancelled:
            return "Request was cancelled"
        case .unknown:
            return "Unknown error"
        }
    }
}
