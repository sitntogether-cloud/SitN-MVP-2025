//
//  ContentView.swift
//  SitN
//
//  Created by Gilbert Colón on 8/2/25.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct LogInView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var emailTouched = false
    @State private var passwordTouched = false
    
    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    private var passwordBinding: Binding<String> {
        Binding<String>(
            get: { self.password },
            set: {
                self.password = $0
                self.passwordTouched = true
            }
        )
    }

    var body: some View {
        
        NavigationView {
            ZStack{
                Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
                VStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .padding(.vertical, 50)
                    
                    VStack {
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.gray)
                            TextField("Email", text: $email, onEditingChanged: { _ in self.emailTouched = true }, onCommit: {})
                        }
                        .padding()
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(email.isEmpty && emailTouched ? .red : .gray),
                            alignment: .bottom
                        )
                        
                        if email.isEmpty && emailTouched {
                            Text("Email cannot be empty.").foregroundColor(.red).font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.top, 75)
                    .padding(.bottom, 10)
                    
                    VStack {
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(.gray)
                            SecureField("Password", text: passwordBinding)
                        }
                        .padding()
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(password.isEmpty && passwordTouched ? .red : .gray),
                            alignment: .bottom
                        )

                        if password.isEmpty && passwordTouched {
                            Text("Password cannot be empty.").foregroundColor(.red).font(.caption)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.bottom, 50)
                    
                    Button(action: {
                        if isFormValid {
                            sessionManager.userName = "John"
                            sessionManager.isLoggedIn = true
                        } else {
                            self.emailTouched = true
                            self.passwordTouched = true
                        }
                    }) {
                        Text("Sign In")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(!isFormValid)
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    HStack {
                        Rectangle().frame(height: 1).foregroundColor(.gray)
                        Text("OR").padding(.horizontal)
                        Rectangle().frame(height: 1).foregroundColor(.gray)
                    }
                    
                    
                    // Official Google Sign-In Button
                    GoogleSignInButtonView()
                    //.scaledToFit()
                        .frame(height: 50)
                        .onTapGesture {
                            alertMessage = "Google Sign-In is not yet implemented."
                            showAlert = true
                        }
                    AppleSignInButtonView()
                    //.scaledToFit()
                        .frame(height: 50)
                        .onTapGesture {
                            alertMessage = "Apple Sign-In is not yet implemented."
                            showAlert = true
                        }
                    
                    
                    
                    //.padding()
                    
                    Spacer()
                    
                    NavigationLink(destination: OnboardingView()) {
                        Text("Don't have an account?").foregroundColor(.gray)
                        Text("Sign up").foregroundColor(.blue)
                    }
                }
                .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Feature Not Implemented"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    LogInView()
}