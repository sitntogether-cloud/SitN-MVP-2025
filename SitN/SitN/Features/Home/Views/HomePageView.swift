//
//  HomePageView.swift
//  SitN
//
//  Created by Gilbert Colón on 9/4/25.
//

import SwiftUI

enum Cuisine: String, CaseIterable, Identifiable {
    case american = "American"
    case italian = "Italian"
    case mexican = "Mexican"
    case chinese = "Chinese"
    case indian = "Indian"
    case japanese = "Japanese"
    case mediterranean = "Mediterranean"

    var id: Self { self }
}

struct HomePageView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var selectedCuisine: Cuisine?

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
                VStack {
                    Text("SitN")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .navigationBarBackButtonHidden(true)
                    
                    Spacer()
                    
                    Text("WHERE DO YOU WANT TO SITN TODAY?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()

                    Picker("Select Cuisine", selection: $selectedCuisine) {
                        Text("Select Cuisine").tag(nil as Cuisine?)
                        ForEach(Cuisine.allCases) { cuisine in
                            Text(cuisine.rawValue).tag(cuisine as Cuisine?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    
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
                
                VStack {
                    Spacer()
                    HStack {
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        Spacer()
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomePageView()
}
