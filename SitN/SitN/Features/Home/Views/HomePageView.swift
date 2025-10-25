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
    @State private var isCuisineSelected = false

    private var welcomeMessage: String {
        if let name = sessionManager.userName {
            return "WHERE DO YOU WANT TO SITN TODAY, \(name.uppercased())?"
        } else {
            return "WHERE DO YOU WANT TO SITN TODAY?"
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all)
                VStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                        .navigationBarBackButtonHidden(true)

                    Spacer()
                        .frame(maxHeight: 50)

                    Text(welcomeMessage)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.bottom, 100)

                    Picker(selection: $selectedCuisine) {
                        Text("Select Cuisine").tag(nil as Cuisine?)
                        ForEach(Cuisine.allCases) { cuisine in
                            Text(cuisine.rawValue).tag(cuisine as Cuisine?)
                        }
                    } label: {
                        HStack {
                            Text(selectedCuisine?.rawValue ?? "Select Cuisine")
                                .font(.headline)
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedCuisine) { newValue in
                        if newValue != nil {
                            isCuisineSelected = true
                        }
                    }
                    
                    if let selectedCuisine {
                        NavigationLink(
                            destination: RestaurantSelectionView(cuisine: selectedCuisine),
                            isActive: $isCuisineSelected,
                            label: { EmptyView() }
                        )
                    }
                    
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
            .onReceive(sessionManager.$popToRoot) { shouldPop in
                if shouldPop {
                    isCuisineSelected = false
                    selectedCuisine = nil
                    sessionManager.popToRoot = false // Reset the flag
                }
            }
        }
    }
}

#Preview {
    HomePageView()
}
