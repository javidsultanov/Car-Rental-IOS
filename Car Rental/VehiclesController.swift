//
//  VehiclesController.swift
//  Car Rental
//
//  Created by Javid Sultanov on 01.08.26.
//

import UIKit

class VehiclesController: UIViewController {
    private var fileManager = CarFileManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fileManager.getCarItems()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Car Rental"
    }
}
