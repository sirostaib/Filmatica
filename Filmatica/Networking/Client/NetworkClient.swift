//
//  APIClient.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import Foundation
import RxSwift

// MARK: - Protocol
protocol NetworkClientProtocol {
    func get<T: Decodable>(endpoint: String, responseType: T.Type) -> Observable<T>
}

// MARK: - Main Client
class NetworkClient: NetworkClientProtocol {

    // MARK: - Properties
    private let session: URLSessionProtocol
    private let urlBuilder: URLBuilder
    private let responseDecoder: ResponseDecoder
    private let errorHandler: NetworkErrorHandler

    // MARK: - Init (Dependency Injection)
    init(baseURL: URL?, apiKey: String, session: URLSessionProtocol = URLSession.shared) {
        self.session = session
        if let baseURL = baseURL {
            self.urlBuilder = URLBuilder(baseURL: baseURL, apiKey: apiKey)
        } else {
            // Handle case where baseURL is nil (if needed)
            fatalError("Invalid base URL provided")
        }
        self.responseDecoder = ResponseDecoder()
        self.errorHandler = NetworkErrorHandler()
    }

    // MARK: - Main Methods
    func get<T: Decodable>(endpoint: String, responseType: T.Type) -> Observable<T> {
        guard let finalURL = urlBuilder.buildURL(endpoint: endpoint) else {
            return Observable.error(NetworkError.invalidURL)
        }

        let request = URLRequest(url: finalURL)

        return session.rx_response(request: request)
            .flatMap { _, data -> Observable<T> in
                return self.responseDecoder.decodeResponse(data: data, responseType: T.self)
            }
            .catch { error in
                self.errorHandler.handleNetworkError(error)
            }
            .observe(on: MainScheduler.instance)
    }

}

// MARK: - URLSession Protocol
protocol URLSessionProtocol {
    func rx_response(request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)>
}

extension URLSession: URLSessionProtocol {
    func rx_response(request: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)> {
        return rx.response(request: request)
            .map { response, data -> (response: HTTPURLResponse, data: Data) in
                return (response, data)
            }
    }
}
