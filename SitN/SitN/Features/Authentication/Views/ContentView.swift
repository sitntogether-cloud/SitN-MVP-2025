//
//  ContentView.swift
//  SitN
//
//  Created by Gilbert Colón on 8/2/25.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private let emailIconName = "Icon_Email"
    private let passwordIconName = "Icon_Password"

    var body: some View {
        
        NavigationView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color(.lightBlue), Color(.darkerLightBlue)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all) // Extend the gradient to fill the safe areas
                
                VStack {
                    Text("SitN")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical,75)
                    
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                        TextField("Email", text: $email)
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
                    
                    
                    
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                        SecureField("Password", text: $password)
                    }
                    .padding()
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray),
                        alignment: .bottom
                    )
                    .padding(.bottom, 50)
                    
                    
                    
                    Button(action: {
                        // Mock action
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
    ContentView()
}
