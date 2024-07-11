//
//  NetworkConstantTests.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
@testable import Filmatica

class NetworkingConstantTests: XCTestCase {

    func testBaseURL() {
        XCTAssertEqual(NetworkingConstant.shared.baseURL,
                       "https://api.themoviedb.org/3/", "Expected base URL does not match")
    }

    func testImageServerURL() {
        XCTAssertEqual(NetworkingConstant.shared.imageServerURL,
                       "https://image.tmdb.org/t/p/w500", "Expected image server URL does not match")
    }

    func testEndpoints() {
        XCTAssertEqual(NetworkingConstant.Endpoints.getTrendingMovies,
                       "trending/all/day", "Expected endpoint value does not match")
    }

    func testHeaders() {
        XCTAssertEqual(NetworkingConstant.Headers.contentType,
                       "Content-Type", "Expected content type header key does not match")
        XCTAssertEqual(NetworkingConstant.Headers.contentTypeValue,
                       "application/json", "Expected content type header value does not match")
    }

}
