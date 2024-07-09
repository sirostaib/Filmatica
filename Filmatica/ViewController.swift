//
//  ViewController.swift
//  Filmatica
//
//  Created by Siros Taib on 7/8/24.
//

import UIKit

class ViewController: UIViewController, Coordinating {
    var coordinator: (any Coordinator)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = "Filmatica"
        
        
        addButton()
    }
    
    func addButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 70))
        button.center = view.center
        button.backgroundColor = .systemGreen
        button.setTitle("Navigate", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func buttonPressed(){
        coordinator?.eventOccured(with: .buttonTapped)
    }

}

