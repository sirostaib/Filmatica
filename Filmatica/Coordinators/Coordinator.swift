//
//  Coordinator.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit

// enum Event{
//    case openDetailVC
// }

protocol Coordinator {
    var navigationController: UINavigationController? { get set }

    func start()

    // func eventOccured(with type: Event)
    func openMovieDetail(with movie: Movie)
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
