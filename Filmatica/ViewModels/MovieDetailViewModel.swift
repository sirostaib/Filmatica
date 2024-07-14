//
//  MovieDetailViewModel.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel: MovieDetailViewModelProtocol {

    // MARK: - Initiallizer
    init(movieModel: Movie) {
        currentMovieRelay.accept(movieModel)
    }

    // MARK: - Coordinator
    var coordinator: Coordinator?

    // MARK: - Properties
    private let myDisposeBag = DisposeBag()
    private let currentMovieRelay = BehaviorRelay<Movie?>(value: nil)

    // MARK: - Public Interfaces
    var currentMovieDriver: Driver<Movie> {
        return currentMovieRelay.asDriver()
            .compactMap { $0 } // Filter out nil values
    }

    // MARK: - Other Methods
    func updateNavTint(initialState: Bool = true) {
        if initialState {
            coordinator?.navigationController?.navigationBar.tintColor = .mainColor
            coordinator?.navigationController?.navigationBar.barTintColor = .secondColor
        } else {
            coordinator?.navigationController?.navigationBar.tintColor = .white
            coordinator?.navigationController?.navigationBar.barTintColor = .mainColor
        }

    }
}
