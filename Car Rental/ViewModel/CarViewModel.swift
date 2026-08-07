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
    
    func loadCar(carImage: String,
                 carBrand: String,
                 carModel: String,
                 carCategory: String,
                 carEngine: String,
                 carPrice: Double) {
        
        manager.loadCar(carImage: carImage,
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
    
    func loadCarsToCoreData() {
        guard let url = Bundle.main.url(forResource: "Car", withExtension: "json") else {
            errorCallback?("Error")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let cars = try JSONDecoder().decode([Car].self, from: data)
            
            for car in cars {
                loadCar(carImage: car.carImage,
                        carBrand: car.carBrand,
                        carModel: car.carModel,
                        carCategory: car.carCategory,
                        carEngine: car.carEngine,
                        carPrice: car.carPrice)
            }
        } catch {
            errorCallback?(error.localizedDescription)
        }
    }
}
