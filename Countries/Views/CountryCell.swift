//
//  CountryCell.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import UIKit

final class CountryCell: UITableViewCell {
        
    private lazy var starImageView = UIImageView()
    private lazy var countryNameLabel = UILabel()
    
    private let padding: CGFloat = 16
    
    private var viewModel: CountryCellViewModel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCountryNameLabel()
        configureStarImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateCell(with viewModel: CountryCellViewModel) {
        self.viewModel = viewModel
        self.countryNameLabel.text = viewModel.countryName
        self.starImageView.image = UIImage(systemName: viewModel.imageName)
    }
}

// MARK: - Configure UI
private extension CountryCell {
    
    func configureStarImageView() {
        starImageView.tintColor = .systemYellow
        starImageView.image = UIImage(systemName: "star")
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(starImageView)

        NSLayoutConstraint.activate([
            starImageView.leadingAnchor.constraint(equalTo: countryNameLabel.trailingAnchor, constant: -padding),
            starImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding - 1),
            starImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            starImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding + 1),
        ])
    }
    
    func configureCountryNameLabel() {
        countryNameLabel.textColor = .label
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(countryNameLabel)
        
        NSLayoutConstraint.activate([
            countryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            countryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            countryNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
