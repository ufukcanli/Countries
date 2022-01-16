//
//  CountriesViewModel.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import Foundation

protocol CountriesViewModelDelegate: AnyObject {
    func didFinishLoading()
    func didFinishFetching()
    func didFinishWithError()
}

final class CountriesViewModel {
        
    private(set) var countries: [Country] = []
    private(set) var errorMessage: String = ""
    
    weak var delegate: CountriesViewModelDelegate?
    
    var numberOfRowsInSection: Int {
        return countries.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> Country {
        return countries[indexPath.row]
    }
    
    func saveCountry(at indexPath: IndexPath) {
        print("saveCountry", indexPath.row)
        let country = countries[indexPath.row]
        PersistenceManager.update(with: country, actionType: .add) { error in
            // TODO: if error happens show alert
            print(error?.rawValue as Any)
        }
    }
    
    func removeCountry(at indexPath: IndexPath) {
        print("removeCountry", indexPath.row)
        let country = countries[indexPath.row]
        PersistenceManager.update(with: country, actionType: .remove) { error in
            // TODO: if error happens show alert
            print(error?.rawValue as Any)
        }
    }
    
    func fetchCountries() {
        NetworkManager.shared.getCountries(by: 10) { [weak self] result in
            switch result {
            case .success(let response):
                self?.countries = response.data
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
