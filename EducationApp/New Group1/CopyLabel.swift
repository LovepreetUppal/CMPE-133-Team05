//
//  CopyLabel.swift
//  EveryDayJoke
//
//  Created by Iurii Dolotov on 23/07/2019.
//  Copyright © 2019 Dev Dev. All rights reserved.
//

import UIKit

class CopyLabel: UILabel {
    
    override var canBecomeFirstResponder: Bool { return true }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
        UIMenuController.shared.setMenuVisible(false, animated: true)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }
}

// MARK: Actions methods
extension CopyLabel {
    
    @objc func longPressGestureActionHandler(_ sender: UILongPressGestureRecognizer) {
        becomeFirstResponder()
        
        let menu = UIMenuController.shared
        
        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
}

// MARK: Helper methods
extension CopyLabel {
    func sharedInit() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureActionHandler(_:))))
    }
}
