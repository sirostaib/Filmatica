//
//  MovieModelTest.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
@testable import Filmatica

class MoviesModelTests: XCTestCase {

    func testMoviesModelDecoding() {
        let json = """
        {
            "page": 1,
            "results": [
                {
                    "id": 123,
                    "original_title": "Original Title",
                    "overview": "Overview",
                    "poster_path": "/path/to/poster.jpg",
                    "title": "Title",
                    "popularity": 100.0,
                    "release_date": "2021-07-01",
                    "vote_average": 8.0,
                    "original_name": "Original Name",
                    "name": "Name",
                    "first_air_date": "2021-06-01"
                }
            ],
            "total_pages": 10,
            "total_results": 100
        }
        """.data(using: .utf8)!

        do {
            let decodedMoviesModel = try JSONDecoder().decode(MoviesModel.self, from: json)
            XCTAssertEqual(decodedMoviesModel.page, 1)
            XCTAssertEqual(decodedMoviesModel.totalPages, 10)
            XCTAssertEqual(decodedMoviesModel.totalResults, 100)

            guard let movie = decodedMoviesModel.results.first else {
                XCTFail("Expected one movie in the results")
                return
            }

            XCTAssertEqual(movie.id, 123)
            XCTAssertEqual(movie.originalTitle, "Original Title")
            XCTAssertEqual(movie.overview, "Overview")
            XCTAssertEqual(movie.posterPath, "/path/to/poster.jpg")
            XCTAssertEqual(movie.title, "Title")
            XCTAssertEqual(movie.popularity, 100.0)
            XCTAssertEqual(movie.releaseDate, "2021-07-01")
            XCTAssertEqual(movie.voteAverage, 8)
            XCTAssertEqual(movie.originalName, "Original Name")
            XCTAssertEqual(movie.name, "Name")
            XCTAssertEqual(movie.firstAirDate, "2021-06-01")
        } catch {
            XCTFail("Failed to decode MoviesModel: \(error)")
        }
    }
}
