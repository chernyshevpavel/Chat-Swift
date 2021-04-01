//
//  MChat.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 01.04.2021.
//

import UIKit

struct MChat: Hashable, Decodable {
    var id: Int
    var userName: String
    var userImage: String?
    var lastMessage: String
     
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userName = "username"
        case userImage = "userImageString"
        case lastMessage = "lastMessage"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: MChat, rhs: MChat) -> Bool {
        lhs.id == rhs.id
    }
}
