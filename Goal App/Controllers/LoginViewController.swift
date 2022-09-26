//
//  LoginViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 10/09/22.
//

import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {
    var loginHeaderlabel: UILabel!
    var userNameTextField: UITextField!
    var passwordTextField: UITextField!
    let loginButton = UIButton(type: .system)
    let signUpButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.becomeFirstResponder()
    }

    @objc func loginButtonTapped(_: UIButton) {
        let request = LoginRequest(userEmail: userNameTextField.text!, userPassword: passwordTextField.text!)

        let validation = Validation()
        let validationResult = validation.validateLogin(request: request)

        if validationResult.success {
            let firebaseAuthService = FirebaseAuthService()
            Task {
                let response = await firebaseAuthService.authenticateUser(request: request)

                if response.errorMessage == nil {
                    transitionToHome(userName: response.data?.userName)
                } else {
                    debugPrint(response.errorMessage as Any)
                }
            }
        } else {
            debugPrint(validationResult.errorMessage as Any)
        }
    }

    @objc func signUpButtonTapped(_: UIButton) {
        transitionToSignUp()
    }

    func transitionToHome(userName _: String?) {
        let tabVC = UITabBarController()
        tabVC.setViewControllers(MainTabBarController().navigationViewControllers, animated: true)
        tabVC.modalPresentationStyle = .fullScreen
        present(tabVC, animated: true)
    }

    func transitionToSignUp() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

extension LoginViewController {
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        loginHeaderLableView()
        userNameTextFieldView()
        passwordTextFieldView()
        loginButtonView()
        signUpButtonView()
        layoutConstraints()
    }

    private func loginHeaderLableView() {
        loginHeaderlabel = UILabel()
        loginHeaderlabel.translatesAutoresizingMaskIntoConstraints = false
        loginHeaderlabel.font = .systemFont(ofSize: 40, weight: .semibold)
        loginHeaderlabel.text = "Let's get started!"
        view.addSubview(loginHeaderlabel)
    }

    private func userNameTextFieldView() {
        userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "User name"
        userNameTextField.font = UIFont.systemFont(ofSize: 18)
        userNameTextField.backgroundColor = .systemGray5
        userNameTextField.layer.cornerRadius = 5
        userNameTextField.setLeftPaddingPoints(10)
        userNameTextField.setRightPaddingPoints(10)
        view.addSubview(userNameTextField)
    }

    private func passwordTextFieldView() {
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.font = UIFont.systemFont(ofSize: 18)
        passwordTextField.backgroundColor = .systemGray5
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.setLeftPaddingPoints(10)
        passwordTextField.setRightPaddingPoints(10)
        view.addSubview(passwordTextField)
    }

    private func loginButtonView() {
        loginButton.backgroundColor = .black
        loginButton.tintColor = .white
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
    }

    private func signUpButtonView() {
        signUpButton.backgroundColor = .white
        signUpButton.tintColor = .black
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.layer.cornerRadius = 5
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(signUpButton)
    }

    private func layoutConstraints() {
        NSLayoutConstraint.activate([
            loginHeaderlabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            loginHeaderlabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),

            userNameTextField.topAnchor.constraint(equalTo: loginHeaderlabel.bottomAnchor, constant: 20),
            userNameTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            userNameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 52),

            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),

            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            loginButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 44),
            signUpButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
}
