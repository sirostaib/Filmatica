//
//  MockURLSession.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import Foundation
import RxSwift
@testable import Filmatica

class MockURLSession: URLSessionProtocol {
    var mockResponse: (HTTPURLResponse, Data)?
    var mockError: Error?

    func rx_response(request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)> {
        guard let mockResponse = mockResponse else {
            return Observable.error(mockError ?? NSError(domain: "MockURLSession", code: 0, userInfo: nil))
        }

        return Observable.just(mockResponse)
    }
}
