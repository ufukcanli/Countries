//
//  FavoritesViewModel.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import Foundation

protocol FavoritesViewModelDelegate: AnyObject {
    func didFinishLoading()
    func didFinishFetching()
    func didFinishWithError()
}

final class FavoritesViewModel {
    
    private(set) var favorites: [Country] = []
    private(set) var errorMessage: String = ""
    
    weak var delegate: FavoritesViewModelDelegate?
    private var timer: Timer?
    
    var numberOfRowsInSection: Int {
        return favorites.count
    }
    
    var shouldShowEmptyState: Bool {
        if favorites.count > 0 { return true }
        return false
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Country {
        return favorites[indexPath.row]
    }
    
    func removeCountry(at indexPath: IndexPath) {
        print("removeCountry", indexPath.row)
        let country = favorites[indexPath.row]
        PersistenceManager.update(with: country, actionType: .remove) { error in
            print(error?.rawValue as Any)
            self.fetchFavorites()
        }
    }
    
    func fetchFavorites() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { timer in
            PersistenceManager.retrieveFavorites { [weak self] result in
                switch result {
                case .success(let favorites):
                    self?.favorites = favorites
                    self?.delegate?.didFinishLoading()
                    self?.delegate?.didFinishFetching()
                case .failure(let error):
                    self?.errorMessage = error.rawValue
                    self?.delegate?.didFinishLoading()
                    self?.delegate?.didFinishWithError()
                }
            }
        }
    }
}
