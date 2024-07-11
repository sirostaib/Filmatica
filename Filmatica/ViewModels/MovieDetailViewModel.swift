//
//  MovieDetailViewModel.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import Foundation
import RxSwift
import RxCocoa

class MovieDetailViewModel {

    // MARK: - Properties
    var coordinator: (any Coordinator)?
    let disposeBag = DisposeBag()

    // MARK: - Reactive Properties
    let currentMovieRelay = BehaviorRelay<Movie?>(value: nil)
    var currentMovie: Driver<Movie> {
        return currentMovieRelay.asDriver()
            .compactMap { $0 } // Filter out nil values
    }

    // MARK: - Initiallizer
    init(movieModel: Movie) {
        currentMovieRelay.accept(movieModel)
    }

    // MARK: - Other Methods
    func updateNavTint() {
        coordinator?.navigationController?.navigationBar.tintColor = .white
        coordinator?.navigationController?.navigationBar.barTintColor = .mainColor
    }

    func resetNavTint() {
        coordinator?.navigationController?.navigationBar.tintColor = .mainColor
        coordinator?.navigationController?.navigationBar.barTintColor = .secondColor
    }
}
