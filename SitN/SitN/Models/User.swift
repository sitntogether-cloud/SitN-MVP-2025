//
//  User.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let favoriteCuisine: Cuisine
    let imageName: String
}
