//
//  CreateProfileViewModel.swift
//  SitN
//
//  Created by Gilbert Colón on 9/3/25.
//

import Foundation
import Combine

class CreateProfileViewModel: ObservableObject {
    @Published var height = ""
    @Published var ethnicity = ""
    @Published var hometown = ""
    @Published var occupation = ""
    @Published var astrologicalSign = ""

    var isFormValid: Bool {
        !height.isEmpty && !ethnicity.isEmpty && !hometown.isEmpty && !occupation.isEmpty && !astrologicalSign.isEmpty
    }
}
