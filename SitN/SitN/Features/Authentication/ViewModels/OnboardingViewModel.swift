//
//  OnboardingViewModel.swift
//  SitN
//
//  Created by Gemini on 10/12/25.
//

import Combine
import Foundation

class OnboardingViewModel: ObservableObject {
    // Page 2: Basic Info
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var age: Int? = nil

    // Page 3: Contact Info
    @Published var phoneNumber = ""
    @Published var zipCode = ""

    // Page 4: Profile Info
    @Published var height = ""
    @Published var ethnicity = ""
    @Published var hometown = ""
    @Published var occupation = ""
    @Published var astrologicalSign = ""

    // Validation
    @Published var isFirstNameValid = false
    @Published var isLastNameValid = false
    @Published var isEmailValid = false
    @Published var isAgeValid = false
    @Published var isPhoneNumberValid = false
    @Published var isZipCodeValid = false
    @Published var isHeightValid = false
    @Published var isEthnicityValid = false
    @Published var isHometownValid = false
    @Published var isOccupationValid = false
    @Published var isAstrologicalSignValid = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        $firstName
            .map { !$0.isEmpty }
            .assign(to: \.isFirstNameValid, on: self)
            .store(in: &cancellables)

        $lastName
            .map { !$0.isEmpty }
            .assign(to: \.isLastNameValid, on: self)
            .store(in: &cancellables)

        $email
            .map { Validators.isEmailValid($0) }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)

        $age
            .map { Validators.isAgeValid($0) }
            .assign(to: \.isAgeValid, on: self)
            .store(in: &cancellables)

        $phoneNumber
            .map { Validators.isPhoneNumberValid($0) }
            .assign(to: \.isPhoneNumberValid, on: self)
            .store(in: &cancellables)

        $zipCode
            .map { Validators.isZipCodeValid($0) }
            .assign(to: \.isZipCodeValid, on: self)
            .store(in: &cancellables)
            
        $height
            .map { !$0.isEmpty }
            .assign(to: \.isHeightValid, on: self)
            .store(in: &cancellables)
            
        $ethnicity
            .map { !$0.isEmpty }
            .assign(to: \.isEthnicityValid, on: self)
            .store(in: &cancellables)
            
        $hometown
            .map { !$0.isEmpty }
            .assign(to: \.isHometownValid, on: self)
            .store(in: &cancellables)
            
        $occupation
            .map { !$0.isEmpty }
            .assign(to: \.isOccupationValid, on: self)
            .store(in: &cancellables)
            
        $astrologicalSign
            .map { !$0.isEmpty }
            .assign(to: \.isAstrologicalSignValid, on: self)
            .store(in: &cancellables)
    }
    
    var isPage2Valid: Bool {
        isFirstNameValid && isLastNameValid && isEmailValid && isAgeValid
    }

    var isPage3Valid: Bool {
        isPhoneNumberValid && isZipCodeValid
    }

    var isPage4Valid: Bool {
        isHeightValid && isEthnicityValid && isHometownValid && isOccupationValid && isAstrologicalSignValid
    }
}