//
//  CarCategoryHeader.swift
//  Car Rental
//
//  Created by Javid Sultanov on 05.08.26.
//

import UIKit

class CarCategoryHeader: UICollectionReusableView {
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
    
    private var vehiclesLabel: UILabel = {
        let label = UILabel()
        label.text = "Available Vehicles"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var carCategories: [CarCategory] = []
    
    private var selectedCarCategoryIndex = 0
    
    var categorySelected: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        backgroundColor = .secondarySystemBackground
        
        carCategoryCollectionView.delegate = self
        carCategoryCollectionView.dataSource = self
    }
    
    private func configureConstraints() {
        addSubview(carCategoryCollectionView)
        addSubview(vehiclesLabel)

        NSLayoutConstraint.activate([
            carCategoryCollectionView.topAnchor.constraint(equalTo: topAnchor),
            carCategoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            carCategoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            carCategoryCollectionView.heightAnchor.constraint(equalToConstant: 140),
            
            vehiclesLabel.topAnchor.constraint(equalTo: carCategoryCollectionView.bottomAnchor, constant: 16),
            vehiclesLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    func configureHeader(carCategories: [CarCategory], selectedIndex: Int) {
        self.carCategories = carCategories
        selectedCarCategoryIndex = selectedIndex
        carCategoryCollectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CarCategoryHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        carCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCategoryCell", for: indexPath) as? CarCategoryCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(carCategory: carCategories[indexPath.item],selected: indexPath.item == selectedCarCategoryIndex)
        return cell
    }
}

extension CarCategoryHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 120, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCarCategoryIndex = indexPath.item
        carCategoryCollectionView.reloadData()
        
        categorySelected?(indexPath.item)
    }
}
