//
//  ProfileViewModel.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var height = ""
    @Published var ethnicity = ""
    @Published var hometown = ""
    @Published var occupation = ""
    @Published var astrologicalSign = ""
    
    func loadUserData() {
        self.height = "5'10\""
        self.ethnicity = "Hispanic"
        self.hometown = "New York"
        self.occupation = "Software Engineer"
        self.astrologicalSign = "Leo"
    }
}