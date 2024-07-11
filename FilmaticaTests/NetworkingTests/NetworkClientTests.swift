//
//  NetworkClientTests.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
import RxSwift
@testable import Filmatica

class NetworkClientTests: XCTestCase {

    var baseURL: URL!
    var apiKey: String!
    var mockSession: MockURLSession!
    var networkClient: NetworkClient!

    override func setUpWithError() throws {
        try super.setUpWithError()
        baseURL = URL(string: "https://api.themoviedb.org/3/")!
        apiKey = NetworkingConstant.shared.apiKey
        mockSession = MockURLSession()
        networkClient = NetworkClient(baseURL: baseURL, apiKey: apiKey, session: mockSession)
    }

    override func tearDownWithError() throws {
        baseURL = nil
        apiKey = nil
        mockSession = nil
        networkClient = nil
        try super.tearDownWithError()
    }

    func testGet_SuccessfulResponse() {
        // Arrange
        let endpoint = "test_endpoint"
        let expectedResponse = MoviesModel(page: 1, results: [], totalPages: 1, totalResults: 0)
        var responseData: Data!
        do {
            responseData = try JSONEncoder().encode(expectedResponse)
        } catch {
            XCTFail("Failed to encode expected response: \(error)")
        }
        mockSession.mockResponse = (HTTPURLResponse(), responseData)

        // Create expectation
        let expectation = self.expectation(description: "Get movies")

        // Act
        var result: MoviesModel?

        _ = networkClient.get(endpoint: endpoint, responseType: MoviesModel.self)
            .subscribe(onNext: { response in
                result = response
                expectation.fulfill()
            })

        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5) { _ in
            // Assert
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.page, expectedResponse.page)
        }
    }

    func testGet_ErrorResponse() {
        // Arrange
        let endpoint = "test_endpoint"
        let expectedError = NetworkError.unknownError // Define your expected error type

        mockSession.mockError = NSError(domain: "MockURLSession", code: 500, userInfo: nil)

        // Create expectation
        let expectation = self.expectation(description: "Get error response")

        // Act
        var errorResult: Error?
        _ = networkClient.get(endpoint: endpoint, responseType: MoviesModel.self)
            .subscribe(onError: { error in
                errorResult = error
                expectation.fulfill()
            })

        // Wait for the expectation to be fulfilled
        waitForExpectations(timeout: 5) { _ in
            // Assert
            XCTAssertNotNil(errorResult)
            XCTAssertTrue(errorResult is NetworkError) // Assert the type of error
            XCTAssertEqual((errorResult as? NetworkError), expectedError) // Assert specific error if needed
        }
    }

    func testPerformance_GetRequest() {
        // Measure performance of a get request
        let endpoint = "test_endpoint"
        let expectedResponse = MoviesModel(page: 1, results: [], totalPages: 1, totalResults: 0)
        var responseData: Data!
        do {
            responseData = try JSONEncoder().encode(expectedResponse)
        } catch {
            XCTFail("Failed to encode expected response: \(error)")
        }
        mockSession.mockResponse = (HTTPURLResponse(), responseData)

        self.measure {
            var result: MoviesModel?
            _ = networkClient.get(endpoint: endpoint, responseType: MoviesModel.self)
                .subscribe(onNext: { response in
                    result = response
                })

            XCTAssertNotNil(result)
        }
    }
    
    func testGetMovies() {
        // Arrange
        let networkClient = NetworkClient(baseURL: baseURL, apiKey: apiKey)
        let endpoint = "trending/all/day"
        
        // Create an expectation for async test
        let expectation = XCTestExpectation(description: "Fetch movies from network")
        
        var moviesResponse: MoviesModel?
        
        // Act
        _ = networkClient.get(endpoint: endpoint, responseType: MoviesModel.self)
            .subscribe(onNext: { response in
                moviesResponse = response
                expectation.fulfill()
            }, onError: { error in
                XCTFail("Error: \(error.localizedDescription)")
                expectation.fulfill()
            })
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 10.0)
        
        // Assert
        XCTAssertNotNil(moviesResponse)
    }
}
