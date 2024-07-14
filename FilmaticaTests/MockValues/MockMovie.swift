//
//  MockMovie.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import Foundation
@testable import Filmatica

class MockMovie: Equatable {
    static func == (lhs: MockMovie, rhs: MockMovie) -> Bool {
        false
    }

    static var movie1 = Movie(id: 1, originalTitle: "Titanic Movie",
                      overview: "this is the titanic movie", posterPath: "abcdefg.com",
                    title: "Titanic",
                    popularity: 9.7, releaseDate: "2020",
                    voteAverage: 8.5,
                    originalName: "titanic", name: "titanic",
                      firstAirDate: "2020")

    static var movie2 = Movie(id: 2, originalTitle: "Shawshank Movie",
                      overview: "this is the Shawshank movie", posterPath: "abcdefg.com",
                    title: "Titanic",
                    popularity: 9.9, releaseDate: "2023",
                    voteAverage: 8.0,
                    originalName: "titanic", name: "Shawkshank",
                      firstAirDate: "2021")
}
