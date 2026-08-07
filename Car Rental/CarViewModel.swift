//
//  CarViewModel.swift
//  Car Rental
//
//  Created by Javid Sultanov on 07.08.26.
//

import Foundation

class CarViewModel {
    var cars: [CarEntity] = []
    
    private let manager = CarDataBaseManager()
    
    var successCallback: (() -> Void)?
    var errorCallback: ((String) -> Void)?
    
    init() {
        configureDataBaseManager()
    }
    
    func fetchCars() {
        manager.getCars()
    }
    
    func saveCar(carImage: String,
                 carBrand: String,
                 carModel: String,
                 carCategory: String,
                 carEngine: String,
                 carPrice: Double) {
        
        manager.saveCar(carImage: carImage,
                        carBrand: carBrand,
                        carModel: carModel,
                        carCategory: carCategory,
                        carEngine: carEngine,
                        carPrice: carPrice)
    }
    
    private func configureDataBaseManager() {
        manager.fetchCallback = { cars in
            self.cars = cars
            self.successCallback?()
        }
        
        manager.errorCallback = { message in
            self.errorCallback?(message)
        }
        
        manager.saveCallback = { car in
            self.cars.append(car)
            self.successCallback?()
        }
    }
}
