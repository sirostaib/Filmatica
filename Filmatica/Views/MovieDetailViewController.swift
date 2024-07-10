//
//  MovieDetailVC.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController, Coordinating {

    var coordinator: (any Coordinator)?
    var movie: Movie?

    private let movieImageView = FImageView(frame: CGRect())
    private var labelStackView = FStackView()
    private let movieTitleLabel = FTitleLabel(fontSize: 22)
    private let movieOverview = FBodyLabel(fontSize: 18)

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondColor
        title = movie?.title
        movieOverview.text = "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32." // // swiftlint:disable:this line_length
        movieOverview.textColor = .white
        movieTitleLabel.textColor = .white
        movieTitleLabel.text = movie?.title

        setupScrollView()

        setupContentView()

        setupImageView()

        setupStackViewUI()

        setTestImage()
    }

    override func viewWillAppear(_ animated: Bool) {
        updateNavTint()
    }

    override func viewWillDisappear(_ animated: Bool) {
        resetNavTint()
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
        labelStackView = FStackView(arrangedSubviews: [movieTitleLabel, movieOverview])
        contentView.addSubview(labelStackView)

        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            labelStackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 16),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16)
        ])
    }

    func setTestImage() {
        movieImageView.kf.indicatorType = .activity
        let url = URL(string: "https://www.carscoops.com/wp-content/uploads/2017/11/1c0f3a2c-vw-golf-r-performance-pack-upgrade-2.jpg") // swiftlint:disable:this line_length

        KF.url(url)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .onFailure({ [weak self] error in
                print(error.localizedDescription)
                self?.movieImageView.image = UIImage(named: "Filmatica-icon")
            })
            .fade(duration: 0.2)
            .set(to: movieImageView)

    }

    func updateNavTint() {
        coordinator?.navigationController?.navigationBar.tintColor = .white
        coordinator?.navigationController?.navigationBar.barTintColor = .mainColor
    }

    func resetNavTint() {
        coordinator?.navigationController?.navigationBar.tintColor = .mainColor
        coordinator?.navigationController?.navigationBar.barTintColor = .secondColor
    }

}
