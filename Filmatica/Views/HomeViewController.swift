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

        setupTableView()
        bindViewModel()
        viewModel.fetchMovies()
    }

    private func setupTableView() {

        tableView.separatorStyle = .none
        tableView.backgroundColor = .mainColor

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    private func bindViewModel() {
        viewModel.myMovies
            .drive(tableView.rx.items(cellIdentifier: "Cell")) { (row, movie, cell) in
                cell.textLabel?.text = "\(row+1). " + movie.title
                cell.backgroundColor = .clear
            }
            .disposed(by: disposeBag)
    }

    func buttonPressed(movieTitle: String) {
        viewModel.navigateButtonPressed(movieTitle: movieTitle)
    }
}

// extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 25
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        
//        cell.backgroundColor = .clear
//        
//        
//        let bgColorView = UIView()
//        bgColorView.backgroundColor = .secondColor
//        cell.selectedBackgroundView = bgColorView
//        
//        
//        cell.textLabel?.text = "\(indexPath.row + 1) - Slaw"
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let movieTitle = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "Does not have title"
//        buttonPressed(movieTitle: movieTitle)
//        tableView.cellForRow(at: indexPath)?.isSelected = false
//    }
//    
//    
// }
