//
//  UIButton + Extention.swift
//  Chat-SwiftUI
//
//  Created by Павел Чернышев on 11.03.2021.
//

import Foundation
import UIKit

extension UIButton {
    convenience init(
        title: String,
        titleColor: UIColor,
        backgroundCollor: UIColor,
        font: UIFont? = .avenir20(),
        isShadow: Bool = false,
        cornerRadius: CGFloat = 4
    ) {
        self.init(type: .system)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        
        self.layer.cornerRadius = cornerRadius
        
        if isShadow {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 4
            self.layer.shadowOpacity = 0.2
            self.layer.shadowOffset = CGSize(width: 0, height: 4)
        }
    }
}
