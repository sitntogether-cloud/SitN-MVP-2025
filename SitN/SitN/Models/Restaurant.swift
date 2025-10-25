//
//  Restaurant.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import Foundation

struct Restaurant: Identifiable {
    let id = UUID()
    let name: String
    let distance: Double
    let price: Int // 1 to 4
}
