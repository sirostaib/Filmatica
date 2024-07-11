//
//  UIImageView+Ext.swift
//  Filmatica
//
//  Created by Siros Taib on 7/10/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setKFImage(with imageUrl: String) {
        self.kf.indicatorType = .activity
        let url = URL(string: NetworkingConstant.shared.imageServerURL + imageUrl)

        KF.url(url)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .onFailure({ _ in
                self.image = UIImage(named: "Filmatica-icon")
            })
            .fade(duration: 0.2)
            .set(to: self)
    }
}
