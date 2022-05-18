//
//  HelpPopMenu.swift
//  Guess Logo
//
//  Created by Iurii Dolotov on 11/09/2019.
//  Copyright © 2019 Iurii Dolotov. All rights reserved.
//

import UIKit
import BottomDrawer

class HelpPopMenu: BottomController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor(hexString: "#FFFFFF")
    }
}
