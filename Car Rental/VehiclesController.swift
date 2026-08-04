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
        view.backgroundColor = .secondarySystemBackground
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var carCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CarCategoryCell.self, forCellWithReuseIdentifier: "CarCategoryCell")
        view.backgroundColor = .secondarySystemBackground
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search for a car"
        bar.searchBarStyle = .minimal
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private var vehiclesLabel: UILabel = {
        let label = UILabel()
        label.text = "Available Vehicles"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var carCollectionHeightConstant: NSLayoutConstraint!
    
    private var fileManager = CarFileManager()
    
    private var selectedCarCategoryIndex: Int?
    
    private var carCategories: [CarCategory] = [.init(carImage: "car_1",
                                                      carCategory: "Standard",
                                                      carCount: 11),
                                                .init(carImage: "car_2",
                                                      carCategory: "Prestige",
                                                      carCount: 22),
                                                .init(carImage: "car_3",
                                                      carCategory: "SUV",
                                                      carCount: 33),
                                                .init(carImage: "car_4",
                                                      carCategory: "Standard",
                                                      carCount: 44)]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        fileManager.getCarItems()
        carCategoryCollectionView.reloadData()
        carCollectionView.reloadData()
        
        carCollectionView.layoutIfNeeded()
        carCollectionHeightConstant.constant = carCollectionView.contentSize.height
    }
    
    //MARK: View Functions
    
    private func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "Car Rental"
        
        carCollectionView.delegate = self
        carCollectionView.dataSource = self
        
        carCategoryCollectionView.dataSource = self
        carCategoryCollectionView.delegate = self
        }
    
    private func configureConstraints() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(searchBar)
        scrollView.addSubview(carCategoryCollectionView)
        scrollView.addSubview(vehiclesLabel)
        scrollView.addSubview(carCollectionView)
        
        carCollectionHeightConstant = carCollectionView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            searchBar.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 8),
            searchBar.centerXAnchor.constraint(equalTo: scrollView.frameLayoutGuide.centerXAnchor),
            searchBar.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 0.92),
            
            carCategoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            carCategoryCollectionView.centerXAnchor.constraint(equalTo: scrollView.frameLayoutGuide.centerXAnchor),
            carCategoryCollectionView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 0.92),
            carCategoryCollectionView.heightAnchor.constraint(equalToConstant: 140),
            
            vehiclesLabel.topAnchor.constraint(equalTo: carCategoryCollectionView.bottomAnchor, constant: 16),
            vehiclesLabel.leadingAnchor.constraint(equalTo: carCollectionView.leadingAnchor),
            
            carCollectionView.topAnchor.constraint(equalTo: vehiclesLabel.bottomAnchor, constant: 16),
            carCollectionView.centerXAnchor.constraint(equalTo: scrollView.frameLayoutGuide.centerXAnchor),
            carCollectionView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, multiplier: 0.92),
            carCollectionHeightConstant,
            carCollectionView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
    }
}

//  MARK: Vehicles DataSource | Delegate

extension VehiclesController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == carCategoryCollectionView {
            return carCategories.count
        } else {
            return fileManager.cars.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == carCategoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCategoryCell", for: indexPath) as? CarCategoryCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(carCategory: carCategories[indexPath.item],selected: indexPath.item == selectedCarCategoryIndex)
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VehiclesCell", for: indexPath) as? VehiclesCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(car: fileManager.cars[indexPath.item])
        return cell
    }
}

//MARK: Vehicles FlowLayout

extension VehiclesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == carCategoryCollectionView {
            return .init(width: 120, height: 140)
        } else {
            let width = collectionView.frame.width
            return .init(width: width, height: 324)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == carCategoryCollectionView {
            selectedCarCategoryIndex = indexPath.item
            carCategoryCollectionView.reloadData()
        }
    }
}
