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
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        viewModel = nil
        disposeBag = nil
        scheduler = nil
        super.tearDown()
    }

    func testInitialization() {
        // Given
        let movie = MockMovie.movie1

        // When
        viewModel = MovieDetailViewModel(movieModel: movie)

        // Then
        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(try viewModel.currentMovieDriver.toBlocking().first())
        XCTAssertEqual(try viewModel.currentMovieDriver.toBlocking().first()?.id, movie.id)
    }

    func testCurrentMovieDriver() {
        // Given
        let movie = MockMovie.movie1
        viewModel = MovieDetailViewModel(movieModel: movie)

        // When
        let movieObserver = scheduler.createObserver(Movie.self)
        viewModel.currentMovieDriver.drive(movieObserver).disposed(by: disposeBag)

        // Then
        scheduler.start()
        let expectedEvents = [
            Recorded.next(0, movie)
        ]
        XCTAssertEqual(movieObserver.events, expectedEvents)
    }

    func testInitializationMovieNotNil() {
        // When
        viewModel = MovieDetailViewModel(movieModel: MockMovie.movie2)

        // Then
        XCTAssertNotNil(try viewModel.currentMovieDriver.toBlocking().first())
    }
}
