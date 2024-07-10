//
//  MovieTableViewCell.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    static let identifier = "MovieTableViewCell"

    private let movieImage = FImageView(frame: CGRect())
    private let titleLabel = FTitleLabel(fontSize: 22)
    private let secondaryLabel = FBodyLabel(fontSize: 16)
    private var labelStackView = FStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieImage)
        setupStackUI()
        contentView.addSubview(labelStackView)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(secondaryLabel)

        setupConstraints()
        setupCellUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStackUI() {
        labelStackView = FStackView(arrangedSubviews: [titleLabel, secondaryLabel])
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Movie Image Constraints
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            movieImage.heightAnchor.constraint(equalToConstant: 150),
            movieImage.widthAnchor.constraint(equalToConstant: 100),

            // Stack View Constraints
            labelStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 8),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func setupCellUI() {
        backgroundColor = .clear

    }

    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        secondaryLabel.text = movie.releaseDate
        setTestImage()
    }

    func setTestImage() {
        movieImage.kf.indicatorType = .activity
        let url = URL(string: "https://www.carscoops.com/wp-content/uploads/2017/11/1c0f3a2c-vw-golf-r-performance-pack-upgrade-2.jpg") // swiftlint:disable:this line_length

        KF.url(url)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .onFailure({ [weak self] error in
                print(error.localizedDescription)
                self?.movieImage.image = UIImage(named: "Filmatica-icon")
            })
            .fade(duration: 0.2)
            .set(to: movieImage)

    }

}
