//
//  ViewController.swift
//  Chat-SwiftUI
//
//  Created by Павел Чернышев on 10.03.2021.
//

import UIKit

class AuthViewController: UIViewController {
    
    let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Logo"), contentMode: .scaleAspectFit)

    let gooleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Or sign up with")
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")

    let googleButton = UIButton(
        title: "Google",
        titleColor: .black,
        backgroundColor: .white,
        isShadow: true)
    let emailButton = UIButton(
        title: "Email",
        titleColor: .white,
        backgroundColor: .buttonBlack())
    let loginButton = UIButton(
        title: "Login",
        titleColor: .buttonRed(),
        backgroundColor: .white,
        isShadow: true)
    
    private let logoMargin: CGFloat
    private let labelToBtnMargin: CGFloat
    private let btnHigh: CGFloat
    private let stackViewSpacing: CGFloat
    private let leftAndRightMargin: CGFloat
    
    init(
        sizePreporator: SizePreporator,
        logoMargin: CGFloat = 160,
        labelToBtnMargin: CGFloat = 20,
        btnHigh: CGFloat = 60,
        stackViewSpacing: CGFloat = 40,
        leftAndRightMargin: CGFloat = 40
    ) {
        self.logoMargin = sizePreporator.prepareHigh(logoMargin)
        self.labelToBtnMargin = sizePreporator.prepareHigh(labelToBtnMargin)
        self.btnHigh = sizePreporator.prepareHigh(btnHigh)
        self.stackViewSpacing = sizePreporator.prepareHigh(stackViewSpacing)
        self.leftAndRightMargin = sizePreporator.prepareWidth(leftAndRightMargin)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
}

// MARK: - Set constraints

extension AuthViewController {
    private func setupConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        let googleView = ButtonFormView(
            label: gooleLabel,
            button: googleButton,
            labelToBtnMargin: labelToBtnMargin,
            btnHigh: btnHigh)
        let emailView = ButtonFormView(
            label: emailLabel,
            button: emailButton,
            labelToBtnMargin: labelToBtnMargin,
            btnHigh: btnHigh)
        let loginView = ButtonFormView(
            label: alreadyOnboardLabel,
            button: loginButton,
            labelToBtnMargin: labelToBtnMargin,
            btnHigh: btnHigh)
        
        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView], axis: .vertical, spacing: stackViewSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: logoMargin),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(lessThanOrEqualTo: logoImageView.bottomAnchor, constant: logoMargin),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftAndRightMargin),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftAndRightMargin)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct AuthViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        let viewController: AuthViewController
        init() {
            self.viewController = AuthViewController(sizePreporator: Iphone11SizePreporator())
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AuthViewControllerProvider.ContainerView>) -> AuthViewController {
            viewController
        }
        
        func updateUIViewController(
            _ uiViewController: AuthViewControllerProvider.ContainerView.UIViewControllerType,
            context: UIViewControllerRepresentableContext<AuthViewControllerProvider.ContainerView>
        ) {
        }
    }
}
