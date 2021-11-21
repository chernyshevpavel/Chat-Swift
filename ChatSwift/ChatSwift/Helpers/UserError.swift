//
//  UserError.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 08.11.2021.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case cannotGetUserInfo
    case cannotUnwrapToMUser
    case cannotConvertImage
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return "Fill the all fields".localizedCapitalized
        case .photoNotExist:
            return "User didn't set a photo".localizedCapitalized
        case .cannotGetUserInfo:
            return "Couldn't load user information from Firebase".localizedCapitalized
        case .cannotUnwrapToMUser:
            return "Couldn't convert Uset to MUser".localizedCapitalized
        case .cannotConvertImage:
            return "Couldn't convert image".localizedCapitalized
        }
    }
}
