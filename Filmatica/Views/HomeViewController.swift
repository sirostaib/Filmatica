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
    var viewModel: HomeViewModel

    private let disposeBag = DisposeBag()
    private let tableView = UITableView()

    // Dependency Injection via initializer
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
        registerCells()
        bindViewModel()
        bindTableViewSelection()
        viewModel.fetchMovies()
    }

    private func bindViewModel() {
        // Bind items to tableView
        viewModel.myMovies
            .drive(
                tableView.rx.items(cellIdentifier: MovieTableViewCell.identifier,
                                   cellType: MovieTableViewCell.self)) { row, model, cell in
                                       print(row)
                                       cell.configure(with: model)
        }
        .disposed(by: disposeBag)
    }

    private func bindTableViewSelection() {
        tableView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { [weak self] movie in
                   self?.viewModel.coordinator?.openMovieDetail(with: movie)

                   // Deselect the row with animation
                   self?.deselectRow()
               })
               .disposed(by: disposeBag)
    }

    private func setupTableViewUI() {
        view.addSubview(tableView)

        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.backgroundColor = .mainColor
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            // intentionally removed bottom safeArea!
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }

    func registerCells() {
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }

    func buttonPressed(movieTitle: String) {
        viewModel.navigateButtonPressed(movieTitle: movieTitle)
    }

    func deselectRow() {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}
