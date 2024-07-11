//
//  URLBuilderTests.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
@testable import Filmatica

class URLBuilderTests: XCTestCase {

    func testBuildURL_ValidURL() {
        // Arrange
        let baseURL = URL(string: "https://example.com/api/")!
        let apiKey = "your_api_key"
        let urlBuilder = URLBuilder(baseURL: baseURL, apiKey: apiKey)
        let endpoint = "movies"

        // Act
        let url = urlBuilder.buildURL(endpoint: endpoint)

        // Assert
        XCTAssertNotNil(url, "URL should not be nil")
        XCTAssertEqual(url?.scheme, "https", "URL scheme should be 'https'")
        XCTAssertEqual(url?.host, "example.com", "URL host should be 'example.com'")
        XCTAssertEqual(url?.path, "/api/movies", "URL path should be '/api/movies'")

        // Check query string
        if let queryString = url?.query {
            XCTAssertTrue(queryString.contains("api_key=\(apiKey)"), "Query string should contain api_key")
        } else {
            XCTFail("Query string should not be nil")
        }
    }

    func testBuildURL_EmptyEndpoint() {
        // Arrange
        let baseURL = URL(string: "https://example.com/api/")!
        let apiKey = "your_api_key"
        let urlBuilder = URLBuilder(baseURL: baseURL, apiKey: apiKey)
        let endpoint = ""

        // Act
        let url = urlBuilder.buildURL(endpoint: endpoint)

        // Assert
        XCTAssertNotNil(url, "URL should not be nil even with empty endpoint")
        XCTAssertEqual(url?.absoluteString, "https://example.com/api/?api_key=your_api_key",
                       "URL should only contain base URL and query parameter")
    }

    func testBuildURL_NoAPIKey() {
        // Arrange
        let baseURL = URL(string: "https://example.com/api/")!
        let apiKey = ""
        let urlBuilder = URLBuilder(baseURL: baseURL, apiKey: apiKey)
        let endpoint = "movies"

        // Act
        let url = urlBuilder.buildURL(endpoint: endpoint)

        // Assert
        XCTAssertNotNil(url, "URL should not be nil even with empty API key")
        XCTAssertEqual(url?.absoluteString, "https://example.com/api/movies?api_key=",
                       "URL should contain endpoint and empty query parameter")
    }
}
