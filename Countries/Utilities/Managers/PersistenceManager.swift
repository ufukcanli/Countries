//
//  PersistenceManager.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import Foundation

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let favorites = "favorites" }
    
    enum ActionType { case add, remove }
    
    static func update(with favorite: Country, actionType: ActionType, completion: @escaping (CustomError?) -> Void) {
        retrieveFavorites { result in
            switch result {
                case .success(var favorites):
                    switch actionType {
                    case .add:
                        guard !favorites.contains(where: { $0.id == favorite.id }) else {
                            completion(.alreadyInFavorites)
                            return
                        }
                        favorites.append(favorite)
                    case .remove:
                        favorites.removeAll { $0.id == favorite.id }
                    }
                    completion(save(favorites: favorites))
                case .failure(let error):
                    completion(error)
            }
        }
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[Country], CustomError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Country].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Country]) -> CustomError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
