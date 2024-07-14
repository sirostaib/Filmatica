//
//  URLSessionProtocol.swift
//  Filmatica
//
//  Created by Siros Taib on 7/14/24.
//

import Foundation
import RxSwift

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
