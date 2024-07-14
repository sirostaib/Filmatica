//
//  HomeViewModel.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: HomeViewModelProtocol {

    // MARK: - Initializer
    init(repo: MovieRepositoryProtocol) {
        movieRepository = repo
    }

    // MARK: - Coordinator
    var coordinator: Coordinator?

    // MARK: - Encapsulated Properties
    private let movieRepository: MovieRepositoryProtocol
    private let disposeBag = DisposeBag()
    private let loadingSubject = BehaviorSubject<Bool>(value: true)
    private let moviesRelay = BehaviorRelay<[Movie]>(value: [])
    private let errorSubject = PublishSubject<NetworkError>()

    // MARK: - Public Interfaces
    var movieListDriver: Driver<[Movie]> {
        return moviesRelay.asDriver(onErrorJustReturn: [])
    }
    var loading: Signal<Bool> {
        return loadingSubject.asSignal(onErrorJustReturn: false)
    }
    var errorDriver: Driver<NetworkError> {
        return errorSubject.asDriver(onErrorRecover: { _ in
            return Driver.just(.unknownError)
        })
    }

    // MARK: - Main Methods - Public interfaces
    func navigateButtonPressed(movie: Movie) {
        coordinator?.openMovieDetail(with: movie)
    }

    func fetchMovies() {
        movieRepository.getTrendingMovies()
            .do(onSubscribe: { [weak self] in
                self?.loadingSubject.onNext(true)
            })
            .subscribe(onNext: { [weak self] moviesResult in
                // Handle received movies
                self?.moviesRelay.accept(moviesResult.results)
            }, onError: { [weak self] error in
                // Handle error
                if let networkError = error as? NetworkError {
                    self?.errorSubject.onNext(networkError)
                } else {
                    self?.errorSubject.onNext(.networkFailure(error: error))
                }
            }, onCompleted: {
                self.loadingSubject.onNext(false)
            }, onDisposed: {
                self.loadingSubject.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
