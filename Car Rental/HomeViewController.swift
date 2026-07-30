//
//  HomeViewController.swift
//  Car Rental
//
//  Created by Javid Sultanov on 31.07.26.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Car Rental"
    }
}
