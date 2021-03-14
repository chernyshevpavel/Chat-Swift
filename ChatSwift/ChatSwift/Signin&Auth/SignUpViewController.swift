//
//  SignUpViewController.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 13.03.2021.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Good to see you!", font: .avenir26())
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let confirmPasswodLabel = UILabel(text: "Confirm password")
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    let confirmPasswordTextField = OneLineTextField(font: .avenir20())
    
    let signUpButton = UIButton(title: "Sign Up", titleColor: .white, backgroundColor: .buttonBlack(), cornerRadius: 4)
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    
    private let titleMargin: CGFloat
    private let btnHigh: CGFloat
    private let stackFieldsSpacing: CGFloat
    private let loginBtnTopMargin: CGFloat
    private let topAndBottomMargin: CGFloat
    private let leftAndRightMargin: CGFloat
    private let loginStackSpacing: CGFloat
    
    init(
        sizePreporator: SizePreporator,
        titleMargin: CGFloat = 160,
        btnHigh: CGFloat = 60,
        stackFieldsSpacing: CGFloat = 40,
        loginBtnTopMargin: CGFloat = 60,
        loginStackSpacing: CGFloat = 10,
        aroundMargin: CGFloat = 40
    ) {
        self.titleMargin = sizePreporator.prepareHigh(titleMargin)
        self.btnHigh = sizePreporator.prepareHigh(btnHigh)
        self.stackFieldsSpacing = sizePreporator.prepareHigh(stackFieldsSpacing)
        self.loginBtnTopMargin = sizePreporator.prepareHigh(loginBtnTopMargin)
        self.topAndBottomMargin = sizePreporator.prepareHigh(aroundMargin)
        self.leftAndRightMargin = sizePreporator.prepareWidth(aroundMargin)
        self.loginStackSpacing = sizePreporator.prepareWidth(loginStackSpacing)
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

// MARK: - Setup constraints
extension SignUpViewController {
    private func setupConstraints() {
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)
        let confirmPasswordStackView = UIStackView(arrangedSubviews: [confirmPasswodLabel, confirmPasswordTextField], axis: .vertical, spacing: 0)
        
        signUpButton.heightAnchor.constraint(equalToConstant: btnHigh).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
            emailStackView,
            passwordStackView,
            confirmPasswordStackView,
            signUpButton
        ],
        axis: .vertical,
        spacing: stackFieldsSpacing)
        
        loginButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [
            alreadyOnboardLabel,
            loginButton
        ],
        axis: .horizontal,
        spacing: loginStackSpacing)
        bottomStackView.alignment = .firstBaseline
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: leftAndRightMargin),
            welcomeLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: titleMargin),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(lessThanOrEqualTo: welcomeLabel.bottomAnchor, constant: titleMargin),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftAndRightMargin),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftAndRightMargin)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: loginBtnTopMargin),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftAndRightMargin),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftAndRightMargin),
            bottomStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -leftAndRightMargin)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct SignUpVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let signUpVC = SignUpViewController(sizePreporator: Iphone11SizePreporator())
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) -> SignUpViewController {
            signUpVC
        }
        
        func updateUIViewController(_ uiViewController: SignUpVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SignUpVCProvider.ContainerView>) {
            
        }
    }
}
