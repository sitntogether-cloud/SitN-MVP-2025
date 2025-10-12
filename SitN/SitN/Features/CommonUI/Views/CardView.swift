//
//  CardView.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import SwiftUI

struct CardView: View {
    var headline: String
    var title: String
    var subheadline: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(headline)
                .font(.headline)
                .foregroundColor(.secondary)
            Text(title)
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.primary)
                .lineLimit(3)
            Text(subheadline.uppercased())
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    CardView(headline: "Featured", title: "New York's Best Kept Secret", subheadline: "A review of a classic diner.")
        .padding()
}