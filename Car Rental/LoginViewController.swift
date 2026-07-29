//
//  LoginViewController.swift
//  Car Rental
//
//  Created by Javid Sultanov on 29.07.26.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Login"
    }
}
