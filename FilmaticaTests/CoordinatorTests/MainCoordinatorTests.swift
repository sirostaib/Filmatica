//
//  MainCoordinatorTests.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
import RxBlocking
@testable import Filmatica

class MainCoordinatorTests: XCTestCase {

    var coordinator: MainCoordinator!
    var mockNavigationController: MockNavigationController!

    override func setUp() {
        super.setUp()
        mockNavigationController = MockNavigationController()
        coordinator = MainCoordinator()
        coordinator.navigationController = mockNavigationController
    }

    override func tearDown() {
        coordinator = nil
        mockNavigationController = nil
        super.tearDown()
    }

    func testStartSetsInitialViewController() {
        coordinator.start()

        guard let rootViewController = mockNavigationController.viewControllers.first
                as? HomeViewController else {
            let errorString = String(describing: mockNavigationController.viewControllers.first)
            XCTFail("Expected HomeViewController, but got \(errorString)")
            return
        }

        XCTAssertNotNil(rootViewController.viewModel)
    }

    func testOpenMovieDetailPushesMovieDetailViewController() {
        let movie = MockMovie.movie1
        coordinator.openMovieDetail(with: movie)

        guard let pushedViewController = mockNavigationController.pushedViewController
                as? MovieDetailViewController else {
            let errorString = String(describing: mockNavigationController.pushedViewController)
            XCTFail("Expected MovieDetailViewController, but got \(errorString)")
            return
        }

        do {
            let currentMovie = try pushedViewController.viewModel.currentMovie.toBlocking().first()
            XCTAssertEqual(currentMovie, movie)
        } catch {
            XCTFail("Failed to get currentMovie from Driver")
        }
    }
}
