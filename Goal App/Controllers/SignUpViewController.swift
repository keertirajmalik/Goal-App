//
//  LoginViewController.swift
//  Goal App
//
//  Created by Keertiraj Laxman Malik on 10/09/22.
//

import FirebaseAuth
import UIKit

class SignUpViewController: UIViewController {
    let firebaseService = FirebaseAuthService.shared

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
        let error = validateFields()

        if error != nil {
            print(error!)
        } else {
            Auth.auth().createUser(withEmail: (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, password: (passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!) { [weak self] _, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self?.transitionToHome()
                }
            }
        }
    }

    func transitionToHome() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        if let homeViewController = homeViewController {
            navigationController?.pushViewController(homeViewController, animated: true)
        } else {
            fatalError("Failure while transitioning to Home screen")
        }
    }

    func validateFields() -> String? {
        if userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }

//        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        return nil
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
            loginButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
}
