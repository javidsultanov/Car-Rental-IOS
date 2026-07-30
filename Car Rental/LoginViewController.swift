//
//  LoginViewController.swift
//  Car Rental
//
//  Created by Javid Sultanov on 29.07.26.
//

import UIKit

class LoginViewController: UIViewController {
    private var backgroungImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cars")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.alpha = 0.2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var mainStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBlue
        title = "Login"
    }
    
    private func configureConstraints() {
        view.addSubview(backgroungImageView)
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            backgroungImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroungImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroungImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroungImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
