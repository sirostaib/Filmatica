//
//  NetworkErrorTests.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
@testable import Filmatica

class NetworkErrorTests: XCTestCase {

    func testLocalizedDescription_invalidURL() {
        let error = NetworkError.invalidURL
        XCTAssertEqual(error.localizedDescription, "The URL provided was invalid.")
    }

    func testLocalizedDescription_noData() {
        let error = NetworkError.noData
        XCTAssertEqual(error.localizedDescription, "No data was received from the server.")
    }

    func testLocalizedDescription_parsingError() {
        let error = NetworkError.parsingError
        XCTAssertEqual(error.localizedDescription, "The data received could not be parsed.")
    }

    func testLocalizedDescription_networkFailure() {
        let underlyingError = NSError(domain: "TestDomain", code: 123, userInfo: nil)
        let error = NetworkError.networkFailure(error: underlyingError)
        XCTAssertEqual(error.localizedDescription, "Network failure occurred: \(underlyingError.localizedDescription)")
    }

    func testLocalizedDescription_unknownError() {
        let error = NetworkError.unknownError
        XCTAssertEqual(error.localizedDescription, "Something went wrong!")
    }

    func testLocalizedDescription_noInternetConnection() {
        let error = NetworkError.noInternetConnection
        XCTAssertEqual(error.localizedDescription, "Check your internet connection!")
    }

    func testLocalizedDescription_requestFailed() {
        let statusCode = 404
        let error = NetworkError.requestFailed(statusCode: statusCode)
        XCTAssertEqual(error.localizedDescription, "Request failure occurred: status \(statusCode)")
    }
}
