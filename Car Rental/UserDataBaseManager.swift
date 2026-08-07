//
//  UserDataBaseManager.swift
//  Car Rental
//
//  Created by Javid Sultanov on 07.08.26.
//

import Foundation
import CoreData
import UIKit

class UserDataBaseManager {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fetchCallback: (([UserEntity]) -> Void)?
    var saveCallback: ((UserEntity) -> Void)?
    var errorCallback: ((String) -> Void)?
    
    func getUsers() {
        do {
            let users = try context.fetch(UserEntity.fetchRequest())
            fetchCallback?(users)
        } catch {
            errorCallback?(error.localizedDescription)
        }
    }
    
    func saveUser(fullName: String,
                  phoneNumber: String,
                  email: String,
                  password: String) {
        
        let user = UserEntity(context: context)
        user.fullName = fullName
        user.phoneNumber = phoneNumber
        user.email = email
        user.password = password
        
        do {
            try context.save()
            saveCallback?(user)
            print("User Saved")
        } catch {
            errorCallback?(error.localizedDescription)
        }
    }
}
