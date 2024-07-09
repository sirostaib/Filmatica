//
//  DetailVC.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit

class DetailVC: UIViewController, Coordinating {
    var coordinator: (any Coordinator)?
     
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
        title = "Movie Detail"
        
    }

}
