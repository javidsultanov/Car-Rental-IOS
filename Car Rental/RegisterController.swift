//
//  RegisterViewController.swift
//  Car Rental
//
//  Created by Javid Sultanov on 30.07.26.
//

import UIKit

//MARK: Register View

class RegisterController: UIViewController {
    private var backgroundImageView: UIImageView = {
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
        textField.layer.cornerRadius = 28
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.layer.cornerRadius = 28
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.backgroundColor = .white
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.borderStyle = .none
        textField.layer.cornerRadius = 28
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.layer.cornerRadius = 28
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var passwordSwitchButton: UISwitch = {
        let button = UISwitch()
        button.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("REGISTER", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 28
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
        title = "Register"
        view.backgroundColor = .systemBlue
        
        phoneNumberTextField.delegate = self
        
        passwordSwitchButton.addTarget(self, action: #selector(switchButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        passwordStackView.addArrangedSubview(passwordTextField)
        passwordStackView.addArrangedSubview(passwordSwitchButton)
        
        mainStackView.addArrangedSubview(logoImageView)
        mainStackView.addArrangedSubview(fullNameTextField)
        mainStackView.addArrangedSubview(phoneNumberTextField)
        mainStackView.addArrangedSubview(emailTextField)
        mainStackView.addArrangedSubview(passwordStackView)
        mainStackView.addArrangedSubview(registerButton)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.88),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 220),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 60),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 60),
            emailTextField.heightAnchor.constraint(equalToConstant: 60),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60),
            registerButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func switchButtonTapped() {
        passwordTextField.isSecureTextEntry = !passwordSwitchButton.isOn
    }
    
    @objc private func registerButtonTapped() {
        if let writtenFullName = fullNameTextField.text, !writtenFullName.isEmpty,
           let writtenPhoneNumber = phoneNumberTextField.text, !writtenPhoneNumber.isEmpty,
           let writtenEmail = emailTextField.text, !writtenEmail.isEmpty,
           let writtenPassword = passwordTextField.text, !writtenPassword.isEmpty {
            let userInfo: User = .init(fullName: writtenFullName,
                                       phoneNumber: writtenPhoneNumber,
                                       email: writtenEmail,
                                       password: writtenPassword)
            
            print("""
                Registration Complete!
                
                Full Name: \(userInfo.fullName)
                Phone Number: \(userInfo.phoneNumber)
                Email: \(userInfo.email)
                Password: \(userInfo.password)
                """)
            
            fileManager.users.append(userInfo)
            fileManager.saveUser()
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let SceneDelegate = windowScene.delegate as? SceneDelegate {
                SceneDelegate.setLoginAsRoot()
            }
        } else {
            showDefaultAlert(title: "Registration Incomplete!",
                             message: "All gaps must be filled")
        }
    }
}

//MARK: Register Delegate

extension RegisterController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersInRanges ranges: [NSValue], replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
