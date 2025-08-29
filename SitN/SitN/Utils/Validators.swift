
import Foundation

struct Validators {
    static func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    static func isPhoneNumberValid(_ phoneNumber: String) -> Bool {
        let filtered = phoneNumber.filter { "0123456789".contains($0) }
        return filtered.count >= 10 // Simple check for at least 10 digits
    }
    
    static func isZipCodeValid(_ zipCode: String) -> Bool {
        return zipCode.count == 5
    }
    
    static func isAgeValid(_ age: Optional<Int>) -> Bool {
        if let ageIntValue = age {
            return ageIntValue >= 18 && ageIntValue <= 100
        } else {
            return false
        }
    }
}
