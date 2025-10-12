//
//  SettingsViewModel.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var enableNotifications = true
    @Published var darkMode = "System"
    @Published var language = "English"

    let darkModeOptions = ["System", "Light", "Dark"]
    let languageOptions = ["English", "Spanish", "French"]
    
    func saveSettings() {
        // Save settings logic
    }
}
