//
//  HomeViewModel.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {

    // MARK: - Properties
    var coordinator: (any Coordinator)?

    let movieRepository: MovieRepositoryProtocol
    let disposeBag = DisposeBag()

    // MARK: - Reactive Properties
    private let loadingSubject = BehaviorSubject<Bool>(value: false)
    let moviesRelay = BehaviorRelay<[Movie]>(value: [])
    let errorSubject = PublishSubject<NetworkError>()

    // MARK: - Driver/Signal
    var movieList: Driver<[Movie]> {
        return moviesRelay.asDriver(onErrorJustReturn: [])
    }
    var loading: Signal<Bool> {
        return loadingSubject.asSignal(onErrorJustReturn: false)
    }
    let errorDriver: Driver<NetworkError>

    // MARK: - Initiallizer
    init(repo: MovieRepositoryProtocol) {
        self.errorDriver = errorSubject
                   .asDriver(onErrorRecover: { _ in
                       return Driver.just(.unknownError)
                   })

        movieRepository = repo
    }

    // MARK: - Main Methods
    func navigateButtonPressed(movie: Movie) {
        coordinator?.openMovieDetail(with: movie)
    }

    func fetchMovies() {
        movieRepository.getTrendingMovies()
            .do(onSubscribe: { [weak self] in
                self?.loadingSubject.onNext(true)
            }, onDispose: { [weak self] in
                self?.loadingSubject.onNext(false)
            })
            .subscribe(onNext: { [weak self] moviesResult in
                // Handle received moviesModel
                self?.moviesRelay.accept(moviesResult.results)
            }, onError: { [weak self] error in
                // Handle error
                if let networkError = error as? NetworkError {
                    self?.errorSubject.onNext(networkError)
                } else {
                    self?.errorSubject.onNext(.networkFailure(error: error))
                }
                self?.loadingSubject.onNext(false)
            })
            .disposed(by: disposeBag)
    }
}
