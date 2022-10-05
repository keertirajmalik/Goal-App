//
//  ProfileViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 27/09/22.
//

import UIKit

class ProfileViewController: UIViewController {
    private let profileImageHeight: CGFloat = 150

    private var profileImage: UIImageView!
    private var userNameStackView: UIStackView!
    private var jobStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension ProfileViewController {
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        profileImageView()
        configureUserNameStackView()
        userNameTextFieldView()
        configureJobStackView()
        jobTextFieldView()

        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: profileImageHeight),
            profileImage.widthAnchor.constraint(equalToConstant: profileImageHeight),

            userNameStackView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            userNameStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            userNameStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            userNameStackView.heightAnchor.constraint(equalToConstant: 64),

            jobStackView.topAnchor.constraint(equalTo: userNameStackView.bottomAnchor, constant: 20),
            jobStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            jobStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            jobStackView.heightAnchor.constraint(equalToConstant: 64),
        ])
    }

    private func profileImageView() {
        profileImage = UIImageView()
        profileImage.image = UIImage(named: "Face")
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.layer.cornerRadius = profileImageHeight / 2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 3.0
        profileImage.layer.borderColor = UIColor.black.cgColor
        view.addSubview(profileImage)
    }

    private func configureUserNameStackView() {
        userNameStackView = UIStackView()
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameStackView)
        userNameStackView.axis = .vertical
        userNameStackView.distribution = .fillProportionally
        userNameStackView.spacing = 10
        userNameStackView.backgroundColor = .systemGray5
        userNameStackView.layer.cornerRadius = 8
        userNameStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 20)
        userNameStackView.isLayoutMarginsRelativeArrangement = true
    }

    private func userNameTextFieldView() {
        let userNameTextFieldLabel = UILabel()
        userNameTextFieldLabel.text = "User name"
        userNameTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameTextFieldLabel.textColor = .gray
        userNameStackView.addArrangedSubview(userNameTextFieldLabel)

        var userNameTextField: UITextField!
        userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "User name"
        userNameTextField.font = UIFont.systemFont(ofSize: 18)
        userNameTextField.text = "Keertiraj Malik"
        userNameStackView.addArrangedSubview(userNameTextField)
    }

    private func configureJobStackView() {
        jobStackView = UIStackView()
        jobStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(jobStackView)
        jobStackView.axis = .vertical
        jobStackView.distribution = .fillProportionally
        jobStackView.spacing = 10
        jobStackView.backgroundColor = .systemGray5
        jobStackView.layer.cornerRadius = 8
        jobStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 20)
        jobStackView.isLayoutMarginsRelativeArrangement = true
    }

    private func jobTextFieldView() {
        var jobTextFieldLabel = UILabel()
        jobTextFieldLabel.text = "Job Profile"
        jobTextFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        jobTextFieldLabel.textColor = .gray
        jobStackView.addArrangedSubview(jobTextFieldLabel)

        var jobTextField: UITextField!
        jobTextField = UITextField()
        jobTextField.translatesAutoresizingMaskIntoConstraints = false
        jobTextField.placeholder = "User name"
        jobTextField.font = UIFont.systemFont(ofSize: 18)
        jobTextField.text = "Software Developer"
        jobStackView.addArrangedSubview(jobTextField)
    }
}
