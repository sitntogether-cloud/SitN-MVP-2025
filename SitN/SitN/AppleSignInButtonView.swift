//
//  AppleSignInButtonView.swift
//  SitN
//
//  Created by Gilbert Colón on 8/2/25.
//

import SwiftUI
import AuthenticationServices


struct AppleSignInButtonView: UIViewRepresentable {
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        
        
        return button
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
        // No updates needed in this simple case
    }
}
