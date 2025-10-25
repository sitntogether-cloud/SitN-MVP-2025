//
//  PrimaryButtonLabel.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import SwiftUI

struct PrimaryButtonLabel: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
    }
}
