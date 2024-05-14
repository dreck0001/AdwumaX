//
//  Extensions.swift
//  AdwumaX
//
//  Created by Denis on 4/21/24.
//

import Foundation

extension String {
    // Check if a string is a valid email address
    func isValidEmail() -> Bool {
        let emailPattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        let regex = try? NSRegularExpression(pattern: emailPattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.utf16.count)
        
        return regex?.firstMatch(in: self, options: [], range: range) != nil
    }
    
    // Check if a string is a valid phone number
    func isValidPhoneNumber() -> Bool {
            // Remove spaces from the string
            let cleanedNumber = self.replacingOccurrences(of: " ", with: "")
            
            // Regular expression for exactly 10 digits (no spaces or additional characters)
            let phonePattern = "^[0-9]{10}$"  // Only 10 digits
            let regex = try? NSRegularExpression(pattern: phonePattern, options: [])
            let range = NSRange(location: 0, length: cleanedNumber.utf16.count)
            
            return regex?.firstMatch(in: cleanedNumber, options: [], range: range) != nil
        }
    
    // Check if a string contains only alphabetic characters
    func containsOnlyAlphabets() -> Bool {
        let alphabetSet = CharacterSet.letters
        return unicodeScalars.allSatisfy { alphabetSet.contains($0) }
    }
    
    // Check if a string contains only alphanumeric characters
    func containsOnlyAlphanumeric() -> Bool {
        let alphanumericSet = CharacterSet.alphanumerics
        return unicodeScalars.allSatisfy { alphanumericSet.contains($0) }
    }
    
    // Check if a string is a palindrome
    func isPalindrome() -> Bool {
        let cleaned = lowercased().filter { $0.isLetter }
        return cleaned == String(cleaned.reversed())
    }
    
    // Check if a string is numeric
    func isNumeric() -> Bool {
        let numericSet = CharacterSet.decimalDigits
        return unicodeScalars.allSatisfy { numericSet.contains($0) }
    }
    
    // Capitalize the first letter of each word
    func capitalizedWords() -> String {
        return split(separator: " ")
            .map { $0.capitalized }
            .joined(separator: " ")
    }
    
    // Trim leading and trailing whitespace and newlines
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // Check if a string contains a specific substring (with optional case-insensitive matching)
    func containsSubstring(_ substring: String, caseInsensitive: Bool = false) -> Bool {
        if caseInsensitive {
            return range(of: substring, options: .caseInsensitive) != nil
        } else {
            return contains(substring)
        }
    }
}


//for Phone stuff
extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
