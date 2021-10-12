//
//  LoginViewController.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 13.03.2021.
//

import Foundation

class LoginViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Welcome back!", font: .avenir26())
    let loginWithLabel = UILabel(text: "Login with")
    let orLabel = UILabel(text: "or")
    let emailLabel = UILabel(text: "Email")
    let passwordLabel = UILabel(text: "Password")
    let needAnAccountLabel = UILabel(text: "Need an account?")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let emailTextField = OneLineTextField(font: .avenir20())
    let passwordTextField = OneLineTextField(font: .avenir20())
    let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonBlack())
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        return button
    }()
    
    private let titleTopMargin: CGFloat
    private let titleBottomMargin: CGFloat
    private let labelToBtnMargin: CGFloat
    private let btnHigh: CGFloat
    private let stackFieldsSpacing: CGFloat
    private let signUpBtnTopMargin: CGFloat
    private let topAndBottomMargin: CGFloat
    private let leftAndRightMargin: CGFloat
    private let loginStackSpacing: CGFloat
    
    init(
        sizePreporator: SizePreparator,
        titleTopMargin: CGFloat = 160,
        titleBottomMargin: CGFloat = 100,
        labelToBtnMargin: CGFloat = 20,
        btnHigh: CGFloat = 60,
        stackFieldsSpacing: CGFloat = 40,
        loginBtnTopMargin: CGFloat = 60,
        loginStackSpacing: CGFloat = 10,
        aroundMargin: CGFloat = 40
    ) {
        self.titleTopMargin = sizePreporator.prepareHigh(titleTopMargin)
        self.titleBottomMargin = sizePreporator.prepareHigh(titleBottomMargin)
        self.labelToBtnMargin = sizePreporator.prepareHigh(labelToBtnMargin)
        self.btnHigh = sizePreporator.prepareHigh(btnHigh)
        self.stackFieldsSpacing = sizePreporator.prepareHigh(stackFieldsSpacing)
        self.signUpBtnTopMargin = sizePreporator.prepareHigh(loginBtnTopMargin)
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
extension LoginViewController {
    private func setupConstraints() {
        let loginWithView = ButtonFormView(label: loginWithLabel, button: googleButton, labelToBtnMargin: labelToBtnMargin, btnHigh: btnHigh)
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField],
                                         axis: .vertical,
                                         spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField],
                                            axis: .vertical,
                                            spacing: 0)
        
        loginButton.heightAnchor.constraint(equalToConstant: btnHigh).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
            loginWithView,
            orLabel,
            emailStackView,
            passwordStackView,
            loginButton
        ],
        axis: .vertical,
        spacing: stackFieldsSpacing)
        
        signInButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signInButton],
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
            welcomeLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: topAndBottomMargin),
            welcomeLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: titleTopMargin),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(lessThanOrEqualTo: welcomeLabel.bottomAnchor, constant: titleBottomMargin),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftAndRightMargin),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftAndRightMargin)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: signUpBtnTopMargin),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftAndRightMargin),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftAndRightMargin),
            bottomStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -topAndBottomMargin)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct LoginVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let loginVC = LoginViewController(sizePreporator: Iphone11SizePreparator())
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) -> LoginViewController {
            loginVC
        }
        
        func updateUIViewController(_ uiViewController: LoginVCProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<LoginVCProvider.ContainerView>) {
            
        }
    }
}
