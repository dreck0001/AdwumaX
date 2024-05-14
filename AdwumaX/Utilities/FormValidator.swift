//
//  FormValidator.swift
//  AdwumaX
//
//  Created by Denis on 4/21/24.
//

import Foundation

class FormValidator {
    // Validate if a name contains only alphabets and is not empty
    func validateName(_ value: String) -> Bool {
        return value.containsOnlyAlphabets() && !value.trimmed().isEmpty
    }
    
    // Validate if a last name contains only alphabets and is not empty
    func validateLastName(_ value: String) -> Bool {
        return value.containsOnlyAlphabets() && !value.trimmed().isEmpty
    }
    
    // Validate if an email is in a valid email format
    func validateEmail(_ value: String) -> Bool {
        return value.isValidEmail()
    }
    
    // Validate if a password meets certain criteria (length, contains special characters, etc.)
    func validatePassword(_ value: String) -> Bool {
        // Example: At least 8 characters, contains at least one letter and one number
        let minimumLength = 8
        let hasLetter = value.containsOnlyAlphanumeric() && value.rangeOfCharacter(from: .letters) != nil
        let hasNumber = value.rangeOfCharacter(from: .decimalDigits) != nil
        
        return value.count >= minimumLength && hasLetter && hasNumber
    }
    
    // Validate if a phone number is in a valid phone number format
    func validatePhone(_ value: String) -> Bool {
        return value.isValidPhoneNumber()
    }
}

