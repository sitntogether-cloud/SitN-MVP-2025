//
//  HomePageView.swift
//  SitN
//
//  Created by Gilbert Colón on 9/4/25.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var sessionManager: SessionManager

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
            VStack {
                Text("SitN")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .navigationBarBackButtonHidden(true)
                
                Spacer()
                
                Button(action: {
                    sessionManager.isLoggedIn = false
                }) {
                    Text("Sign Out")
                        .foregroundColor(.red)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 1)
                )
            }
        }
    }
}

#Preview {
    HomePageView()
}
