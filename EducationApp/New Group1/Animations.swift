//
//  Animations.swift
//  Bored
//
//  Created by Azhar Anwar on 11/09/18.
//  Copyright © 2018 Azhar Anwar. All rights reserved.
//

import Foundation
import UIKit

enum Animations{
    
    //Animate a filter view
    static func animatePopUp(filterView: UIView, view: UIView, visualEffectView: UIVisualEffectView){
        view.addSubview(filterView)
        filterView.center = view.center
        
        var effect: UIVisualEffect!
        effect = visualEffectView.effect
        
        filterView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        filterView.alpha = 0
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            visualEffectView.effect = effect
            visualEffectView.isHidden = false
            filterView.alpha = 1
            filterView.transform = CGAffineTransform.identity
        }, completion: { (success) in
            
        })
    }
    
    //Animate out the filter view
    static func animateOut(filterView: UIView, visualEffectView: UIVisualEffectView){
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            filterView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            filterView.alpha = 0
            
            visualEffectView.effect = nil
            visualEffectView.isHidden = true
        }) { (success) in
            filterView.removeFromSuperview()
        }
    }
    
}
