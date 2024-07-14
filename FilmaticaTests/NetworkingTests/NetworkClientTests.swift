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
        baseURL = URL(string: "https://test.com")!
        apiKey = "my-api-key"
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
        let expectedResponse = MoviesModel(page: 1, results: [MockMovie.movie1, MockMovie.movie2],
                                           totalPages: 1, totalResults: 0)
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
            XCTAssertEqual(result?.results.count, 2)
            XCTAssertEqual(result?.results.first?.title, MockMovie.movie1.title)
            XCTAssertEqual(result?.results.last?.id, MockMovie.movie2.id)
        }
    }

    func testGet_ErrorResponse() {
        // Arrange
        let endpoint = "test_endpoint"
        let expectedError = NetworkError.unknownError

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
            XCTAssertTrue(errorResult is NetworkError)
            XCTAssertEqual((errorResult as? NetworkError), expectedError)
        }
    }

     func testGet_SuccessfulResponseWithData() {
         // Arrange
         let endpoint = "test_endpoint"
         let expectedResponse = MoviesModel(page: 1, results:
                                                [MockMovie.movie1, MockMovie.movie2], totalPages: 1, totalResults: 0)
         var responseData: Data!
         do {
             responseData = try JSONEncoder().encode(expectedResponse)
         } catch {
             XCTFail("Failed to encode expected response: \(error)")
         }
         mockSession.mockResponse = (HTTPURLResponse(url: baseURL,
                                                     statusCode: 200, httpVersion: nil,
                                                     headerFields: nil)!, responseData)

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

     func testGet_InvalidURL() {
         // Arrange
         let endpoint = "invalid_endpoint"
         mockSession.mockResponse = nil // No response for this case

         // Create expectation
         let expectation = self.expectation(description: "Get invalid URL response")

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
             XCTAssertTrue(errorResult is NetworkError)
         }
     }

     func testGet_Non200HTTPResponse() {
         // Arrange
         let endpoint = "test_endpoint"
         mockSession.mockResponse = (HTTPURLResponse(url: URL(string: "https://baseURL.com")!,
                                                     statusCode: 404,
                                                     httpVersion: nil,
                                                     headerFields: nil)!,
                                     Data())

         // Create expectation
         let expectation = self.expectation(description: "Get non-200 HTTP response")

         // Act
         var errorResult: Error?
         _ = networkClient.get(endpoint: endpoint, responseType: MoviesModel.self)
             .subscribe(onError: { error in
                 errorResult = error
                 expectation.fulfill()
             })

         // Wait for the expectation to be fulfilled
         waitForExpectations(timeout: 15) { _ in
             // Assert
             XCTAssertNotNil(errorResult)
             XCTAssertTrue(errorResult is NetworkError)
         }
     }

     func testGet_DecodingFailure() {
         // Arrange
         let endpoint = "test_endpoint"
         let json = "invalid_json"
            let invalidData = json.data(using: .utf8)! // Invalid JSON
         mockSession.mockResponse = (
             HTTPURLResponse(url: baseURL, statusCode: 200, httpVersion: nil, headerFields: nil)!,
             invalidData
         )

         // Create expectation
         let expectation = self.expectation(description: "Get decoding failure response")

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
             XCTAssertTrue(errorResult is NetworkError,
                           "Expected a NetworkError, but got \(String(describing: errorResult))")
             XCTAssertEqual(errorResult as? NetworkError,
                            NetworkError.parsingError, "Expected decodingError for invalid JSON")
         }
     }
 }
