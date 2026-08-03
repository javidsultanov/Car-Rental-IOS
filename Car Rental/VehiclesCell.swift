//
//  VehiclesCell.swift
//  Car Rental
//
//  Created by Javid Sultanov on 01.08.26.
//

import UIKit

class VehiclesCell: UICollectionViewCell {
    private var carImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var carBrandLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var carModelLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var engineLabel: UILabel = {
        let label = UILabel()
        label.text = "Engine"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var carEngineLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var carPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var monthLabel: UILabel = {
        let label = UILabel()
        label.text = "/ month"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        contentView.layer.cornerRadius = 28
        contentView.backgroundColor = .systemBackground
        contentView.clipsToBounds = true
    }
    
    private func configureConstraints() {
        contentView.addSubview(carImageView)
        contentView.addSubview(carBrandLabel)
        contentView.addSubview(carPriceLabel)
        contentView.addSubview(monthLabel)
        contentView.addSubview(carModelLabel)
        contentView.addSubview(engineLabel)
        contentView.addSubview(carEngineLabel)
        
        NSLayoutConstraint.activate([
            carImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            carImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            carImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            carImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            carBrandLabel.topAnchor.constraint(equalTo: carImageView.topAnchor, constant: 16),
            carBrandLabel.leadingAnchor.constraint(equalTo: carImageView.leadingAnchor, constant: 16),
            
            carPriceLabel.topAnchor.constraint(equalTo: carImageView.topAnchor, constant: 16),
            carPriceLabel.trailingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: -16),
            
            monthLabel.topAnchor.constraint(equalTo: carPriceLabel.bottomAnchor, constant: 4),
            monthLabel.trailingAnchor.constraint(equalTo: carPriceLabel.trailingAnchor),
            
            carModelLabel.topAnchor.constraint(equalTo: carBrandLabel.bottomAnchor, constant: 8),
            carModelLabel.leadingAnchor.constraint(equalTo: carBrandLabel.leadingAnchor),
            
            engineLabel.bottomAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: -12),
            engineLabel.leadingAnchor.constraint(equalTo: carBrandLabel.leadingAnchor),
            
            carEngineLabel.bottomAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: -12),
            carEngineLabel.trailingAnchor.constraint(equalTo: carPriceLabel.trailingAnchor),
        ])
    }
    
    func configureCell(car: Car) {
        carImageView.image = UIImage(named: car.carImage)
        carBrandLabel.text = car.carBrand
        carPriceLabel.text = "$\(Int(car.carPrice))"
        carModelLabel.text = car.carModel
        carEngineLabel.text = car.carEngine
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
