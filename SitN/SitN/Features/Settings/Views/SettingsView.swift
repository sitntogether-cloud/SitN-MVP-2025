//
//  SettingsView.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showAlert = false

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            VStack {
                Form {
                    Section(header: Text("Notifications")) {
                        Toggle("Enable Notifications", isOn: $viewModel.enableNotifications)
                    }
                    
                    Section(header: Text("Appearance")) {
                        Picker("Dark Mode", selection: $viewModel.darkMode) {
                            ForEach(viewModel.darkModeOptions, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                    Section(header: Text("Language")) {
                        Picker("Language", selection: $viewModel.language) {
                            ForEach(viewModel.languageOptions, id: \.self) {
                                Text($0)
                            }
                        }
                    }

                    Section {
                        Button(action: {
                            sessionManager.isLoggedIn = false
                        }) {
                            Text("Sign Out")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Button(action: {
                    viewModel.saveSettings()
                    self.showAlert = true
                }) {
                    Text("Save")
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            
            if showAlert {
                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Settings Saved")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.showAlert = false
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        SettingsView()
    }
}
