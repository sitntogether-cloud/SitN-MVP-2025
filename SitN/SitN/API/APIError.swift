//
//  APIError.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingError(Error)
    case invalidResponse
}
