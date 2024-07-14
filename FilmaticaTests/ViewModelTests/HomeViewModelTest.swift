//
//  HomeViewModelTest.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import Filmatica

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockRepository: MockMovieRepository!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        mockRepository = MockMovieRepository()
        viewModel = HomeViewModel(repo: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        disposeBag = nil
        scheduler = nil
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel.movieListDriver)
        XCTAssertNotNil(viewModel.loading)
        XCTAssertNotNil(viewModel.errorDriver)
    }

    func testFetchMoviesSuccessfully() {
        // Given
        mockRepository.shouldReturnError = false
        let expectedMovies = [MockMovie.movie1, MockMovie.movie2]

        // When
        var movieResult: [Movie]?
        // let loadingExpectation = expectation(description: "Loading state changes")

        viewModel.fetchMovies()

        // Drive results
        viewModel.movieListDriver
            .drive(onNext: { movies in
                movieResult = movies
            })
            .disposed(by: disposeBag)

        // Then
        XCTAssertNotNil(movieResult)
        XCTAssertEqual(movieResult?.count, 2)
        XCTAssertEqual(movieResult, expectedMovies)
    }

    // Test Fetching Movies with Error
    func testFetchMoviesWithError() {

        // Given
        mockRepository.shouldReturnError = true
        let expectedMovies: [Movie] = []

        // When
        var movieResult: [Movie]?
        // let loadingExpectation = expectation(description: "Loading state changes")

        viewModel.fetchMovies()

        // Drive results
        viewModel.movieListDriver
            .drive(onNext: { movies in
                movieResult = movies
            })
            .disposed(by: disposeBag)

        // Then
        XCTAssertNotNil(movieResult)
        XCTAssertEqual(movieResult?.count, 0)
        XCTAssertEqual(movieResult, expectedMovies)
    }

    func testLoadingState() {
        // Given
        mockRepository.shouldReturnError = false
        let loadingExpectation = expectation(description: "Loading state changes")

        var loadingStates: [Bool] = []

        viewModel.loading
            .skip(1)
            .distinctUntilChanged()
            .emit(onNext: { isLoading in
                loadingStates.append(isLoading)
                // Fulfill the expectation only when loading becomes false
                if !isLoading && loadingStates.count == 2 {
                    loadingExpectation.fulfill()
                }
            })
            .disposed(by: disposeBag)

        // When
        viewModel.fetchMovies()

        // Wait for expectations
        waitForExpectations(timeout: 1) { _ in
            // Then
            XCTAssertEqual(loadingStates, [true, false])
        }
    }

    func testLoadingStateInError() {
        // Given
        mockRepository.shouldReturnError = true
        let loadingExpectation = expectation(description: "Loading state changes")

        var loadingStates: [Bool] = []

        viewModel.loading
            .skip(1)
            .emit(onNext: { isLoading in
                loadingStates.append(isLoading)
                // Fulfill the expectation only when loading becomes false
                if !isLoading && loadingStates.count == 2 {
                    loadingExpectation.fulfill()
                }
            })
            .disposed(by: disposeBag)

        // When
        viewModel.fetchMovies()

        // Wait for expectations
        waitForExpectations(timeout: 1) { _ in
            // Then
            XCTAssertEqual(loadingStates, [true, false])
        }
    }

    // Test Fetching Movies with Error
    func testFetchMoviesWithErrorDriver() {
        // Given
        mockRepository.shouldReturnError = true

        var errorResult: NetworkError?
        let expectedResult: NetworkError = NetworkError.noInternetConnection

        viewModel.errorDriver.drive(onNext: { error in
            errorResult = error
        }).disposed(by: disposeBag)

        // fetch movies
        viewModel.fetchMovies()

        XCTAssertNotNil(errorResult)
        XCTAssertEqual(errorResult, expectedResult)

    }
}
