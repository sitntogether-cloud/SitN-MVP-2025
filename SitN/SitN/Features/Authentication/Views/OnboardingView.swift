//
//  OnboardingView.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @StateObject private var viewModel = OnboardingViewModel()
    @State private var tabSelection = 0

    // Touched states
    @State private var firstNameTouched = false
    @State private var lastNameTouched = false
    @State private var emailTouched = false
    @State private var ageTouched = false
    @State private var phoneNumberTouched = false
    @State private var zipCodeTouched = false
    @State private var heightTouched = false
    @State private var ethnicityTouched = false
    @State private var hometownTouched = false
    @State private var occupationTouched = false
    @State private var astrologicalSignTouched = false

    var body: some View {
        TabView(selection: $tabSelection) {
            // Page 1: Welcome
            VStack(spacing: 20) {
                Spacer()
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                Text("Welcome to SitN")
                    .font(.largeTitle).fontWeight(.bold)
                Text("Let's get you set up.")
                    .font(.title2)
                Spacer()
                Button("Let's Go!") {
                    withAnimation {
                        tabSelection = 1
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding()
            }
            .tag(0)

            // Page 2: Basic Info
            Form {
                Section(header: Text("Basic Information")) {
                    TextField("First Name", text: $viewModel.firstName, onEditingChanged: { _ in firstNameTouched = true })
                    if !viewModel.isFirstNameValid && firstNameTouched {
                        Text("First name cannot be empty.").foregroundColor(.red).font(.caption)
                    }
                    
                    TextField("Last Name", text: $viewModel.lastName, onEditingChanged: { _ in lastNameTouched = true })
                    if !viewModel.isLastNameValid && lastNameTouched {
                        Text("Last name cannot be empty.").foregroundColor(.red).font(.caption)
                    }

                    TextField("Email", text: $viewModel.email, onEditingChanged: { _ in emailTouched = true })
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    if !viewModel.isEmailValid && emailTouched {
                        Text("Please enter a valid email address.").foregroundColor(.red).font(.caption)
                    }

                    TextField("Age", value: $viewModel.age, formatter: NumberFormatter(), onEditingChanged: { _ in ageTouched = true })
                        .keyboardType(.numberPad)
                    if !viewModel.isAgeValid && ageTouched {
                        Text("Please enter a valid age (18-100).").foregroundColor(.red).font(.caption)
                    }
                }
                Section {
                    Button("Next") {
                        withAnimation {
                            tabSelection = 2
                        }
                    }
                    .disabled(!viewModel.isPage2Valid)
                    .buttonStyle(PrimaryButtonStyle())
                }
            }
            .tag(1)

            // Page 3: Contact Info
            Form {
                Section(header: Text("Contact Information")) {
                    TextField("Phone Number", text: $viewModel.phoneNumber, onEditingChanged: { _ in phoneNumberTouched = true })
                        .keyboardType(.phonePad)
                    if !viewModel.isPhoneNumberValid && phoneNumberTouched {
                        Text("Please enter a valid phone number.").foregroundColor(.red).font(.caption)
                    }

                    TextField("Zip Code", text: $viewModel.zipCode, onEditingChanged: { _ in zipCodeTouched = true })
                        .keyboardType(.numberPad)
                    if !viewModel.isZipCodeValid && zipCodeTouched {
                        Text("Please enter a valid 5-digit zip code.").foregroundColor(.red).font(.caption)
                    }
                }
                Section {
                    Button("Next") {
                        withAnimation {
                            tabSelection = 3
                        }
                    }
                    .disabled(!viewModel.isPage3Valid)
                    .buttonStyle(PrimaryButtonStyle())
                }
            }
            .tag(2)

            // Page 4: Profile Info
            Form {
                Section(header: Text("Profile Information")) {
                    TextField("Height", text: $viewModel.height, onEditingChanged: { _ in heightTouched = true })
                    if !viewModel.isHeightValid && heightTouched {
                        Text("Height cannot be empty.").foregroundColor(.red).font(.caption)
                    }
                    TextField("Ethnicity", text: $viewModel.ethnicity, onEditingChanged: { _ in ethnicityTouched = true })
                    if !viewModel.isEthnicityValid && ethnicityTouched {
                        Text("Ethnicity cannot be empty.").foregroundColor(.red).font(.caption)
                    }
                    TextField("Hometown", text: $viewModel.hometown, onEditingChanged: { _ in hometownTouched = true })
                    if !viewModel.isHometownValid && hometownTouched {
                        Text("Hometown cannot be empty.").foregroundColor(.red).font(.caption)
                    }
                    TextField("Occupation", text: $viewModel.occupation, onEditingChanged: { _ in occupationTouched = true })
                    if !viewModel.isOccupationValid && occupationTouched {
                        Text("Occupation cannot be empty.").foregroundColor(.red).font(.caption)
                    }
                    TextField("Astrological Sign", text: $viewModel.astrologicalSign, onEditingChanged: { _ in astrologicalSignTouched = true })
                    if !viewModel.isAstrologicalSignValid && astrologicalSignTouched {
                        Text("Astrological Sign cannot be empty.").foregroundColor(.red).font(.caption)
                    }
                }
                Section {
                    Button("Next") {
                        withAnimation {
                            tabSelection = 4
                        }
                    }
                    .disabled(!viewModel.isPage4Valid)
                    .buttonStyle(PrimaryButtonStyle())
                }
            }
            .tag(3)

            // Page 5: Finish
            VStack(spacing: 20) {
                Spacer()
                Text("You're all set!")
                    .font(.largeTitle).fontWeight(.bold)
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
                Spacer()
                Button("Create Account") {
                    sessionManager.userName = viewModel.firstName
                    sessionManager.isLoggedIn = true
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding()
            }
            .tag(4)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .navigationBarTitle("Sign Up")
    }
}

#Preview {
    OnboardingView()
}