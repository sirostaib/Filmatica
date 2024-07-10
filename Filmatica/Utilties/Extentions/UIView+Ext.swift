//
//  UIView+Ext.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import Foundation
import UIKit

extension UIView {
    func roundX(_ radius: CGFloat = 12) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }

    func addBorderX(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
