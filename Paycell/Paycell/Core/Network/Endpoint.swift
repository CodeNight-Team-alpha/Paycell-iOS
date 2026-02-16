//
//  Endpoint.swift
//  Paycell
//
//  Created by Ebru Bircan on 16.02.2026.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var query: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
    var decoder: JSONDecoder { get }
    var timeout: TimeInterval { get }
    var encoder: JSONEncoder { get }
    
    
}

extension Endpoint {
    var method: HTTPMethod { .get }
    var query: [URLQueryItem]? { nil }
    var headers: [String: String]? { ["Accept": "application/json"] }
    var body: Encodable? { nil }
    var decoder: JSONDecoder { JSONDecoder() }
    var timeout: TimeInterval { 30 }
    var encoder: JSONEncoder { JSONEncoder() }
    
    func makeRequest() throws -> URLRequest {
        guard let baseURL = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )
        components?.queryItems = query

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(
            url: url,
            timeoutInterval: timeout
        )
        
        request.httpMethod = method.rawValue
        
        if let headers {
            request.allHTTPHeaderFields = headers
        }
        
        if let body {
            request.httpBody = try encoder.encode(body)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}
