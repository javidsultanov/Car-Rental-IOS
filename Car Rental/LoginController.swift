//
//  LoginViewController.swift
//  Car Rental
//
//  Created by Javid Sultanov on 29.07.26.
//

import UIKit

//MARK: Login View

class LoginController: UIViewController {
    private var backgroungImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cars")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.alpha = 0.2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "driveit_logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        }()
    
    private var fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.backgroundColor = .white
        textField.borderStyle = .none
        textField.autocapitalizationType = .words
        textField.textAlignment = .center
        textField.layer.cornerRadius = 28
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .white
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.textAlignment = .center
        textField.layer.cornerRadius = 28
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var passwordSwitchButton: UISwitch = {
        let button = UISwitch()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        return button
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOG IN", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 28
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var passwordStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 4
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var fileManager = UserFileManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        fileManager.fetchData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    //MARK: View Functions
    
    private func configureUI() {
        view.backgroundColor = .systemBlue
        title = "Log In"
        
        passwordSwitchButton.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        view.addSubview(backgroungImageView)
        view.addSubview(mainStackView)
        
        passwordStackView.addArrangedSubview(passwordTextField)
        passwordStackView.addArrangedSubview(passwordSwitchButton)
        
        mainStackView.addArrangedSubview(logoImageView)
        mainStackView.addArrangedSubview(fullNameTextField)
        mainStackView.addArrangedSubview(passwordStackView)
        mainStackView.addArrangedSubview(loginButton)
        mainStackView.addArrangedSubview(registerButton)
        
        NSLayoutConstraint.activate([
            backgroungImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroungImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroungImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroungImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 220),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func switchButtonTapped() {
        passwordTextField.isSecureTextEntry = !passwordSwitchButton.isOn
    }
    
    @objc private func loginButtonTapped() {
        if let writtenFullName = fullNameTextField.text, !writtenFullName.isEmpty,
           let writtenPassword = passwordTextField.text, !writtenPassword.isEmpty {
               let savedUser = fileManager.users.contains(where: { $0.fullName == writtenFullName && $0.password == writtenPassword })
               
               if savedUser {
                   UserDefaults.standard.set(true, forKey: "isLoggedIn")
                   
                   let controller = HomeController()
                   navigationController?.setViewControllers([controller], animated: true)
               } else {
                   showDefaultAlert(title: "Login Failed!",
                                    message: "Invalid Full Name or Password")
               }
           } else {
               showDefaultAlert(title: "Login Incomplete!",
                                message: "All gaps must be filled")
           }
    }
    
    @objc private func registerButtonTapped() {
        let controller = RegisterController()
        navigationController?.show(controller, sender: self)
    }
}
