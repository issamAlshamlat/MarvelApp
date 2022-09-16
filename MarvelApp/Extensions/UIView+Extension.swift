//
//  UIView+Extension.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 16/09/2022.
//

import Foundation
import UIKit

extension UIView {

    static var identifier: String {
        return String(describing: self)
    }

    func addShadow(withRadius cornerRadius: CGFloat) {

        self.layer.masksToBounds = false
        self.layer.frame = self.frame
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3.0
    }
}
