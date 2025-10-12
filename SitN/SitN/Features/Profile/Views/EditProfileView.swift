//
//  ProfileView.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var isEditing = false

    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                    .padding(.top, 50)

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
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10)
                .padding(.horizontal)


                
                Spacer()
            }
        }
        .navigationTitle("My Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(isEditing ? "Done" : "Edit") {
            isEditing.toggle()
        })
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