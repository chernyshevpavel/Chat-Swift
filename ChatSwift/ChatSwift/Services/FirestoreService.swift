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
    
    private var waitingChatsRef: CollectionReference {
        db.collection(["users", currentUser.id, "waitingChats"].joined(separator: "/"))
    }
    
    private var activeChatsRef: CollectionReference {
        db.collection(["users", currentUser.id, "activeChats"].joined(separator: "/"))
    }
    
    var currentUser: MUser!
    
    lazy var stringFillValidator: some AnyStringValidator = StringFillValidator()
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToMUser))
                    return
                }
                self.currentUser = muser
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
    
    func createWaitingChat(message: String, receiver: MUser, completion: @escaping (Result<Void, Error>) -> Void) {
        let reference = db.collection(["users", receiver.id, "waitingChats"].joined(separator: "/"))
        let messageRef = reference.document(self.currentUser.id).collection("messages")
        
        let message = MMessage(user: currentUser, content: message)
        let chat = MChat(friendUsername: currentUser.username,
                         friendAvatarStringURL: currentUser.avatarStringURL ?? "",
                         friendId: currentUser.id, lastMessageContent: message.content)
        
        reference.document(currentUser.id).setData(chat.representation) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            messageRef.addDocument(data: message.representation) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(Void()))
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
