//
//  SizePreporator.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 13.03.2021.
//

import UIKit

protocol SizePreporator {
    func prepareHigh(_ high: CGFloat) -> CGFloat
    func prepareWidth(_ width: CGFloat) -> CGFloat
}
