//
//  APIService.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    private init() {}

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        // Placeholder implementation
        fatalError("Not implemented")
    }
}
