//
//  UIViewController + Extensions.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 12.10.2021.
//

import UIKit

extension UIViewController {
    
    func configurate<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: value)
        return cell
    }
}
