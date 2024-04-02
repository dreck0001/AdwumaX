//
//  SignInAppleHelper.swift
//  Adwumax1
//
//  Created by Denis on 3/20/24.
//

import Foundation
import AuthenticationServices
import CryptoKit
import UIKit
import SwiftUI

struct SignInWithAppleButtonViewRepresentable: UIViewRepresentable {
    let type: ASAuthorizationAppleIDButton.ButtonType
    let style: ASAuthorizationAppleIDButton.Style
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        ASAuthorizationAppleIDButton(authorizationButtonType: type, authorizationButtonStyle: style)
    }
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
        
    }
}

struct SignInWithAppleResult {
    let token: String
    let nonce: String
    let email: String?
    let firstName: String?
    let lastName: String?
    let nickName: String?

    var fullName: String? {
        if let firstName, let lastName {
            return firstName + " " + lastName
        } else if let firstName {
            return firstName
        } else if let lastName {
            return lastName
        }
        return nil
    }
    
    var displayName: String? {
        fullName ?? nickName
    }

    init?(authorization: ASAuthorization, nonce: String) {
        guard
            let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let appleIDToken = appleIDCredential.identityToken,
            let token = String(data: appleIDToken, encoding: .utf8)
        else {
            return nil
        }

        self.token = token
        self.nonce = nonce
        self.email = appleIDCredential.email
        self.firstName = appleIDCredential.fullName?.givenName
        self.lastName = appleIDCredential.fullName?.familyName
        self.nickName = appleIDCredential.fullName?.nickname
    }
}

@MainActor
final class SignInAppleHelper: NSObject {
    
    private var currentNonce: String?
    private var completionHandler: ((Result<SignInWithAppleResult, Error>) -> Void)? = nil
    
    func startSignInWithAppleFlow() async throws -> SignInWithAppleResult {
        try await withCheckedThrowingContinuation { continuation in
            self.startSignInWithAppleFlow { result in
                switch result {
                case .success(let signInAppleResult):
                    continuation.resume(returning: signInAppleResult)
                    return
                case .failure(let error):
                    continuation.resume(throwing: error)
                    return
                }
            }
        }
    }
    func startSignInWithAppleFlow(completion: @escaping (Result<SignInWithAppleResult, Error>) -> Void) {
        guard let topVC = Utilities.shared.topViewController() else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let nonce = randomNonceString()
        currentNonce = nonce
        completionHandler = completion
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = topVC
        authorizationController.performRequests()
    }
    
    //    Adapted from https://firebase.google.com/docs/auth/ios/apple?hl=en&authuser=0&_gl=1*127xuye*_ga*MTU4ODUwNTY1My4xNzA4MDY1ODE0*_ga_CW55HF8NVT*MTcxMDgxNzg0OC4zNC4xLjE3MTA4MTg1ODYuMzYuMC4w#:~:text=private%20func%20randomNonceString(length%3A%20Int%20%3D%2032)%20%2D%3E%20String%20%7B
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        return String(nonce)
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}


extension SignInAppleHelper: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard
            let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
            let appleIDToken = appleIDCredential.identityToken,
            let idTokenString = String(data: appleIDToken, encoding: .utf8),
            let nonce = currentNonce else {
            completionHandler?(.failure(URLError(.badServerResponse)))
            return
        }
        
        let tokens = SignInWithAppleResult(authorization: authorization, nonce: nonce)!
        completionHandler?(.success(tokens))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
        completionHandler?(.failure(URLError(.badServerResponse)))
    }
}


extension UIViewController: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
