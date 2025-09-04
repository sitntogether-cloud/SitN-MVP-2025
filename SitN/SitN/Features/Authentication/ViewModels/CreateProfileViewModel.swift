//
//  CreateProfileViewModel.swift
//  SitN
//
//  Created by Gilbert Colón on 9/3/25.
//

import Foundation
import Combine

class CreateProfileViewModel: ObservableObject {
    // Input
    @Published var height = ""
    @Published var ethnicity = ""
    @Published var hometown = ""
    @Published var occupation = ""
    @Published var astrologicalSign = ""

    // Validation
    @Published var isHeightValid = false
    @Published var isEthnicityValid = false
    @Published var isHometownValid = false
    @Published var isOccupationValid = false
    @Published var isAstrologicalSignValid = false
    @Published var isFormValid = false

    private var cancellables = Set<AnyCancellable>()

    init() {
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

        Publishers.CombineLatest(
            $isHeightValid,
            Publishers.CombineLatest4(
                $isEthnicityValid,
                $isHometownValid,
                $isOccupationValid,
                $isAstrologicalSignValid
            )
        )
        .map { $0 && $1.0 && $1.1 && $1.2 && $1.3 }
        .assign(to: \.isFormValid, on: self)
        .store(in: &cancellables)
    }
}