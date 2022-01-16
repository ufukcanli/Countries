//
//  CountryModel.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import Foundation

struct CountryResponse: Codable {
    let data: [Country]
}

struct Country: Codable {
    let code: String
    let name: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case code, name
        case id = "wikiDataId"
    }
}

struct CountryDetailResponse: Codable {
    let data: CountryDetail
}

struct CountryDetail: Codable {
    let capital: String
    let code: String
    let flag: String
    let name: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case capital, code, name
        case flag = "flagImageUri"
        case id = "wikiDataId"
    }
}
