//
//  CarDataBaseManager.swift
//  Car Rental
//
//  Created by Javid Sultanov on 07.08.26.
//

import Foundation
import CoreData
import UIKit

class CarDataBaseManager {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchCallback: (([CarEntity]) -> Void)?
    var saveCallback: ((CarEntity) -> Void)?
    var errorCallback: ((String) -> Void)?
    
    func getCars() {
        do {
            let cars = try context.fetch(CarEntity.fetchRequest())
            fetchCallback?(cars)
        } catch {
            errorCallback?(error.localizedDescription)
        }
    }
    
    func saveCar(carImage: String,
                  carBrand: String,
                  carModel: String,
                  carCategory: String,
                  carEngine: String,
                  carPrice: Double) {
        
        let car = CarEntity(context: context)
        car.carImage = carImage
        car.carBrand = carBrand
        car.carModel = carModel
        car.carCategory = carCategory
        car.carEngine = carEngine
        car.carPrice = carPrice
        
        do {
            try context.save()
            saveCallback?(car)
            print("Car Saved")
        } catch {
            errorCallback?(error.localizedDescription)
        }
    }
}
