//
//  MovieDetailVC.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {

    // MARK: - Properties
    var viewModel: MovieDetailViewModel

    private let movieImageView = FImageView(frame: CGRect())
    private var labelStackView = FStackView()
    private let movieTitleLabel = FTitleLabel(fontSize: 22)
    private let movieOverview = FBodyLabel(fontSize: 18)
    private let movieRating = FBodyLabel(fontSize: 20)
    private let movieReleaseDate = FBodyLabel(fontSize: 20)

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let spacerView = UIView()

    // MARK: - Dependency Injection
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil) // Ensure super.init is called
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - main methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUIColors()
        setupScrollView()
        setupContentView()
        setupImageView()
        setupStackViewUI()
        bindMovieData()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateNavTint()
    }

    override func viewWillDisappear(_ animated: Bool) {
        viewModel.resetNavTint()
    }

    // MARK: - Setup UI layout
    private func setupUIColors() {
        view.backgroundColor = .secondColor
        movieTitleLabel.textColor = .white
        movieOverview.textColor = .white
        movieRating.textColor = .mainColor
        movieReleaseDate.textColor = .mainColor
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            // Movie Image Constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])

    }

    private func setupImageView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImageView)

        NSLayoutConstraint.activate([
            // Movie Image Constraints
            movieImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 5),
            movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 400),
            movieImageView.widthAnchor.constraint(equalToConstant: 260)
        ])
    }

    private func setupStackViewUI() {
        labelStackView.addArrangedSubview(movieTitleLabel)
        labelStackView.addArrangedSubview(movieRating)
        labelStackView.addArrangedSubview(movieOverview)
        labelStackView.addArrangedSubview(movieReleaseDate)
        contentView.addSubview(labelStackView)

        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 16),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: 30)
        ])

        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        labelStackView.addArrangedSubview(spacerView)
    }

    // MARK: - binding methods
    private func bindMovieData() {
        viewModel.currentMovie
            .drive(onNext: { [weak self] movie in
                // Update UI with movie details
                self?.title = MovieHelper.shared.getMovieName(movie: movie)
                self?.movieTitleLabel.text = MovieHelper.shared.getMovieName(movie: movie)
                self?.movieOverview.text = movie.overview
                self?.movieImageView.setKFImage(with: movie.posterPath)
                self?.movieRating.text = MovieHelper.shared.getRatingText(vote: movie.voteAverage)
                self?.movieReleaseDate.text = "Released: " + MovieHelper.shared.getMovieReleaseDate(movie: movie)
            })
            .disposed(by: viewModel.disposeBag)
    }
}
