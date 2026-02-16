//
//  NetworkManager.swift
//  Paycell
//
//  Created by Ebru Bircan on 16.02.2026.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(endPoint: Endpoint) async throws -> T
    func send(endPoint: Endpoint) async throws
    func fetchData(endPoint: Endpoint) async throws -> Data
}

final class NetworkManager: NetworkManagerProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T>(endPoint: Endpoint) async throws -> T where T : Decodable {
        let data = try await performRequest(endPoint)
        do {
            return try endPoint.decoder.decode(T.self, from: data.0)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func send(endPoint: Endpoint) async throws {
        _ = try await performRequest(endPoint)
    }
    
    func fetchData(endPoint: Endpoint) async throws -> Data {
        let (data, _) = try await performRequest(endPoint)
        return data
    }
    
    private func performRequest(_ endPoint: Endpoint) async throws -> (Data, HTTPURLResponse) {
        let request = try endPoint.makeRequest()
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badStatus(code: httpResponse.statusCode)
            }
            
            guard !data.isEmpty else {
                throw NetworkError.noData
            }
            
            return (data, httpResponse)
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                throw NetworkError.cancelled
            }
            
            throw NetworkError.network(error)
        }
    }
}
