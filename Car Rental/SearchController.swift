//
//  SearchController.swift
//  Car Rental
//
//  Created by Javid Sultanov on 01.08.26.
//

import UIKit

//MARK: Search View

class SearchController: UIViewController {
    private var carCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = .init(top: 72,
                                    left: 0,
                                    bottom: 0,
                                    right: 0)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(SearchCell.self, forCellWithReuseIdentifier: "SearchCell")
        view.backgroundColor = .secondarySystemBackground
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
    
//    private var fileManager = CarFileManager()
    
    private let viewModel = CarViewModel()
    
//    private var filteredCars: [Car] = []
    
    private var filteredCars: [CarEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
//        fileManager.getCarItems()
        
//        filteredCars = fileManager.cars
        configureViewModel()
        
    }
    
    //MARK: View Functions
    
    private func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        navigationItem.title = "Search"
        
        carCollectionView.dataSource = self
        carCollectionView.delegate = self
        searchBar.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func configureConstraints() {
        view.addSubview(carCollectionView)
        carCollectionView.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            carCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            carCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.92),
            carCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            searchBar.topAnchor.constraint(equalTo: carCollectionView.contentLayoutGuide.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: carCollectionView.frameLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: carCollectionView.frameLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureViewModel() {
        viewModel.successCallback = {
            if self.viewModel.cars.isEmpty {
                self.viewModel.loadCarsToCoreData()
            } else {
                self.filteredCars = self.viewModel.cars
                self.carCollectionView.reloadData()
            }
        }
        
        viewModel.errorCallback = { message in
            self.showDefaultAlert(title: "Error",
                                  message: message)
        }
        
        viewModel.fetchCars()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SearchController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredCars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(car: filteredCars[indexPath.item])
        return cell
    }
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return .init(width: width, height: 324)
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //        if searchText.isEmpty {
        //            filteredCars = fileManager.cars
        //        } else {
        //            filteredCars = fileManager.cars.filter({ $0.carBrand.lowercased().contains(searchText.lowercased()) || $0.carModel.lowercased().contains(searchText.lowercased())
//    })
//        }
//        
//        carCollectionView.reloadData()
        
        if searchText.isEmpty {
            filteredCars = viewModel.cars
        } else {
            filteredCars = viewModel.cars.filter({
                ($0.carBrand ?? "").lowercased().contains(searchText.lowercased()) ||
                ($0.carModel ?? "").lowercased().contains(searchText.lowercased())
            })
        }
        
        carCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
