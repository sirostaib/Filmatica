//
//  MovieDetailViewModelProtocol.swift
//  Filmatica
//
//  Created by Siros Taib on 7/14/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol MovieDetailViewModelProtocol {
    var currentMovieDriver: Driver<Movie> { get }
    func updateNavTint(initialState: Bool)
}
