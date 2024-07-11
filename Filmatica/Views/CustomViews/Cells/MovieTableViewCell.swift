//
//  MovieTableViewCell.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = "MovieTableViewCell"

    private let posterImageView = FImageView(frame: CGRect())
    private let titleLabel = FTitleLabel(fontSize: 22)
    private let secondaryLabel = FBodyLabel(fontSize: 16)
    private var labelStackView = FStackView()

    // MARK: - Dependency Injection Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupPosterViewUI()
        setupStackViewUI()
        setupCellUI()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI layout
    private func setupPosterViewUI() {
        contentView.addSubview(posterImageView)

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            posterImageView.widthAnchor.constraint(equalToConstant: 100)
        ])

        let heightConstraint = posterImageView.heightAnchor.constraint(equalToConstant: 150)
        heightConstraint.priority = UILayoutPriority(999)
        heightConstraint.isActive = true
    }

    private func setupStackViewUI() {
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(secondaryLabel)
        contentView.addSubview(labelStackView)

        NSLayoutConstraint.activate([
            labelStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func setupCellUI() {
        backgroundColor = .clear
    }

    // MARK: - Configure methods
    func configure(with movie: Movie) {
        titleLabel.text = MovieHelper.shared.getMovieName(movie: movie)
        secondaryLabel.text = MovieHelper.shared.getMovieReleaseDate(movie: movie)
        posterImageView.setKFImage(with: movie.posterPath)
    }
}
