//
//  NetworkErrorHandlerTests.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import XCTest
import RxSwift
@testable import Filmatica

class NetworkErrorHandlerTests: XCTestCase {

    var errorHandler: NetworkErrorHandler!

    override func setUp() {
        super.setUp()
        errorHandler = NetworkErrorHandler()
    }

    override func tearDown() {
        errorHandler = nil
        super.tearDown()
    }

    func testHandleNetworkError_urlError_notConnectedToInternet() {
        let urlError = URLError(.notConnectedToInternet)
        let observable: Observable<Void> = errorHandler.handleNetworkError(urlError)
        var receivedError: Error?

        let disposeBag = DisposeBag()
        observable.subscribe(onError: { error in
            receivedError = error
        }).disposed(by: disposeBag)

        XCTAssertEqual((receivedError as? NetworkError), NetworkError.noInternetConnection)
    }

    func testHandleNetworkError_urlError_otherErrors() {
        let urlError = URLError(.cannotFindHost)
        let observable: Observable<Void> = errorHandler.handleNetworkError(urlError)
        var receivedError: Error?

        let disposeBag = DisposeBag()
        observable.subscribe(onError: { error in
            receivedError = error
        }).disposed(by: disposeBag)

        XCTAssertEqual((receivedError as? NetworkError), NetworkError.networkFailure(error: urlError))
    }

    func testHandleNetworkError_networkError() {
        let customError = NetworkError.requestFailed(statusCode: 404)
        let observable: Observable<Void> = errorHandler.handleNetworkError(customError)
        var receivedError: Error?

        let disposeBag = DisposeBag()
        observable.subscribe(onError: { error in
            receivedError = error
        }).disposed(by: disposeBag)

        XCTAssertEqual((receivedError as? NetworkError), customError)
    }

    func testHandleNetworkError_unknownError() {
        let unknownError = NSError(domain: "TestDomain", code: 123, userInfo: nil)
        let observable: Observable<Void> = errorHandler.handleNetworkError(unknownError)
        var receivedError: Error?

        let disposeBag = DisposeBag()
        observable.subscribe(onError: { error in
            receivedError = error
        }).disposed(by: disposeBag)

        XCTAssertEqual((receivedError as? NetworkError), NetworkError.unknownError)
    }
}
