//
//  Validators.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 06.11.2021.
//

import Foundation

protocol Validator: AnyObject {
    associatedtype ValidatingType
    
    func validate(value: ValidatingType?) -> Bool
}

protocol AnyStringValidator: Validator where ValidatingType == String { }

class StringFillValidator: AnyStringValidator {
    func validate(value: String?) -> Bool {
        guard let value = value, !value.isEmpty else {
            return false
        }
        return true
    }
}

class EmailValidator: AnyStringValidator {
    
    func validate(value: String?) -> Bool {
        guard StringFillValidator().validate(value: value),
              let value = value
        else {
            return false
        }
        
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: value, regEx: emailRegEx)
    }
    
    private func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
