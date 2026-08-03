//
//  CarCategoryCell.swift
//  Car Rental
//
//  Created by Javid Sultanov on 03.08.26.
//

import UIKit

class CarCategoryCell: UICollectionViewCell {
    private var carImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var carCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var carCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
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
        contentView.addSubview(carCategoryLabel)
        contentView.addSubview(carCountLabel)
        
        NSLayoutConstraint.activate([
            carImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            carImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            carImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            carImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            carCategoryLabel.centerXAnchor.constraint(equalTo: carImageView.centerXAnchor),
            carCategoryLabel.bottomAnchor.constraint(equalTo: carCountLabel.topAnchor),
            
            carCountLabel.centerXAnchor.constraint(equalTo: carImageView.centerXAnchor),
            carCountLabel.bottomAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: -4)
        ])
    }
    
    func configureCell(carCategory: CarCategory, selected: Bool) {
        carImageView.image = UIImage(named: carCategory.carImage)
        carCategoryLabel.text = carCategory.carCategory
        carCountLabel.text = "\(carCategory.carCount)"
        
        if selected {
            contentView.backgroundColor = .blue
            carCategoryLabel.textColor = .white
            carCountLabel.textColor = .white
        } else {
            contentView.backgroundColor = .systemBackground
            carCategoryLabel.textColor = .black
            carCountLabel.textColor = .gray
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
