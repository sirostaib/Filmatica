//
//  MovieHelper.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import Foundation

class MovieHelper {
    public static let shared: MovieHelper = MovieHelper()

    public func getMovieName(movie: Movie) -> String {
        return movie.title ?? movie.originalTitle ?? movie.name ?? movie.originalName ?? "Movie..."
    }

    public func getMovieReleaseDate(movie: Movie) -> String {
        return movie.releaseDate ?? movie.firstAirDate ?? "..."
    }

    public func getRatingText(vote: Double) -> String {
        return " ⭐️  \(String(format: "%.1f", vote))/10 "
    }
}
