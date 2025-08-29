//
//  GoogleSignInButtonView.swift
//  SitN
//
//  Created by Gilbert Colón on 8/2/25.
//
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


struct GoogleSignInButtonView: UIViewRepresentable {
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.style = .wide
        button.colorScheme = .dark
        return button
    }

    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
        
        // No updates needed in this simple case
    }
}
