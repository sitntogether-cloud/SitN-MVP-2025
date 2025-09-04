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
                    Text("SitN")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical,75)
                    
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Email", text: $email, onEditingChanged: { _ in self.emailTouched = true }, onCommit: {})
                    }
                    .padding()
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray),
                        alignment: .bottom
                    )
                    .padding(.top, 75)
                    .padding(.bottom, 10)
                    
                    if !isFormValid && emailTouched && email.isEmpty {
                        Text("Email cannot be empty.").foregroundColor(.red).font(.caption)
                    }
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        SecureField("Password", text: passwordBinding)
                    }
                    .padding()
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray),
                        alignment: .bottom
                    )
                    .padding(.bottom, 50)
                    
                    if !isFormValid && passwordTouched && password.isEmpty {
                        Text("Password cannot be empty.").foregroundColor(.red).font(.caption)
                    }
                    
                    Button(action: {
                        if isFormValid {
                            sessionManager.isLoggedIn = true
                        } else {
                            self.emailTouched = true
                            self.passwordTouched = true
                        }
                    }) {
                        Text("Sign In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 375, height: 50)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                    }
                    .padding(.top, 50)
                    .frame(maxWidth: .infinity)
                    
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
                    
                    NavigationLink(destination: SignUpView()) {
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
