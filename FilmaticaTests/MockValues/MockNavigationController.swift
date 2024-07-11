//
//  MockNavigationController.swift
//  FilmaticaTests
//
//  Created by Siros Taib on 7/11/24.
//

import UIKit

class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        pushedViewController = viewController
    }
}
