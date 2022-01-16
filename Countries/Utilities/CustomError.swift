//
//  CustomError.swift
//  Countries
//
//  Created by Ufuk Canlı on 16.01.2022.
//

import Foundation

enum CustomError: String, Error {
    case unableToComplete = "Unable complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this country. Please try again."
    case alreadyInFavorites = "You've already favorited this country. You must REALLY like it!"
}
