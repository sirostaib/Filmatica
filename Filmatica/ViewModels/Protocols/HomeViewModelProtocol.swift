//
//  HomeViewModelProtocol.swift
//  Filmatica
//
//  Created by Siros Taib on 7/14/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelProtocol {
    var movieListDriver: Driver<[Movie]> { get }
    var loading: Signal<Bool> { get }
    var errorDriver: Driver<NetworkError> { get }
    func navigateButtonPressed(movie: Movie)
    func fetchMovies()
}
