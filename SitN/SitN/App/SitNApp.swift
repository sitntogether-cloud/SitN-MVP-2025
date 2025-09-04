//
//  SitNApp.swift
//  SitN
//
//  Created by Gilbert Colón on 8/2/25.
//

import SwiftUI

@main
struct SitNApp: App {
    @StateObject private var sessionManager = SessionManager()

    var body: some Scene {
        WindowGroup {
            if sessionManager.isLoggedIn {
                NavigationView {
                    HomePageView()
                }
                .environmentObject(sessionManager)
            } else {
                LogInView()
                    .environmentObject(sessionManager)
            }
        }
    }
}
