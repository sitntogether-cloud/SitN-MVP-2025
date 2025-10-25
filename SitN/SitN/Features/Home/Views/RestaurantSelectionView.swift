//
//  RestaurantSelectionView.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import SwiftUI

enum SortOption: String, CaseIterable {
    case distance = "Distance"
    case price = "Price"
}

struct RestaurantSelectionView: View {
    let cuisine: Cuisine
    @State private var selectedRestaurant: Restaurant?
    @State private var searchText = ""
    @State private var sortBy: SortOption = .distance

    // Mock data
    let restaurants: [Restaurant] = [
        Restaurant(name: "The Salty Pig", distance: 0.8, price: 2),
        Restaurant(name: "Neptune Oyster", distance: 1.5, price: 4),
        Restaurant(name: "Giulia", distance: 2.1, price: 3),
        Restaurant(name: "The Capital Grille", distance: 0.5, price: 4),
        Restaurant(name: "Union Oyster House", distance: 1.1, price: 3)
    ]

    var filteredAndSortedRestaurants: [Restaurant] {
        let filtered = restaurants.filter { restaurant in
            searchText.isEmpty || restaurant.name.localizedCaseInsensitiveContains(searchText)
        }

        switch sortBy {
        case .distance:
            return filtered.sorted { $0.distance < $1.distance }
        case .price:
            return filtered.sorted { $0.price < $1.price }
        }
    }

    var body: some View {
        VStack {
            Text("\(cuisine.rawValue) restaurants in your area.")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            HStack {
                TextField("Search restaurants", text: $searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                        }
                    )
            }
            .padding()

            Picker("Sort by", selection: $sortBy) {
                ForEach(SortOption.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            ScrollView {
                VStack(spacing: 15) {
                    ForEach(filteredAndSortedRestaurants) { restaurant in
                        RestaurantCardView(restaurant: restaurant, isSelected: selectedRestaurant?.id == restaurant.id)
                            .onTapGesture {
                                selectedRestaurant = restaurant
                            }
                    }
                }
                .padding()
            }
            
            if let selectedRestaurant {
                Text("Selected: \(selectedRestaurant.name)")
                    .padding()
                
                NavigationLink(destination: TimeSelectionView()) {
                    PrimaryButtonLabel(text: "Next")
                }
                .padding()
            }

            Spacer()
        }
        .navigationTitle("Select a Restaurant")
    }
}

#Preview {
    RestaurantSelectionView(cuisine: .american)
}