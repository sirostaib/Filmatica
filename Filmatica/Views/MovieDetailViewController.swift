//
//  MovieDetailVC.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit

class MovieDetailViewController: UIViewController, Coordinating {

    var coordinator: (any Coordinator)?
    var movie: Movie?

    var label: UILabel = {
       let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        label.textColor = .secondColor

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
        title = "Movie Detail"
        view.addSubview(label)
        label.center = view.center
        label.text = movie?.title

    }

    func test() {

    }

}
