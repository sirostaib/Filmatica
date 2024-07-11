//
//  MovieRepository.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import Foundation
import RxSwift

// MARK: - Protocol
protocol MovieRepositoryProtocol {
    func getTrendingMovies() -> Observable<MoviesModel>
}

// MARK: - Main Repo
class MovieRepository: MovieRepositoryProtocol {
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func getTrendingMovies() -> Observable<MoviesModel> {
        // Simulate a delay of 1 seconds before making the actual network call
                return Observable.just(())
                    .delay(.seconds(1), scheduler: MainScheduler.instance)
                    .flatMap { [unowned self] _ in
                        return networkClient.get(endpoint:
                                                NetworkingConstant.Endpoints.getTrendingMovies,
                                             responseType: MoviesModel.self)
                    }
    }
}
