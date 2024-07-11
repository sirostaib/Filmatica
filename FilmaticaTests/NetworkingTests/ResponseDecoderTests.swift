//
//  ResponseDecoderTests.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
import RxBlocking
@testable import Filmatica

class ResponseDecoderTests: XCTestCase {

    var decoder: ResponseDecoder!

    override func setUp() {
        super.setUp()
        decoder = ResponseDecoder()
    }

    override func tearDown() {
        decoder = nil
        super.tearDown()
    }

    func testDecodeResponse_SuccessfulDecoding() {
        // Arrange
        let jsonData = """
                         {
                             "id": 1,
                             "original_title": "Test Movie",
                             "overview": "This is a test movie",
                             "poster_path": "/test.jpg",
                             "title": "Test Movie",
                             "popularity": 7.5,
                             "release_date": "2023-01-01",
                             "vote_average": 8.0,
                             "original_name": "Test Original Name",
                             "name": "Test Name",
                             "first_air_date": "2023-01-01"
                         }

            """.data(using: .utf8)!

        // Act
        let result = decoder.decodeResponse(data: jsonData, responseType: Movie.self)

        // Assert
        XCTAssertNoThrow(try result.toBlocking().first())
        if let movie = try? result.toBlocking().first() {
            XCTAssertEqual(movie.title, "Test Movie")
            XCTAssertEqual(movie.id, 1)
            XCTAssertEqual(movie.overview, "This is a test movie")
            XCTAssertEqual(movie.posterPath, "/test.jpg")
            XCTAssertEqual(movie.popularity, 7.5)
            XCTAssertEqual(movie.releaseDate, "2023-01-01")
            XCTAssertEqual(movie.voteAverage, 8.0)
            XCTAssertEqual(movie.originalName, "Test Original Name")
            XCTAssertEqual(movie.name, "Test Name")
            XCTAssertEqual(movie.firstAirDate, "2023-01-01")
        } else {
            XCTFail("Failed to decode movie object")
        }
    }

    func testDecodeResponse_FailureDecoding() {
        // Arrange
        let invalidData = Data() // Invalid data to trigger parsing error

        // Act
        let result = decoder.decodeResponse(data: invalidData, responseType: Movie.self)

        // Assert
        XCTAssertThrowsError(try result.toBlocking().first()) { error in
            XCTAssertEqual(error as? NetworkError, NetworkError.parsingError)
        }
    }
}
