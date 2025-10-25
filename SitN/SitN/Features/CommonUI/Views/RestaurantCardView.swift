//
//  RestaurantCardView.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import SwiftUI

struct RestaurantCardView: View {
    let restaurant: Restaurant
    var isSelected: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(restaurant.name)
                .font(.headline)
            HStack {
                Text(String(format: "%.1f mi", restaurant.distance))
                Spacer()
                Text(String(repeating: "$", count: restaurant.price))
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(isSelected ? Color.blue.opacity(0.2) : Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
    }
}

#Preview {
    RestaurantCardView(restaurant: Restaurant(name: "The Golden Spoon", distance: 1.2, price: 3), isSelected: true)
        .padding()
}