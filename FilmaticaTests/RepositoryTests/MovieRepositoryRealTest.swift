//
//  MovieRepositoryTest.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
import RxSwift
@testable import Filmatica

class MovieRepositoryRealTests: XCTestCase {

    var disposeBag: DisposeBag!
    var movieRepository: MovieRepository!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        // Use your actual base URL and API key here
        let baseURL = URL(string: "https://api.themoviedb.org/3/")!
        let apiKey = NetworkingConstant.shared.apiKey
        let networkClient = NetworkClient(baseURL: baseURL, apiKey: apiKey)
        movieRepository = MovieRepository(networkClient: networkClient)
    }

    override func tearDown() {
        disposeBag = nil
        movieRepository = nil
        super.tearDown()
    }

    func testGetTrendingMovies_SuccessfulResponse() {
        // Given
        let expectation = self.expectation(description: "Get trending movies")
        var result: MoviesModel?
        var error: Error?

        // When
        movieRepository.getTrendingMovies()
            .subscribe(onNext: { movies in
                result = movies
                expectation.fulfill()
            }, onError: { err in
                error = err
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        // Then
        waitForExpectations(timeout: 10) { _ in
            // Assert
            XCTAssertNil(error, "Unexpected error: \(String(describing: error))")
            XCTAssertNotNil(result, "Expected a non-nil result")
            // Additional assertions based on your expected result structure
        }
    }
}
