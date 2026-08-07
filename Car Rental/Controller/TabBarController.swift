//
//  TabBarController.swift
//  Car Rental
//
//  Created by Javid Sultanov on 01.08.26.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    private func configureUI() {
        let vehiclesController = VehiclesController()
        vehiclesController.tabBarItem = .init(title: "Vehicles",
                                              image: .init(systemName: "steeringwheel"),
                                              tag: 0)
        let vehiclesNavigation = UINavigationController(rootViewController: vehiclesController)
        
        let searchController = SearchController()
        searchController.tabBarItem = .init(title: "Search",
                                            image: .init(systemName: "magnifyingglass"),
                                            tag: 0)
        let searchNavigation = UINavigationController(rootViewController: searchController)
        
        let profileController = ProfileController()
        profileController.tabBarItem = .init(title: "Profile",
                                             image: .init(systemName: "person.fill"),
                                             tag: 0)
        let profileNavigation = UINavigationController(rootViewController: profileController)
        
        viewControllers = [vehiclesNavigation, searchNavigation, profileNavigation]
    }
}
