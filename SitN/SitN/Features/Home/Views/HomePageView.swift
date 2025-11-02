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
                        .frame(maxHeight: 30)

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

                HStack {
                    Spacer()
                    ZStack {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.gray)
                        
                        // Badge
                        ZStack {
                            Circle()
                                .fill(Color.red)
                            Text("3") // Mock number of invites
                                .font(.caption2)
                                .foregroundColor(.white)
                        }
                        .frame(width: 15, height: 15)
                        .offset(x: 10, y: -10)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
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
