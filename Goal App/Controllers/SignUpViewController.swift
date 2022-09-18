//
//  LoginViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 10/09/22.
//

import FirebaseAuth
import UIKit

class SignUpViewController: UIViewController {
    var signUpHeaderlabel: UILabel!
    var userNameTextField: UITextField!
    var passwordTextField: UITextField!
    var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.becomeFirstResponder()
        navigationItem.setHidesBackButton(true, animated: false)
    }

    @objc func signUpButtonTapped(_: UIButton) {
        let request = SignUpRequest(userName: userNameTextField.text!, userEmail: emailTextField.text!, userPassword: passwordTextField.text!)

        let validation = Validation()
        let validationResult = validation.validateSignUp(request: request)

        if validationResult.success {
            let firebaseAuthService = FirebaseAuthService()
            Task {
                let response = await firebaseAuthService.createUser(request: request)

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

    func transitionToHome(userName _: String?) {
        let tabVC = UITabBarController()
        tabVC.setViewControllers(MainTabBarController().navigationViewControllers, animated: true)
        tabVC.modalPresentationStyle = .fullScreen
        present(tabVC, animated: true)
    }

    @objc func loginButtonTapped(_: UIButton) {
        transitionToLogin()
    }

    func transitionToLogin() {
        navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController {
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        signUpHeaderlabel = UILabel()
        signUpHeaderlabel.translatesAutoresizingMaskIntoConstraints = false
        signUpHeaderlabel.font = .systemFont(ofSize: 40, weight: .semibold)
        signUpHeaderlabel.text = "Let's get started!"
        view.addSubview(signUpHeaderlabel)

        userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "User name"
        userNameTextField.font = UIFont.systemFont(ofSize: 18)
        userNameTextField.backgroundColor = .systemGray5
        userNameTextField.layer.cornerRadius = 5
        userNameTextField.setLeftPaddingPoints(10)
        userNameTextField.setRightPaddingPoints(10)
        view.addSubview(userNameTextField)

        emailTextField = UITextField()
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Email"
        emailTextField.font = UIFont.systemFont(ofSize: 18)
        emailTextField.backgroundColor = .systemGray5
        emailTextField.layer.cornerRadius = 5
        emailTextField.setLeftPaddingPoints(10)
        emailTextField.setRightPaddingPoints(10)
        view.addSubview(emailTextField)

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

        let signUpButton = UIButton(type: .system)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.backgroundColor = .black
        signUpButton.tintColor = .white
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.layer.cornerRadius = 5
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(signUpButton)

        let loginButton = UIButton(type: .system)
        loginButton.backgroundColor = .white
        loginButton.tintColor = .black
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)

        NSLayoutConstraint.activate([
            signUpHeaderlabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            signUpHeaderlabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),

            userNameTextField.topAnchor.constraint(equalTo: signUpHeaderlabel.bottomAnchor, constant: 20),
            userNameTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            userNameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 52),

            emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),

            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 44),
            signUpButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

            loginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            loginButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
