//
//  Movie.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import Foundation

// MARK: - MoviesModel - from JSON
struct MoviesModel: Codable, Equatable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie Result Model
struct Movie: Codable, Equatable {
    let id: Int
    let originalTitle: String?
    let overview, posterPath: String
    let title: String?
    let popularity: Double
    let releaseDate: String?
    let voteAverage: Double
    let originalName, name, firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case title
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case originalName = "original_name"
        case name
        case firstAirDate = "first_air_date"
    }
}
