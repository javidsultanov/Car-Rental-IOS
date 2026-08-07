//
//  UserViewModel.swift
//  Car Rental
//
//  Created by Javid Sultanov on 07.08.26.
//

import Foundation

class UserViewModel {
    var users: [UserEntity] = []
    
    private let manager = UserDataBaseManager()
    
    var successCallback: (() -> Void)?
    var errorCallback: ((String) -> Void)?
    
    init() {
        configureDataBaseManager()
    }
    
    func fetchUsers() {
        manager.getUsers()
    }
    
    func saveUser(fullName: String,
                  phoneNumber: String,
                  email: String,
                  password: String) {
        
        manager.saveUser(fullName: fullName,
                         phoneNumber: phoneNumber,
                         email: email,
                         password: password)
    }
    
    private func configureDataBaseManager() {
        manager.fetchCallback = { users in
            self.users = users
            self.successCallback?()
        }
        
        manager.errorCallback = { message in
            self.errorCallback?(message)
        }
        
        manager.saveCallback = { user in
            self.users.append(user)
            self.successCallback?()
        }
    }
}
