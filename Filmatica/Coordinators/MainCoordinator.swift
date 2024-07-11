//
//  MainCoordinator.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit
import RxSwift
import RxCocoa

class MainCoordinator: Coordinator {

    var navigationController: UINavigationController?

    // MARK: - Methods
    func start() {

        let viewController = setupInitialViewController()
        navBarUISetup()
        navigationController?.setViewControllers([viewController], animated: false)
    }

    func openMovieDetail(with movie: Movie) {
        let viewModel = MovieDetailViewModel(movieModel: movie)
        viewModel.coordinator = self
        let viewController = MovieDetailViewController(viewModel: viewModel)

        navigationController?.pushViewController(viewController, animated: true)
    }

    func setupInitialViewController() -> HomeViewController {
        guard let baseURL = URL(string: NetworkingConstant.shared.baseURL) else {
            fatalError("Invalid base URL")
        }

        let networkClient = NetworkClient(baseURL: baseURL, apiKey: NetworkingConstant.shared.apiKey)
        let movieRepository = MovieRepository(networkClient: networkClient )
        let viewModel = HomeViewModel(repo: movieRepository)
        viewModel.coordinator = self
        return HomeViewController(viewModel: viewModel)
    }

    // MARK: - Global Navigation Bar UI
    func navBarUISetup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .mainColor
        navigationController?.navigationBar.barTintColor = .secondColor
        navigationController?.navigationBar
            .largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar
            .titleTextAttributes = [.foregroundColor: UIColor.white]
    }

}
