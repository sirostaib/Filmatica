//
//  Coordinator.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit

enum Event{
    case buttonTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func start()
    
    func eventOccured(with type: Event)
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
