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
    var coordinator: (any Coordinator)?
    let moviesRelay = BehaviorRelay<[Movie]>(value: [])
    var myMovies: Driver<[Movie]> {
        return moviesRelay.asDriver()
    }

    func navigateButtonPressed(movieTitle: String) {
        coordinator?.openMovieDetail(with: Movie(title: movieTitle, releaseDate: "2020"))
    }

    func fetchMovies() {
        let mockMovies = [
            Movie(title: "Inception", releaseDate: "2010"),
                Movie(title: "Interstellar", releaseDate: "2014"),
                Movie(title: "The Dark Knight", releaseDate: "2008"),
                Movie(title: "The Prestige", releaseDate: "2006"),
                Movie(title: "Dunkirk", releaseDate: "2017"),
                Movie(title: "Memento", releaseDate: "2000"),
                Movie(title: "Tenet", releaseDate: "2020"),
                Movie(title: "The Matrix", releaseDate: "1999"),
                Movie(title: "Pulp Fiction", releaseDate: "1994"),
                Movie(title: "The Shawshank Redemption", releaseDate: "1994"),
                Movie(title: "Fight Club", releaseDate: "1999"),
                Movie(title: "Forrest Gump", releaseDate: "1994"),
                Movie(title: "The Lord of the Rings: The Fellowship of the Ring", releaseDate: "2001"),
                Movie(title: "The Godfather", releaseDate: "1972"),
                Movie(title: "Star Wars: Episode IV - A New Hope", releaseDate: "1977"),
                Movie(title: "Jurassic Park", releaseDate: "1993"),
                Movie(title: "The Lion King", releaseDate: "1994"),
                Movie(title: "Back to the Future", releaseDate: "1985"),
                Movie(title: "Gladiator", releaseDate: "2000"),
                Movie(title: "The Avengers", releaseDate: "2012")
            // Add more movies as needed
        ]
        moviesRelay.accept(mockMovies)
    }
}
