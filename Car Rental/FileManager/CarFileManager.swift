//
//  CarFileManager.swift
//  Car Rental
//
//  Created by Javid Sultanov on 31.07.26.
//

import Foundation

class CarFileManager {
    var cars: [Car] = []
    
    func getCarItems() {
        guard let url = Bundle.main.url(forResource: "Car", withExtension: "json") else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            cars = try JSONDecoder().decode([Car].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
