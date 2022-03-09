//
//  UIView+Gradient.swift
//  MVVMMarvel
//
//  Created by Nacho on 07/03/2022.
//

import UIKit

extension UIView {
    func addGradientWithColor(colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors.compactMap { $0.cgColor }

        self.layer.insertSublayer(gradient, at: 0)
    }
}
