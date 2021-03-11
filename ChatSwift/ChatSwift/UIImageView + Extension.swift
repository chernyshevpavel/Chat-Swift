//
//  UIImageView + Extension.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 11.03.2021.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        self.image = image
        self.contentMode = contentMode
    }
}
