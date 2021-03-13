//
//  Label + Etension.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 11.03.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        self.text = text
        self.font = font
    }
}
