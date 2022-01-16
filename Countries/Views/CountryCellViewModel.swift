//
//  CountryCellViewModel.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import Foundation

final class CountryCellViewModel {
    
    static let reuseIdentifier = "CountryCell"
    
    private(set) var countryName: String
    private(set) var isFavorited: Bool = false
    
    private let country: Country
    
    init(country: Country) {
        self.country = country
        self.countryName = country.name
        self.isAlreadyFavorited()
    }
    
    var imageName: String {
        if isFavorited { return "star.fill" }
        return "star"
    }
    
    private func isAlreadyFavorited() {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                if favorites.contains(where: { $0.id == self.country.id }) {
                    self.isFavorited = true
                } else {
                    self.isFavorited = false
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
