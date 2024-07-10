//
//  FBodyLabel.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import UIKit

class FBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(textAlignment: NSTextAlignment = .left, fontSize: CGFloat = 14) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }

    private func configure() {
        textColor = .secondaryLabel
        // font = UIFont.preferredFont(forTextStyle: .body )
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.65
        lineBreakMode = .byWordWrapping
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }

}
