//
//  CreateProfileView.swift
//  SitN
//
//  Created by Gilbert Colón on 9/3/25.
//

import SwiftUI

struct CreateProfileView: View {
    @StateObject private var viewModel = CreateProfileViewModel()

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Profile Information")) {
                    TextField("Height", text: $viewModel.height)
                    TextField("Ethnicity", text: $viewModel.ethnicity)
                    TextField("Hometown", text: $viewModel.hometown)
                    TextField("Occupation", text: $viewModel.occupation)
                    TextField("Astrological Sign", text: $viewModel.astrologicalSign)
                }
            }
            
            Button(action: {
                // Create profile action
            }) {
                Text("Create Profile")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            .disabled(!viewModel.isFormValid)
            .padding()

        }
        .navigationTitle("Create Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        CreateProfileView()
    }
}
