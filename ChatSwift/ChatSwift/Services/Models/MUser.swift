//
//  MUser.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 01.04.2021.
//

import UIKit

struct MUser: Hashable, Decodable {
    var id: Int
    var userName: String
    var avatarStringURL: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case userName = "username"
        case avatarStringURL
    }

    static func ==(lhs: MUser, rhs: MUser) -> Bool {
        lhs.id == rhs.id
    }
}
