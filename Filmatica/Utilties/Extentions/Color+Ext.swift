//
//  Color+Ext.swift
//  Filmatica
//
//  Created by Siros Taib on 7/9/24.
//

import UIKit

extension UIColor {
    static var accentColor: UIColor {
        return UIColor(named: "AccentColor") ?? UIColor.systemBlue
    }
    static var mainColor: UIColor {
        return UIColor(named: "mainColor") ?? UIColor.systemBlue
    }
    static var secondColor: UIColor {
        return UIColor(named: "secondColor") ?? UIColor.systemBlue
    }
}
