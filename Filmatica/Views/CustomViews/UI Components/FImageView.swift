//
//  FImageView.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import UIKit

class FImageView: UIImageView {

    let placeholderImage = UIImage(named: "Filmatica-icon")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.roundX()
        clipsToBounds = true
        image = placeholderImage
        self.contentMode = .scaleAspectFill
        self.tintColor = .label
        translatesAutoresizingMaskIntoConstraints = false
    }
}
