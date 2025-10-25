//
//  SessionManager.swift
//  SitN
//
//  Created by Gilbert Colón on 9/4/25.
//

import Combine

class SessionManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var popToRoot = false
    @Published var userName: String? = nil
}
