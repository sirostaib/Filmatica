//
//  MovieDetailViewModelTest.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
import RxSwift
import RxTest
@testable import Filmatica

class MovieDetailViewModelTests: XCTestCase {

    var viewModel: MovieDetailViewModel!
    var movie: Movie!

    override func setUpWithError() throws {
        try super.setUpWithError()
        movie = Movie(id: 1, originalTitle: "Original Title", overview: "Overview",
                      posterPath: "poster.jpg", title: "Titanic", popularity: 7.5, releaseDate: "2023-01-01",
                      voteAverage: 8.0, originalName: nil, name: nil, firstAirDate: nil)
        viewModel = MovieDetailViewModel(movieModel: movie)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        movie = nil
        try super.tearDownWithError()
    }

    func testInitialization() {
        XCTAssertEqual(viewModel.currentMovieRelay.value, movie)
    }

    func testCurrentMovieDriver() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let observer = scheduler.createObserver(Movie.self)

        // Act
        viewModel.currentMovie
            .drive(observer)
            .disposed(by: viewModel.disposeBag)

        // Assert
        XCTAssertEqual(observer.events.count, 1)
        XCTAssertEqual(observer.events.first?.value.element, movie)
    }

    func testUpdateNavTintWithoutCoordinator() {
        // Arrange
        viewModel.coordinator = nil

        // Act
        viewModel.updateNavTint()

        // Assert
        // Verify that nothing crashes or changes without a coordinator set
        XCTAssertNil(viewModel.coordinator)
    }
}
