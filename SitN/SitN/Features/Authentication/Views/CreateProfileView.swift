//
//  CreateProfileView.swift
//  SitN
//
//  Created by Gilbert Colón on 9/3/25.
//

import SwiftUI

struct CreateProfileView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @StateObject private var viewModel = CreateProfileViewModel()
    @State private var heightTouched = false
    @State private var ethnicityTouched = false
    @State private var hometownTouched = false
    @State private var occupationTouched = false
    @State private var astrologicalSignTouched = false

    @State private var showAlert = false

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            VStack {
                Form {
                    Section(header: Text("Profile Information")) {
                        TextField("Height", text: $viewModel.height, onEditingChanged: { isEditing in
                            if !isEditing {
                                self.heightTouched = true
                            }
                        }, onCommit: {})
                        if !viewModel.isHeightValid && heightTouched {
                            Text("Height cannot be empty.").foregroundColor(.red).font(.caption)
                        }
                        
                        TextField("Ethnicity", text: $viewModel.ethnicity, onEditingChanged: { isEditing in
                            if !isEditing {
                                self.ethnicityTouched = true
                            }
                        }, onCommit: {})
                        if !viewModel.isEthnicityValid && ethnicityTouched {
                            Text("Ethnicity cannot be empty.").foregroundColor(.red).font(.caption)
                        }
                        
                        TextField("Hometown", text: $viewModel.hometown, onEditingChanged: { isEditing in
                            if !isEditing {
                                self.hometownTouched = true
                            }
                        }, onCommit: {})
                        if !viewModel.isHometownValid && hometownTouched {
                            Text("Hometown cannot be empty.").foregroundColor(.red).font(.caption)
                        }
                        
                        TextField("Occupation", text: $viewModel.occupation, onEditingChanged: { isEditing in
                            if !isEditing {
                                self.occupationTouched = true
                            }
                        }, onCommit: {})
                        if !viewModel.isOccupationValid && occupationTouched {
                            Text("Occupation cannot be empty.").foregroundColor(.red).font(.caption)
                        }
                        
                        TextField("Astrological Sign", text: $viewModel.astrologicalSign, onEditingChanged: { isEditing in
                            if !isEditing {
                                self.astrologicalSignTouched = true
                            }
                        }, onCommit: {})
                        if !viewModel.isAstrologicalSignValid && astrologicalSignTouched {
                            Text("Astrological Sign cannot be empty.").foregroundColor(.red).font(.caption)
                        }
                    }
                }
                
                Button(action: {
                    if viewModel.isFormValid {
                        self.showAlert = true
                    } else {
                        self.heightTouched = true
                        self.ethnicityTouched = true
                        self.hometownTouched = true
                        self.occupationTouched = true
                        self.astrologicalSignTouched = true
                    }
                }) {
                    Text("Create Profile")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .padding()

            }
            .navigationTitle("Create Profile")
            .navigationBarTitleDisplayMode(.inline)
            
            if showAlert {
                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Profile Created")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showAlert = false
                        sessionManager.isLoggedIn = true
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        CreateProfileView()
    }
}
