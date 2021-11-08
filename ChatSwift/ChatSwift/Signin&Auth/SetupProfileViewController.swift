//
//  SetupProfileViewController.swift
//  ChatSwift
//
//  Created by Павел Чернышев on 13.03.2021.
//

import Foundation
import Firebase

class SetupProfileViewController: UIViewController {
    
    let welcomeLabel = UILabel(text: "Set up profile!", font: .avenir26())
    let fullImageView: AddPhotoView
    
    let fullNameLabel = UILabel(text: "Full name")
    let aboutmeLabel = UILabel(text: "About me")
    let sexLabel = UILabel(text: "Sex")
    
    let fullNameTextField = OneLineTextField(font: .avenir20())
    let aboutMeTextField = OneLineTextField(font: .avenir20())
    let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Femail")
    
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonBlack(), cornerRadius: 4)
    
    private let titleTopMargin: CGFloat
    private let imageTopMargin: CGFloat
    private let btnHigh: CGFloat
    private let stackViewTopMargin: CGFloat
    private let stackViewSpacing: CGFloat
    private let segmentedTopMargin: CGFloat
    private let topAndBottomMargin: CGFloat
    private let leftAndRightMargin: CGFloat
    
    private let currentUser: User
    
    init(
        currentUser: User,
        sizePreporator: SizePreparator,
        titleTopMargin: CGFloat = 160,
        imageTopMargin: CGFloat = 40,
        btnHigh: CGFloat = 60,
        stackViewTopMargin: CGFloat = 40,
        stackViewSpacing: CGFloat = 40,
        segmentedTopMargin: CGFloat = 12,
        aroundMargin: CGFloat = 40,
        imageWidthAndHigh: CGFloat = 100,
        addBtnWidthAndHigh: CGFloat = 30,
        addBtnLeftMargin: CGFloat = 16
    ) {
        self.currentUser = currentUser
        self.fullImageView = AddPhotoView(
            sizePreporator: sizePreporator,
            frame: CGRect(),
            imageWidthAndHigh: imageWidthAndHigh,
            btnWidthAndHigh: addBtnWidthAndHigh,
            btnLeftMargin: addBtnLeftMargin)
        self.titleTopMargin = sizePreporator.prepareHigh(titleTopMargin)
        self.imageTopMargin = sizePreporator.prepareHigh(imageTopMargin)
        self.btnHigh = sizePreporator.prepareHigh(btnHigh)
        self.stackViewTopMargin = sizePreporator.prepareHigh(stackViewTopMargin)
        self.stackViewSpacing = sizePreporator.prepareHigh(stackViewSpacing)
        self.segmentedTopMargin = sizePreporator.prepareHigh(segmentedTopMargin)
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
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
    }
    
    @objc private func goToChatsButtonTapped() {
        FirestoreService.shared.saveProfile(with: .init(
                                                id: currentUser.uid,
                                                email: currentUser.email ?? "",
                                                userName: fullNameTextField.text,
                                                avatarImageString: "",
                                                description: aboutMeTextField.text,
                                                sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)))
        { [weak self] result in
            switch result {
            case .success:
                self?.showAlert(with: "Success".localizedCapitalized, and: "Glad to see you".localizedCapitalized)
            case .failure(let error):
                self?.showAlert(with: "Error!".localizedCapitalized, and: error.localizedDescription)
            }
        }
    }
}

// MARK: - Setup constraints
extension SetupProfileViewController {
    private func setupConstraints() {
        let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTextField],
                                            axis: .vertical,
                                            spacing: 0)
        let aboutMeStackView = UIStackView(arrangedSubviews: [aboutmeLabel, aboutMeTextField],
                                           axis: .vertical,
                                           spacing: 0)
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl],
                                       axis: .vertical,
                                       spacing: segmentedTopMargin)
        
        goToChatsButton.heightAnchor.constraint(equalToConstant: btnHigh).isActive = true
        let stackView = UIStackView(arrangedSubviews: [
            fullNameStackView,
            aboutMeStackView,
            sexStackView,
            goToChatsButton
        ],
        axis: .vertical,
        spacing: stackViewSpacing)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(fullImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: topAndBottomMargin),
            welcomeLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: titleTopMargin),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: imageTopMargin),
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: stackViewTopMargin),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftAndRightMargin),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -leftAndRightMargin),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -leftAndRightMargin)
        ])
    }
}

// MARK: - SwiftUI
import SwiftUI

struct SetupProfileVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let setupProfileVC = SetupProfileViewController(currentUser: Auth.auth().currentUser!, sizePreporator: Iphone11SizePreparator())
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>) -> SetupProfileViewController {
            setupProfileVC
        }
        
        func updateUIViewController(
            _ uiViewController: SetupProfileVCProvider.ContainerView.UIViewControllerType,
            context: UIViewControllerRepresentableContext<SetupProfileVCProvider.ContainerView>
        ) {
            
        }
    }
}
