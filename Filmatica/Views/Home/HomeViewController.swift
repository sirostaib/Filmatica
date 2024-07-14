//
//  HomeVC.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit
import RxSwift

// this can be also called MovieListVC
class HomeViewController: UIViewController {

    // MARK: - Properties
    var viewModel: HomeViewModelProtocol
    private let disposeBag = DisposeBag()

    private let tableView = FTableView(frame: CGRect(), style: .plain)
    private let loadingView = FLoadingIndicator(frame: CGRect())

    // MARK: - Dependency Injection
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil) // Ensure super.init is called
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainColor
        title = "Filmatica"

        setupTableViewUI()
        setupLoadingIndicatorUI()
        registerCells()
        bindLoading()
        bindTableViewData()
        bindTableViewSelection()
        bindErrors()
        viewModel.fetchMovies()
    }

    // MARK: - UI layout Setup
    func setupLoadingIndicatorUI() {
        view.addSubview(loadingView)

        let constraints = [
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.widthAnchor.constraint(equalToConstant: 50),
            loadingView.heightAnchor.constraint(equalToConstant: 50)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    private func setupTableViewUI() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Binding methods
    private func bindLoading() {
        viewModel.loading
            .distinctUntilChanged()
            .emit(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.loadingView.startAnimating()
                } else {
                    self?.loadingView.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
    }

    private func bindTableViewData() {
        viewModel.movieListDriver
            .distinctUntilChanged()
            .drive(tableView.rx.items(cellIdentifier: MovieTableViewCell.identifier,
                                      cellType: MovieTableViewCell.self)) { _, model, cell in
                cell.configure(with: model)
            }.disposed(by: disposeBag)
    }

    private func bindErrors() {
        viewModel.errorDriver
            .drive(onNext: { [weak self] error in
                self?.presentKFAlertOnMainThread(title: "Oops!",
                                                 message: error.localizedDescription, buttonTitle: "Okay")
            })
            .disposed(by: disposeBag)
    }

    private func bindTableViewSelection() {
        tableView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { [weak self] movie in
                self?.navigateToDetailScreen(with: movie)
                
                // Deselect the row with animation
                self?.deselectRow()
            })
            .disposed(by: disposeBag)
    }

    // MARK: - tableView methods
    func registerCells() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }

    func navigateToDetailScreen(with movieModel: Movie) {
        viewModel.navigateButtonPressed(movie: movieModel)
    }

    func deselectRow() {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}
