//
//  GradientColor.swift
//  NeverEver
//
//  Created by Yura Dolotov on 27/01/2019.
//  Copyright © 2019 Yura Dolotov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    //view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
    
    /**
     Adds a vertical gradient layer with two **UIColors** to the **UIView**.
     - Parameter topColor: The top **UIColor**.
     - Parameter bottomColor: The bottom **UIColor**.
     */
    
    func addVerticalGradientLayer(topColor:UIColor, bottomColor:UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            topColor.cgColor,
            bottomColor.cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
