//
//  MainCoordinator.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController?

    func start() {
        let viewModel = HomeViewModel()
        viewModel.coordinator = self
        let viewController = HomeViewController(viewModel: viewModel)

        navBarUISetup()
        navigationController?.setViewControllers([viewController], animated: false)
    }

    func openMovieDetail(with movie: Movie) {
        let viewController = MovieDetailViewController()
        viewController.movie = movie
        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }

    func navBarUISetup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .secondColor
        navigationController?.navigationBar.barTintColor = .secondColor
        navigationController?.navigationBar
            .largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar
            .titleTextAttributes = [.foregroundColor: UIColor.white]
    }

}
