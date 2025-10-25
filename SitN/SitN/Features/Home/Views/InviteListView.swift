//
//  InviteListView.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import SwiftUI

enum SendingState {
    case idle, sending, sent
}

struct InviteListView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var selectedUserIDs: [UUID] = []
    @State private var sendingState: SendingState = .idle
    @State private var searchText = ""

    // Mock data
    let users: [User] = [
        User(name: "John Appleseed", age: 32, favoriteCuisine: .american, imageName: "person.crop.circle.fill"),
        User(name: "Jane Doe", age: 28, favoriteCuisine: .italian, imageName: "person.crop.circle.fill"),
        User(name: "Peter Jones", age: 45, favoriteCuisine: .mexican, imageName: "person.crop.circle.fill"),
        User(name: "Mary Smith", age: 22, favoriteCuisine: .chinese, imageName: "person.crop.circle.fill")
    ]

    var filteredUsers: [User] {
        users.filter { user in
            searchText.isEmpty || user.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ZStack {
            VStack {
                Text("Invite Others")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                HStack {
                    TextField("Search friends", text: $searchText)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                            }
                        )
                }
                .padding()

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(filteredUsers) { user in
                            UserCardView(user: user, isSelected: selectedUserIDs.contains(user.id))
                                .onTapGesture {
                                    if selectedUserIDs.contains(user.id) {
                                        selectedUserIDs.removeAll { $0 == user.id }
                                    } else {
                                        selectedUserIDs.append(user.id)
                                    }
                                }
                        }
                    }
                    .padding()
                }

                Spacer()

                if !selectedUserIDs.isEmpty {
                    HStack {
                        Button(action: {
                            sendingState = .sending
                        }) {
                            Text(selectedUserIDs.count == 1 ? "Send SitN Invite" : "Send SitN Invites")
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        Spacer()
                    }
                    .padding()
                }
            }

            if sendingState != .idle {
                Color.black.opacity(0.7).edgesIgnoringSafeArea(.all)
                
                switch sendingState {
                case .sending:
                    ProgressView("Sending Invites...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .foregroundColor(.white)
                case .sent:
                    VStack {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.green)
                        Text("Invites Sent!")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    }
                case .idle:
                    EmptyView()
                }
            }
        }
        .navigationTitle("Invite List")
        .onChange(of: sendingState) { newState in
            if newState == .sending {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    sendingState = .sent
                }
            } else if newState == .sent {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    sessionManager.popToRoot = true
                }
            }
        }
    }
}

#Preview {
    InviteListView()
}
