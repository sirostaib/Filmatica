//
//  NetworkError+Testing.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import Foundation
@testable import Filmatica

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
             (.noData, .noData),
             (.parsingError, .parsingError),
             (.unknownError, .unknownError),
             (.noInternetConnection, .noInternetConnection):
            return true
        case let (.networkFailure(lhsError), .networkFailure(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case let (.requestFailed(lhsStatusCode), .requestFailed(rhsStatusCode)):
            return lhsStatusCode == rhsStatusCode
        default:
            return false
        }
    }
}
