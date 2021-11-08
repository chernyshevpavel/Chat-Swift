//
//  FirestoreService.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 08.11.2021.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    lazy var stringFillValidator: some AnyStringValidator = StringFillValidator()
    
    func saveProfile(with profileModel: FSProfileModel, completion: @escaping (Result<MUser, Error>) -> Void) {
        guard stringFillValidator.validate(value: profileModel.userName),
              stringFillValidator.validate(value: profileModel.description),
              stringFillValidator.validate(value: profileModel.sex),
              stringFillValidator.validate(value: profileModel.email),
              let userName = profileModel.userName,
              let descriprion = profileModel.description,
              let sex = profileModel.sex
        else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        let mUser = MUser(id: profileModel.id, userName: userName, email: profileModel.email, descriprion: descriprion, sex: sex, avatarStringURL: profileModel.avatarImageString)
        
        self.usersRef.document(mUser.id).setData(mUser.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(mUser))
            }
        }
    }
    
}

struct FSProfileModel {
    var id: String
    var email: String
    var userName: String?
    var avatarImageString: String?
    var description: String?
    var sex: String?
}
