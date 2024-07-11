//
//  NetworkErrorHandler.swift
//  Filmatica
//
//  Created by Siros Taib on 7/11/24.
//

import Foundation
import RxSwift

class NetworkErrorHandler {
    func handleNetworkError<T>(_ error: Error) -> Observable<T> {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return Observable.error(NetworkError.noInternetConnection)
            default:
                return Observable.error(NetworkError.networkFailure(error: urlError))
            }
        } else if let networkError = error as? NetworkError {
            return Observable.error(networkError)
        } else {
            return Observable.error(NetworkError.unknownError)
        }
    }
}
