//
//  MainCoordinator.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func start() {
        let vc = ViewController()
        vc.coordinator = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    func eventOccured(with type: Event) {
        switch type{
        case .buttonTapped:
            let vc = DetailVC()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
