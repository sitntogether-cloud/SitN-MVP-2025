//
//  Endpoints.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import Foundation

enum Endpoint {
    case getRestaurants(cuisine: String)
    case getUserProfile(userID: String)
    case updateProfile(userID: String, profileData: [String: Any])

    var path: String {
        switch self {
        case .getRestaurants: return "/restaurants"
        case .getUserProfile(let userID): return "/users/\(userID)"
        case .updateProfile(let userID): return "/users/\(userID)"
        }
    }

    var method: String {
        switch self {
        case .getRestaurants, .getUserProfile: return "GET"
        case .updateProfile: return "PUT"
        }
    }
}
