//
//  UserCardView.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import SwiftUI

struct UserCardView: View {
    let user: User
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Image(systemName: user.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text("Age: \(user.age)")
                    .font(.subheadline)
                Text("Loves: \(user.favoriteCuisine.rawValue)")
                    .font(.subheadline)
            }
            
            Spacer()
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
    UserCardView(user: User(name: "Jane Doe", age: 28, favoriteCuisine: .italian, imageName: "person.fill"), isSelected: true)
        .padding()
}