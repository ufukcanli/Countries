//
//  DetailViewController+Ext.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import UIKit

fileprivate let padding: CGFloat = 16

// MARK: - ConfigureUI
extension DetailViewController {
    
    func configureNavigationBar() {
        navigationItem.title = "Detail"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func configureNavigationBarButton(with name: String = "star.fill") {
        favoriteButton.target = self
        favoriteButton.style = .plain
        favoriteButton.action = #selector(didTapFavoriteButton)
        favoriteButton.image = UIImage(systemName: name)
        favoriteButton.tintColor = .systemYellow
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    func configureCountryCodeLabel() {
        view.addSubview(countryCodeLabel)
        
        countryCodeLabel.attributedText = createAttributedString("Country Code: ", "")
        countryCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            countryCodeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            countryCodeLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: padding),
            countryCodeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureMoreInfoButton() {
        view.addSubview(moreInfoButton)
        
        moreInfoButton.addTarget(self, action: #selector(didTapMoreInfo), for: .touchUpInside)
        moreInfoButton.setTitle("For More Information →", for: .normal)
        moreInfoButton.titleLabel?.font = .preferredFont(forTextStyle: .body)
        moreInfoButton.backgroundColor = .systemGray2
        moreInfoButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moreInfoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            moreInfoButton.topAnchor.constraint(equalTo: countryCodeLabel.bottomAnchor, constant: padding),
            
            moreInfoButton.widthAnchor.constraint(equalToConstant: 200),
            moreInfoButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureFlagImageView() {
        view.addSubview(flagImageView)
        
        // TODO: Display loading and placeholder image
        flagImageView.image = UIImage(named: "flag")
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            flagImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flagImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            flagImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            flagImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
