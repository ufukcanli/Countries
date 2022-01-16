//
//  NetworkManager.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
        
    private init() {}
    
    func getCountries(by limit: Int, completion: @escaping (Result<CountryResponse, CustomError>) -> Void) {
        let endpoint = "https://\(K.BASE_URL)/geo/countries?limit=\(limit)"
        taskForGetRequest(endpoint: endpoint, completion: completion)
    }
    
    func getCountry(by code: String, completion: @escaping (Result<CountryDetailResponse, CustomError>) -> Void) {
        let endpoint = "https://\(K.BASE_URL)/geo/countries/\(code)"
        taskForGetRequest(endpoint: endpoint, completion: completion)
    }
}

private extension NetworkManager {
    func taskForGetRequest<T: Decodable>(endpoint: String, completion: @escaping (Result<T, CustomError>) -> Void) {
        var request = URLRequest(url: URL(string: endpoint)!)
        request.allHTTPHeaderFields = ["x-rapidapi-host": "\(K.BASE_URL)", "x-rapidapi-key": "\(K.API_KEY)"]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseObject = try decoder.decode(T.self, from: data)
                completion(.success(responseObject))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
