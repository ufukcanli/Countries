//
//  DetailViewModel.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func didFinishFetching(_ country: CountryDetail)
    func didFinishChecking(_ isFavorited: Bool)
    func didFinishLoading()
}

final class DetailViewModel {
    
    private(set) var isFavorited: Bool?
    private var country: CountryDetail?
    weak var delegate: DetailViewModelDelegate?
    
    private let code: String
    
    init(code: String) {
        self.code = code
        self.fetchCountry()
    }
    
    func fetchCountry() {
        NetworkManager.shared.getCountry(by: code) { [weak self] result in
            switch result {
            case .success(let country):
                self?.country = country.data
                self?.delegate?.didFinishFetching(country.data)
                self?.isAlreadyFavorited(country.data.id)
                self?.delegate?.didFinishLoading()
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func didTapFavoriteButton() {
        guard let country = self.country else { return }
        let theCountry = Country(code: country.code, name: country.name, id: country.id)
        if let isFavorited = isFavorited, isFavorited == true {
            remove(theCountry)
        } else {
            save(theCountry)
        }
    }
    
    private func save(_ country: Country) {
        PersistenceManager.update(with: country, actionType: .add) { error in
            // TODO: if error happens show alert
            print(error?.rawValue as Any)
            self.isAlreadyFavorited(country.id)
        }
    }
    
    private func remove(_ country: Country) {
        PersistenceManager.update(with: country, actionType: .remove) { error in
            // TODO: if error happens show alert
            print(error?.rawValue as Any)
            self.isAlreadyFavorited(country.id)
        }
    }
    
    private func isAlreadyFavorited(_ id: String) {
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                if favorites.contains(where: { $0.id == self.country?.id }) {
                    self.isFavorited = true
                    self.delegate?.didFinishChecking(true)
                    print(favorites)
                } else {
                    self.isFavorited = false
                    self.delegate?.didFinishChecking(false)
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}
