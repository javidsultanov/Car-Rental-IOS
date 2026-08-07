//
//  UserEntity+CoreDataProperties.swift
//  Car Rental
//
//  Created by Javid Sultanov on 07.08.26.
//
//

public import Foundation
public import CoreData


public typealias UserEntityCoreDataPropertiesSet = NSSet

extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension UserEntity : Identifiable {

}
