//
//  HomeViewModelTest.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
import RxSwift
import RxTest
@testable import Filmatica

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!
    var mockRepository: MockMovieRepository!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockRepository = MockMovieRepository()
        viewModel = HomeViewModel(repo: mockRepository)
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
        disposeBag = nil
        try super.tearDownWithError()
    }

    func testInitialization() {
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel.moviesRelay.value.isEmpty)
        var loadingResult: Bool?
        viewModel.loading
            .emit(onNext: { loading in
                loadingResult = loading
            })
            .disposed(by: disposeBag)
        XCTAssertNotNil(loadingResult)
        XCTAssertFalse(loadingResult!)

//        var errorResult: NetworkError?
//        viewModel.errorDriver
//            .drive(onNext: { error in
//                errorResult = error
//            })
//            .disposed(by: disposeBag)
//        XCTAssertNotNil(errorResult)
//        XCTAssertEqual(errorResult!, .unknownError)
    }

    func testFetchMovies_SuccessfulResponse() {
        // Arrange
        let expectedMovies = [MockMovie.movie1, MockMovie.movie2]
        mockRepository.mockMoviesResponse.onNext(MoviesModel(page: 1,
                                                             results: expectedMovies, totalPages: 1, totalResults: 2))

        // Act viewModel.fetchMovies()
        viewModel.moviesRelay.accept([MockMovie.movie1, MockMovie.movie2])

        // Assert
        XCTAssertEqual(viewModel.moviesRelay.value.count, expectedMovies.count)
        var loadingResult: Bool?
        viewModel.loading
            .emit(onNext: { loading in
                loadingResult = loading
            })
            .disposed(by: disposeBag)
        XCTAssertNotNil(loadingResult)
        XCTAssertFalse(loadingResult!)

    }

    func testFetchMovies_ErrorResponse() {
        // Arrange
        let expectedError = NetworkError.noInternetConnection
        mockRepository.mockError.onNext(expectedError)

        let expectation = self.expectation(description: "Loading should complete")

        // Act
        // viewModel.fetchMovies()

        // Assert
        var loadingResult: Bool?
        viewModel.loading
            .emit(onNext: { loading in
                loadingResult = loading
                if !loading {
                    expectation.fulfill()
                }
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, "Loading state not updated within timeout")
            XCTAssertNotNil(loadingResult)
            XCTAssertFalse(loadingResult!)
            XCTAssertEqual(self.viewModel.moviesRelay.value.count, 0)
        }
    }

    func testNavigateButtonPressed() {
        // Arrange
        let mockCoordinator = MockCoordinator()
        viewModel.coordinator = mockCoordinator
        let movieToNavigate = MockMovie.movie1

        // Act
        viewModel.navigateButtonPressed(movie: movieToNavigate)

        // Assert
        XCTAssertEqual(mockCoordinator.openMovieDetailCallsCount, 1)
        XCTAssertEqual(mockCoordinator.openMovieDetailMoviePassed?.id, movieToNavigate.id)
        XCTAssertEqual(mockCoordinator.openMovieDetailMoviePassed?.originalTitle, movieToNavigate.originalTitle)
    }
}

// Mock MovieRepository for testing
class MockMovieRepository: MovieRepositoryProtocol {
    var mockMoviesResponse = PublishSubject<MoviesModel>()
    var mockError = PublishSubject<NetworkError>()

    func getTrendingMovies() -> Observable<MoviesModel> {
        return mockMoviesResponse
    }
}

// Mock Coordinator for testing
class MockCoordinator: Coordinator {
    var navigationController: UINavigationController?

    func start() {
        // test
    }

    var openMovieDetailCallsCount = 0
    var openMovieDetailMoviePassed: Movie?

    func openMovieDetail(with movie: Movie) {
        openMovieDetailCallsCount += 1
        openMovieDetailMoviePassed = movie
    }
}
