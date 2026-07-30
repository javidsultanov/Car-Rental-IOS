//
//  RegisterViewController.swift
//  Car Rental
//
//  Created by Javid Sultanov on 30.07.26.
//

import UIKit

class RegisterViewController: UIViewController {
    private var backgroundImageView: UIImageView = {
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
        title = "Register"
        view.backgroundColor = .systemBlue
    }
    
    private func configureConstraints() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
