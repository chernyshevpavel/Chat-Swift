//
//  AuthService.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 06.11.2021.
//

import UIKit
import Firebase

class AuthService {
    private let auth = Auth.auth()
    
    static let shared = AuthService()
    
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard let email = email, let password = password else {
            // MARK: - TODO send error to completion
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
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard let email = email, let password = password else {
            // MARK: - TODO send error to completion
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
