//
//  NetworkConstant.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import Foundation

class NetworkingConstant {

    public static var shared: NetworkingConstant = NetworkingConstant()

    public var apiKey: String {
        return "4a06669b886242b8f805e61ea75a43e6"
    }

    public var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }

    public var imageServerURL: String {
        return "https://image.tmdb.org/t/p/w500"
    }

    struct Endpoints {
        static let getTrendingMovies = "trending/all/day"
    }

    struct Headers {
        static let contentType = "Content-Type"
        static let contentTypeValue = "application/json"
    }
}
