//
//  MockRepository.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/14/24.
//

import Foundation
import RxSwift
@testable import Filmatica

class MockMovieRepository: MovieRepositoryProtocol {
    var shouldReturnError = false

    func getTrendingMovies() -> Observable<MoviesModel> {
        if shouldReturnError {
            return Observable.error(NetworkError.noInternetConnection)
        } else {
            let movies = [MockMovie.movie1, MockMovie.movie2]
            let response = MoviesModel(page: 1, results: movies, totalPages: 1, totalResults: 2)
            return Observable.just(response)
        }
    }
}
