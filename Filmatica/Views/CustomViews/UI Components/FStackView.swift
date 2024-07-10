//
//  FStackView.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import UIKit

class FStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.axis = .vertical
        self.alignment = .leading
        self.spacing = 8
        self.translatesAutoresizingMaskIntoConstraints = false
        print("my job is done")
    }
}
