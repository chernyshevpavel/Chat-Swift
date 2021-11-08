//
//  MUser.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 01.04.2021.
//

import UIKit

struct MUser: Hashable, Decodable {
    var id: String
    var userName: String
    var email: String
    var descriprion: String
    var sex: String
    var avatarStringURL: String?
    
    var representation: [String: Any] {
        var rep: [String: Any] = [:]
        rep["uid"] = id
        rep["userName"] = userName
        rep["email"] = email
        rep["descriprion"] = descriprion
        rep["sex"] = sex
        rep["avatarStringURL"] = avatarStringURL
        return rep
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
        case email
        case descriprion
        case sex
        case avatarStringURL
    }

    static func == (lhs: MUser, rhs: MUser) -> Bool {
        lhs.id == rhs.id
    }
}
