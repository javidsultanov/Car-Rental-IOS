//
//  Car.swift
//  Car Rental
//
//  Created by Javid Sultanov on 31.07.26.
//

import Foundation

struct Car: Codable {
    var carImage: String
    var carBrand: String
    var carModel: String
    var carCategory: String
    var carEngine: String
    var carPrice: Double
}
