//
//  AuthError.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 06.11.2021.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordsNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return "Заполните все поля".localizedCapitalized
        case .invalidEmail:
            return "Формат почты не является допустимым".localizedCapitalized
        case .passwordsNotMatched:
            return "Пароли не совпадают".localizedCapitalized
        case .unknownError:
            return "Неизвестная ошибка".localizedCapitalized
        case .serverError:
            return "Ошибка сервера".localizedCapitalized
        }
    }
}
