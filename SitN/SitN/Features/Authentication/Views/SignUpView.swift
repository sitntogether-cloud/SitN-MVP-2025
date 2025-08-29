//
//  SignUpView.swift
//  SitN
//
//  Created by Gilbert Colón on 8/2/25.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    
    @State private var firstNameTouched = false
    @State private var lastNameTouched = false
    @State private var emailTouched = false
    @State private var ageTouched = false
    @State private var phoneNumberTouched = false
    @State private var zipCodeTouched = false

    private var ageFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimum = 0
        formatter.maximum = 100
        return formatter
    }
    
    private var zipCodeBinding: Binding<String> {
        Binding<String>(
            get: { self.viewModel.zipCode },
            set: {
                let filtered = $0.filter { "0123456789".contains($0) }
                if filtered.count <= 5 {
                    self.viewModel.zipCode = filtered
                }
            }
        )
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Personal Information")) {
                        TextField("First Name", text: $viewModel.firstName, onEditingChanged: { editing in
                            if !editing { self.firstNameTouched = true }
                        })
                        if !viewModel.isFirstNameValid && firstNameTouched {
                            Text("First name cannot be empty").font(.caption).foregroundColor(.red)
                        }
                        
                        TextField("Last Name", text: $viewModel.lastName, onEditingChanged: { editing in
                            if !editing { self.lastNameTouched = true }
                        })
                        if !viewModel.isLastNameValid && lastNameTouched {
                            Text("Last name cannot be empty").font(.caption).foregroundColor(.red)
                        }
                        
                        TextField("Email", text: $viewModel.email, onEditingChanged: { editing in
                            if !editing { self.emailTouched = true }
                        })
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        if !viewModel.isEmailValid && emailTouched {
                            Text("Enter a valid email").font(.caption).foregroundColor(.red)
                        }
                        
                        TextField("Age", value: $viewModel.age, formatter: ageFormatter)
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                self.ageTouched = true
                            }
                        if !viewModel.isAgeValid && ageTouched {
                            Text("Enter a valid age (0-100)").font(.caption).foregroundColor(.red)
                        }
                    }

                    Section(header: Text("Contact Information")) {
                        TextField("Phone Number", text: $viewModel.phoneNumber, onEditingChanged: { editing in
                            if !editing { self.phoneNumberTouched = true }
                        })
                            .keyboardType(.phonePad)
                        if !viewModel.isPhoneNumberValid && phoneNumberTouched {
                            Text("Enter a valid phone number").font(.caption).foregroundColor(.red)
                        }
                        
                        TextField("Zip Code", text: zipCodeBinding)
                            .keyboardType(.numberPad)
                            .onTapGesture {
                                self.zipCodeTouched = true
                            }
                        if !viewModel.isZipCodeValid && zipCodeTouched {
                            Text("Enter a valid 5-digit zip code").font(.caption).foregroundColor(.red)
                        }
                    }
                }
                
                Button(action: {
                    // Create account action
                }) {
                    Text("Create Account")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .disabled(!viewModel.isFormValid)
                .padding()

            }
            .navigationBarTitle("Create Account")
        }
    }
}

#Preview {
    SignUpView()
}
