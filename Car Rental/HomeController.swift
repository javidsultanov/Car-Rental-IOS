//
//  HomeViewController.swift
//  Car Rental
//
//  Created by Javid Sultanov on 31.07.26.
//

import UIKit

class HomeController: UIViewController {
    private var fileManager = CarFileManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fileManager.getCarItems()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Car Rental"
    }
}
