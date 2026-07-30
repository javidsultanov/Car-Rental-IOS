//
//  FileManager.swift
//  Car Rental
//
//  Created by Javid Sultanov on 31.07.26.
//

import Foundation

class UserFileManager {
    var users:[User] = []
    
    func getFilePath() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls[0].appendingPathComponent("User.json")
        print(url)
        return url
    }
    
    func saveUser() {
        do {
            let data = try JSONEncoder().encode(users)
            try data.write(to: getFilePath())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchData() {
        do {
            let data = try Data(contentsOf: getFilePath())
            users = try JSONDecoder().decode([User].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
