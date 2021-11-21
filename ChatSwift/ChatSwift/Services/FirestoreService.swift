//
//  FirestoreService.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 08.11.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit

class FirestoreService {
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        db.collection("users")
    }
    
    lazy var stringFillValidator: some AnyStringValidator = StringFillValidator()
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToMUser))
                    return
                }
                completion(.success(muser))
            } else if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
    }
    
    func saveProfile(with profileModel: FSProfileModel, completion: @escaping (Result<MUser, Error>) -> Void) {
        guard stringFillValidator.validate(value: profileModel.userName),
              stringFillValidator.validate(value: profileModel.description),
              stringFillValidator.validate(value: profileModel.sex),
              stringFillValidator.validate(value: profileModel.email),
              let userName = profileModel.userName,
              let description = profileModel.description,
              let sex = profileModel.sex
        else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard let avatarImage = profileModel.avatarImage, avatarImage != #imageLiteral(resourceName: "avatar")
        else {
            completion(.failure(UserError.photoNotExist))
            return
        }
        
        var muser = MUser(id: profileModel.id, userName: userName, email: profileModel.email, description: description, sex: sex, avatarStringURL: nil)
        
        StorageService.shared.upload(photo: avatarImage) { (result) in
            switch result {
                
            case .success(let url):
                muser.avatarStringURL = url.absoluteString
                self.usersRef.document(muser.id).setData(muser.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(muser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

struct FSProfileModel {
    var id: String
    var email: String
    var userName: String?
    var avatarImage: UIImage?
    var description: String?
    var sex: String?
}
