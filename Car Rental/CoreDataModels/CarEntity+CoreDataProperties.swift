//
//  CarEntity+CoreDataProperties.swift
//  Car Rental
//
//  Created by Javid Sultanov on 07.08.26.
//
//

public import Foundation
public import CoreData


public typealias CarEntityCoreDataPropertiesSet = NSSet

extension CarEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarEntity> {
        return NSFetchRequest<CarEntity>(entityName: "CarEntity")
    }

    @NSManaged public var carImage: String?
    @NSManaged public var carBrand: String?
    @NSManaged public var carModel: String?
    @NSManaged public var carCategory: String?
    @NSManaged public var carEngine: String?
    @NSManaged public var carPrice: Double

}

extension CarEntity : Identifiable {

}
