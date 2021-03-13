//
//  Iphone11SizePreporator.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 13.03.2021.
//

import UIKit

class Iphone11SizePreporator: SizePreporator {
    let screenHigh: CGFloat = 896
    let screenWidth: CGFloat = 414
    
    func prepareHigh(_ high: CGFloat) -> CGFloat {
        let multiplicator = screenHigh / high
        return UIScreen.main.bounds.height / multiplicator
    }
    
    func prepareWidth(_ width: CGFloat) -> CGFloat {
        let multiplicator = screenWidth / width
        return UIScreen.main.bounds.width / multiplicator
    }
}
