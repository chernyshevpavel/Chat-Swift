//
//  MUser.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 01.04.2021.
//

import UIKit
import FirebaseFirestore

struct MUser: Hashable, Decodable {
    var id: String
    var userName: String
    var email: String
    var description: String
    var sex: String
    var avatarStringURL: String?
    
    var representation: [String: Any] {
        var rep: [String: Any] = [:]
        rep["uid"] = id
        rep["userName"] = userName
        rep["email"] = email
        rep["description"] = description
        rep["sex"] = sex
        rep["avatarStringURL"] = avatarStringURL
        return rep
    }
    
    init(id: String, userName: String, email: String, description: String, sex: String, avatarStringURL: String?) {
        self.userName = userName
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.sex = sex
        self.id = id
    }

    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        self.init(data: data)
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        self.init(data: data)
    }
    
    init?(data: [String: Any]) {
        guard let username = data["userName"] as? String,
              let email = data["email"] as? String,
              let avatarStringURL = data["avatarStringURL"] as? String,
              let description = data["description"] as? String,
              let sex = data["sex"] as? String,
              let id = data["uid"] as? String
        else { return nil }

        self.userName = username
        self.email = email
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.sex = sex
        self.id = id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
        case email
        case description
        case sex
        case avatarStringURL
    }

    static func == (lhs: MUser, rhs: MUser) -> Bool {
        lhs.id == rhs.id
    }
}
