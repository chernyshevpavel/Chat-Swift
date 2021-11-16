//
//  ViewController.swift
//  Chat-SwiftUI
//
//  Created by Павел Чернышев on 10.03.2021.
//

import UIKit
import Firebase
import GoogleSignIn

protocol AuthNavigatingDelegate: AnyObject {
    func toLoginVC()
    func toSignUpVC()
}

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
    private let topAndBottomMargin: CGFloat
    private let leftAndRightMargin: CGFloat
    
    private let sizePreporator: SizePreparator
    
    private lazy var signUpVC: SignUpViewController = {
        let vc = SignUpViewController(sizePreporator: sizePreporator)
        vc.delegate = self
        return vc
    }()
    private lazy var loginVC: LoginViewController = {
        let vc = LoginViewController(sizePreporator: sizePreporator)
        vc.delegate = self
        return vc
    }()
    
    init(
        sizePreporator: SizePreparator,
        logoMargin: CGFloat = 160,
        labelToBtnMargin: CGFloat = 20,
        btnHigh: CGFloat = 60,
        stackViewSpacing: CGFloat = 40,
        aroundMargin: CGFloat = 40
    ) {
        self.sizePreporator = sizePreporator
        self.logoMargin = sizePreporator.prepareHigh(logoMargin)
        self.labelToBtnMargin = sizePreporator.prepareHigh(labelToBtnMargin)
        self.btnHigh = sizePreporator.prepareHigh(btnHigh)
        self.stackViewSpacing = sizePreporator.prepareHigh(stackViewSpacing)
        self.topAndBottomMargin = sizePreporator.prepareHigh(aroundMargin)
        self.leftAndRightMargin = sizePreporator.prepareWidth(aroundMargin)
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
        
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
        
        //GIDSignIn.sharedInstance.
    }
    
    @objc private func emailButtonTapped() {
        toSignUpVC()
    }
    
    @objc private func loginButtonTapped() {
        toLoginVC()
    }
    
    @objc private func googleButtonTapped() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            self.sign(GIDSignIn.sharedInstance, didSignInFor: user, withError: error)
        }
    }
}

// MARK: - Navigation

extension AuthViewController: AuthNavigatingDelegate {
    func toLoginVC() {
        present(loginVC, animated: true, completion: nil)
    }
    
    func toSignUpVC() {
        present(signUpVC, animated: true, completion: nil)
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
            logoImageView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: topAndBottomMargin),
            logoImageView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: logoMargin),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(lessThanOrEqualTo: logoImageView.bottomAnchor, constant: logoMargin),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftAndRightMargin),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftAndRightMargin),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -topAndBottomMargin)
        ])
    }
}

// MARK: - GIDSignInDelegate
extension AuthViewController {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        AuthService.shared.googleLogin(user: user, error: error) { (result) in
            switch result {
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { (result) in
                    switch result {
                    case .success(let muser):
                        self.showAlert(with: "Успешно", and: "Вы авторизованы") {
                            let mainTabBar = MainTabBarController(currentUser: muser)
                            mainTabBar.modalPresentationStyle = .fullScreen
                            self.present(mainTabBar, animated: true, completion: nil)
                        }
                    case .failure(_):
                        self.showAlert(with: "Успешно", and: "Вы зарегистрированны") {
                            self.present(SetupProfileViewController(currentUser: user, sizePreporator: self.sizePreporator), animated: true, completion: nil)
                        }
                    }
                }
            case .failure(let error):
                self.showAlert(with: "Ошибка", and: error.localizedDescription)
            }
        }
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
            self.viewController = AuthViewController(sizePreporator: Iphone11SizePreparator())
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
