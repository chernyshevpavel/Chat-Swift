//
//  AuthService.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 06.11.2021.
//

import UIKit
import Firebase
import GoogleSignIn

class AuthService {
    private let auth = Auth.auth()
    
    static let shared = AuthService()
    
    typealias StringValidator = Validator
    
    lazy var emailValidator: some AnyStringValidator = EmailValidator()
    lazy var stringFillValidator: some AnyStringValidator = StringFillValidator()
    
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard stringFillValidator.validate(value: email),
              stringFillValidator.validate(value: password),
              let email = email,
              let password = password
        else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        guard emailValidator.validate(value: email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }

        auth.signIn(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(result.user))
        }
    }
    
    func googleLogin(user: GIDGoogleUser!, error: Error!, completion: @escaping (Result<User, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        let auth = user.authentication
        guard let idToken = auth.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: auth.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard stringFillValidator.validate(value: email),
              stringFillValidator.validate(value: password),
              stringFillValidator.validate(value: confirmPassword),
              let email = email,
              let password = password,
              let confirmPassword = confirmPassword
        else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        guard emailValidator.validate(value: email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        
        guard password.lowercased() == confirmPassword.lowercased() else {
            completion(.failure(AuthError.passwordsNotMatched))
            return
        }
        
        auth.createUser(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(result.user))
        }
    }
}
