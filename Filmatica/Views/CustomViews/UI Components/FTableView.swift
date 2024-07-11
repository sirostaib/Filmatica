//
//  FTableView.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import UIKit

class FTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        separatorStyle = .singleLine
        separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }

}
