//
//  Coordinator.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }

    func start()

    func openMovieDetail(with movie: Movie)
}
