//
//  VehiclesController.swift
//  Car Rental
//
//  Created by Javid Sultanov on 01.08.26.
//

import UIKit

//MARK: Vehicles View

class VehiclesController: UIViewController {
    private var carCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(VehiclesCell.self, forCellWithReuseIdentifier: "VehiclesCell")
        view.register(CarCategoryHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CarCategoryHeader")
        view.backgroundColor = .secondarySystemBackground
        view.isScrollEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
                
    private var fileManager = CarFileManager()
    
    private var filteredCars: [Car] = []
    
    private var selectedCarCategoryIndex = 0
    
    private var carCategories: [CarCategory] = [.init(carImage: "car_1",
                                                      carCategory: "Standard",
                                                      carCount: 0),
                                                .init(carImage: "car_2",
                                                      carCategory: "Prestige",
                                                      carCount: 0),
                                                .init(carImage: "car_3",
                                                      carCategory: "SUV",
                                                      carCount: 0)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        fileManager.getCarItems()
        updateCategoryCounts()
        filterCars()
    }
    
    //MARK: View Functions
    
    private func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "Car Rental"
        
        carCollectionView.delegate = self
        carCollectionView.dataSource = self
    }
    
    private func configureConstraints() {
        view.addSubview(carCollectionView)
        
        NSLayoutConstraint.activate([
            carCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            carCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
            carCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func updateCategoryCounts() {
        for index in carCategories.indices {
            carCategories[index].carCount = fileManager.cars.filter({ $0.carCategory == carCategories[index].carCategory }).count
        }
    }
    
    private func filterCars() {
        filteredCars = fileManager.cars.filter({ $0.carCategory == carCategories[selectedCarCategoryIndex].carCategory })
        
        carCollectionView.reloadData()
    }
}

//  MARK: Vehicles DataSource | Delegate

extension VehiclesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredCars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VehiclesCell", for: indexPath) as? VehiclesCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(car: filteredCars[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CarCategoryHeader", for: indexPath) as? CarCategoryHeader else {
            return UICollectionReusableView()
        }
        
        header.configureHeader(carCategories: carCategories, selectedIndex: selectedCarCategoryIndex)
        header.carCategoryCallback = { selectedIndex in
            self.selectedCarCategoryIndex = selectedIndex
            self.filterCars()
        }
        return header
    }
}

//MARK: Vehicles FlowLayout

extension VehiclesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return .init(width: width, height: 324)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        return .init(width: width, height: 192)
    }
}
