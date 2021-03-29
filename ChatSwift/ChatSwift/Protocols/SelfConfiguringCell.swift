//
//  SelfConfiguringCell.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 29.03.2021.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with value: MChat)
}
