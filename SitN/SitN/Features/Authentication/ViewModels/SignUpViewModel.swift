import Combine
import Foundation

class SignUpViewModel: ObservableObject {
    // Input
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var age: Int? = nil
    @Published var phoneNumber = ""
    @Published var zipCode = ""

    // Validation
    @Published var isFirstNameValid = false
    @Published var isLastNameValid = false
    @Published var isEmailValid = false
    @Published var isAgeValid = false
    @Published var isPhoneNumberValid = false
    @Published var isZipCodeValid = false
    @Published var isFormValid = false

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
        // TODO: Why is age not being validated?
        $age
            .map { Validators.isAgeValid($0) }
            .assign(to: \.isAgeValid, on: self)
            .store(in: &cancellables)

        $phoneNumber
            .map { Validators.isPhoneNumberValid($0) }
            .assign(to: \.isPhoneNumberValid, on: self)
            .store(in: &cancellables)
        // TODO: Why is zipcode not being validated?
        $zipCode
            .map { Validators.isZipCodeValid($0) }
            .assign(to: \.isZipCodeValid, on: self)
            .store(in: &cancellables)

        Publishers.CombineLatest(
            Publishers.CombineLatest3(
                $isFirstNameValid,
                $isLastNameValid,
                $isEmailValid,

            ),
            Publishers.CombineLatest3(
                $isAgeValid,
                $isPhoneNumberValid,
                $isZipCodeValid
            )
        )
        .map { ($0.0 && $0.1 && $0.2 && $1.0 && $1.1 && $1.2) }
        .assign(to: \.isFormValid, on: self)
        .store(in: &cancellables)
    }
}
