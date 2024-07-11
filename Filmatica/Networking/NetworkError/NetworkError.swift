//
//  NetworkError.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case parsingError
    case unknownError
    case networkFailure(error: Error)
    case requestFailed(statusCode: Int)
    case noInternetConnection

    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noData:
            return "No data was received from the server."
        case .parsingError:
            return "The data received could not be parsed."
        case .networkFailure(let error):
            return "Network failure occurred: \(error.localizedDescription)"
        case .unknownError:
            return "Something went wrong!"
        case .noInternetConnection:
            return "Check your internet connection!"
        case .requestFailed(statusCode: let statusCode):
            return "Request failure occurred: status \(statusCode)"
        }
    }
}
