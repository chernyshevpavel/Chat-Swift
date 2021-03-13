//
//  AddPhotoView.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 13.03.2021.
//

import UIKit

class AddPhotoView: UIView {
    
    var circleImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "avatar")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let myImage = #imageLiteral(resourceName: "plus")
        button.setImage(myImage, for: .normal)
        button.tintColor = .buttonBlack()
        return button
    }()
    
    let imageWidthAndHigh: CGFloat
    let btnWidthAndHigh: CGFloat
    let btnLeftMargin: CGFloat
    
    init(
        sizePreporator: SizePreporator,
        frame: CGRect,
        imageWidthAndHigh: CGFloat = 100,
        btnWidthAndHigh: CGFloat = 30,
        btnLeftMargin: CGFloat = 16
    ) {
        self.imageWidthAndHigh = sizePreporator.prepareHigh(imageWidthAndHigh)
        self.btnWidthAndHigh = sizePreporator.prepareHigh(btnWidthAndHigh)
        self.btnLeftMargin = sizePreporator.prepareWidth(btnLeftMargin)
        super.init(frame: frame)
        self.addSubview(circleImageView)
        self.addSubview(plusButton)
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            circleImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            circleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            circleImageView.widthAnchor.constraint(equalToConstant: imageWidthAndHigh),
            circleImageView.heightAnchor.constraint(equalToConstant: imageWidthAndHigh)
        ])
        
        NSLayoutConstraint.activate([
            plusButton.leadingAnchor.constraint(equalTo: circleImageView.trailingAnchor, constant: btnLeftMargin),
            plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: btnWidthAndHigh),
            plusButton.heightAnchor.constraint(equalToConstant: btnWidthAndHigh)
        ])
        
        self.bottomAnchor.constraint(equalTo: circleImageView.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor).isActive = true
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleImageView.layer.masksToBounds = true
        circleImageView.layer.cornerRadius = circleImageView.frame.width / 2
    }
}
