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
    @State private var isNavigationActive = false

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
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            VStack {
                Form {
                    Section(header: Text("Personal Information")) {
                        TextField("First Name", text: $viewModel.firstName, onEditingChanged: { isEditing in
                            if !isEditing {
                                self.firstNameTouched = true
                            }
                        }, onCommit: {})
                        if !viewModel.isFirstNameValid && firstNameTouched {
                            Text("First name cannot be empty.").foregroundColor(.red).font(.caption)
                        }
                        
                        TextField("Last Name", text: $viewModel.lastName, onEditingChanged: { isEditing in
                            if !isEditing {
                                self.lastNameTouched = true
                            }
                        }, onCommit: {})
                        if !viewModel.isLastNameValid && lastNameTouched {
                            Text("Last name cannot be empty.").foregroundColor(.red).font(.caption)
                        }
                        
                        TextField("Email", text: $viewModel.email, onEditingChanged: { isEditing in
                            if !isEditing {
                                self.emailTouched = true
                            }
                        }, onCommit: {})
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        if !viewModel.isEmailValid && emailTouched {
                            Text("Please enter a valid email address.").foregroundColor(.red).font(.caption)
                        }
                        
                        TextField("Age", value: $viewModel.age, formatter: ageFormatter, onEditingChanged: { isEditing in
                            if !isEditing {
                                self.ageTouched = true
                            }
                        }, onCommit: {})
                            .keyboardType(.numberPad)
                        if !viewModel.isAgeValid && ageTouched {
                            Text("Please enter a valid age.").foregroundColor(.red).font(.caption)
                        }
                    }
                    
                    Section(header: Text("Contact Information")) {
                        TextField("Phone Number", text: $viewModel.phoneNumber, onEditingChanged: { isEditing in
                            if !isEditing {
                                self.phoneNumberTouched = true
                            }
                        }, onCommit: {})
                            .keyboardType(.phonePad)
                        if !viewModel.isPhoneNumberValid && phoneNumberTouched {
                            Text("Please enter a valid phone number.").foregroundColor(.red).font(.caption)
                        }
                        
                        TextField("Zip Code", text: zipCodeBinding, onEditingChanged: { isEditing in
                            if !isEditing {
                                self.zipCodeTouched = true
                            }
                        }, onCommit: {})
                            .keyboardType(.numberPad)
                        if !viewModel.isZipCodeValid && zipCodeTouched {
                            Text("Please enter a valid zip code.").foregroundColor(.red).font(.caption)
                        }
                    }
                }
                
                VStack {
                    NavigationLink(destination: CreateProfileView(), isActive: $isNavigationActive) { EmptyView() }

                    Button(action: {
                        if viewModel.isFormValid {
                            self.isNavigationActive = true
                        } else {
                            self.firstNameTouched = true
                            self.lastNameTouched = true
                            self.emailTouched = true
                            self.ageTouched = true
                            self.phoneNumberTouched = true
                            self.zipCodeTouched = true
                        }
                    }) {
                        Text("Create Account")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    .padding()
                }
                .background(Color.clear)
            }
        }
        .navigationBarTitle("Create Account")
    }
}

#Preview {
    NavigationView {
        SignUpView()
    }
}