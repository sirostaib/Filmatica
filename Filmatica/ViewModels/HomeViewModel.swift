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
        coordinator?.openMovieDetail(with: Movie(title: movieTitle, releaseDate: "2020",
                                                 overview: "This is the overview"))
    }

    func fetchMovies() {
        let mockMovies = [
            Movie(title: "Inception", releaseDate: "2010", overview: "This is the overview"),
                Movie(title: "Interstellar", releaseDate: "2014", overview: "This is the overview"),
                Movie(title: "The Dark Knight", releaseDate: "2008", overview: "This is the overview"),
                Movie(title: "The Prestige", releaseDate: "2006", overview: "This is the overview"),
                Movie(title: "Dunkirk", releaseDate: "2017", overview: "This is the overview"),
                Movie(title: "Memento", releaseDate: "2000", overview: "This is the overview"),
                Movie(title: "Tenet", releaseDate: "2020", overview: "This is the overview"),
                Movie(title: "The Matrix", releaseDate: "1999", overview: "This is the overview"),
                Movie(title: "Pulp Fiction", releaseDate: "1994", overview: "This is the overview"),
                Movie(title: "The Shawshank Redemption", releaseDate: "1994", overview: "This is the overview"),
                Movie(title: "Fight Club", releaseDate: "1999", overview: "This is the overview"),
                Movie(title: "Forrest Gump", releaseDate: "1994", overview: "This is the overview"),
                Movie(title: "The Lord of the Rings: The Fellowship of the Ring", 
                      releaseDate: "2001", overview: "This is the overview"),
                Movie(title: "The Godfather", releaseDate: "1972", overview: "This is the overview"),
                Movie(title: "Star Wars: Episode IV - A New Hope", 
                      releaseDate: "1977", overview: "This is the overview"),
                Movie(title: "Jurassic Park", releaseDate: "1993", overview: "This is the overview"),
                Movie(title: "The Lion King", releaseDate: "1994", overview: "This is the overview"),
                Movie(title: "Back to the Future", releaseDate: "1985", overview: "This is the overview"),
                Movie(title: "Gladiator", releaseDate: "2000", overview: "This is the overview"),
                Movie(title: "Gladiator, this is a very long movie title name and it would be amazing to test this out! I want to make sure that the length won't be an issue.", releaseDate: "2000", overview: "This is the overview"), // swiftlint:disable:this line_length
                Movie(title: "The Avengers", releaseDate: "2012", overview: "This is the overview")
            // Add more movies as needed
        ]
        moviesRelay.accept(mockMovies)
    }
}
