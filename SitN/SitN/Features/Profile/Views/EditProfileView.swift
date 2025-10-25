//
//  ProfileView.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isEditing = false

    // Temporary storage for original values
    @State private var originalHeight = ""
    @State private var originalEthnicity = ""
    @State private var originalHometown = ""
    @State private var originalOccupation = ""
    @State private var originalAstrologicalSign = ""

    @State private var selectedPhoto: PhotosPickerItem?
    @State private var profileImage: Image?

    var body: some View {
        ScrollView {
            VStack {
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    if let profileImage {
                        profileImage
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 50)
                .onChange(of: selectedPhoto) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                profileImage = Image(uiImage: uiImage)
                            }
                        }
                    }
                }

                CardView(
                    headline: "Latest Activity",
                    title: "Reviewed a new spot in \(viewModel.hometown)",
                    subheadline: "As a \(viewModel.occupation)"
                )
                    .padding()

                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                VStack {
                    HStack {
                        Text("Height")
                        Spacer()
                        if isEditing {
                            TextField("Not set", text: $viewModel.height)
                                .multilineTextAlignment(.trailing)
                        } else {
                            Text(viewModel.height)
                        }
                    }
                    Divider()
                    HStack {
                        Text("Ethnicity")
                        Spacer()
                        if isEditing {
                            TextField("Not set", text: $viewModel.ethnicity)
                                .multilineTextAlignment(.trailing)
                        } else {
                            Text(viewModel.ethnicity)
                        }
                    }
                    Divider()
                    HStack {
                        Text("Hometown")
                        Spacer()
                        if isEditing {
                            TextField("Not set", text: $viewModel.hometown)
                                .multilineTextAlignment(.trailing)
                        } else {
                            Text(viewModel.hometown)
                        }
                    }
                    Divider()
                    HStack {
                        Text("Occupation")
                        Spacer()
                        if isEditing {
                            TextField("Not set", text: $viewModel.occupation)
                                .multilineTextAlignment(.trailing)
                        } else {
                            Text(viewModel.occupation)
                        }
                    }
                    Divider()
                    HStack {
                        Text("Astrological Sign")
                        Spacer()
                        if isEditing {
                            TextField("Not set", text: $viewModel.astrologicalSign)
                                .multilineTextAlignment(.trailing)
                        } else {
                            Text(viewModel.astrologicalSign)
                        }
                    }
                }
                .padding()
                .background(isEditing ? Color(.systemGray6) : Color(UIColor.systemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            HStack {
                if isEditing {
                    Button("Cancel") {
                        // Revert changes
                        viewModel.height = originalHeight
                        viewModel.ethnicity = originalEthnicity
                        viewModel.hometown = originalHometown
                        viewModel.occupation = originalOccupation
                        viewModel.astrologicalSign = originalAstrologicalSign
                        isEditing = false
                    }
                    Button("Save") {
                        // Save changes logic would go here
                        isEditing = false
                    }
                } else {
                    Button("Edit") {
                        // Store original values
                        originalHeight = viewModel.height
                        originalEthnicity = viewModel.ethnicity
                        originalHometown = viewModel.hometown
                        originalOccupation = viewModel.occupation
                        originalAstrologicalSign = viewModel.astrologicalSign
                        isEditing = true
                    }
                }
            }
        )
        .onAppear {
            viewModel.loadUserData()
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}