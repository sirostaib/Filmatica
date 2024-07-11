//
//  MovieHelperTest.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
@testable import Filmatica

class MovieHelperTests: XCTestCase {

    func testGetMovieName() {
        // Arrange
        let helper = MovieHelper.shared
        let movieWithTitle = Movie(id: 1, originalTitle: nil, overview: "",
                                   posterPath: "", title: "Movie A", popularity: 7.5,
                                   releaseDate: nil, voteAverage: 7.5, originalName: nil, name: nil, firstAirDate: nil)
        let movieWithOriginalTitle = Movie(id: 2, originalTitle: "Original Movie B", overview: "",
                                           posterPath: "", title: nil, popularity: 8.0,
                                           releaseDate: nil, voteAverage: 8.0, originalName: nil,
                                           name: nil, firstAirDate: nil)

        // Act
        let name1 = helper.getMovieName(movie: movieWithTitle)
        let name2 = helper.getMovieName(movie: movieWithOriginalTitle)

        // Assert
        XCTAssertEqual(name1, "Movie A")
        XCTAssertEqual(name2, "Original Movie B")
    }

    func testGetMovieReleaseDate() {
        // Arrange
        let helper = MovieHelper.shared
        let movieWithReleaseDate = Movie(id: 1, originalTitle: nil,
                                         overview: "", posterPath: "", title: "Movie A",
                                         popularity: 7.5, releaseDate: "2023-01-01",
                                         voteAverage: 7.5, originalName: nil, name: nil, firstAirDate: nil)
        let movieWithFirstAirDate = Movie(id: 2, originalTitle: nil, overview: "",
                                          posterPath: "", title: "Movie B", popularity: 8.0,
                                          releaseDate: nil, voteAverage: 8.0, originalName: nil,
                                          name: nil, firstAirDate: "2022-12-31")

        // Act
        let date1 = helper.getMovieReleaseDate(movie: movieWithReleaseDate)
        let date2 = helper.getMovieReleaseDate(movie: movieWithFirstAirDate)

        // Assert
        XCTAssertEqual(date1, "2023-01-01")
        XCTAssertEqual(date2, "2022-12-31")
    }

    func testGetRatingText() {
        // Arrange
        let helper = MovieHelper.shared
        let rating1 = 8.3
        let rating2 = 6.7

        // Act
        let text1 = helper.getRatingText(vote: rating1)
        let text2 = helper.getRatingText(vote: rating2)

        // Assert
        XCTAssertEqual(text1, " ⭐️  8.3/10 ")
        XCTAssertEqual(text2, " ⭐️  6.7/10 ")
    }
}
