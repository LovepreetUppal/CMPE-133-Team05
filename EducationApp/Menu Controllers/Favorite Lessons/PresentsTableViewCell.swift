//
//  PresentsTableViewCell.swift
//  YourMotivation
//
//  Created by Yura Dolotov on 11/02/2019.
//  Copyright © 2019 Yura Dolotov. All rights reserved.
//

import Foundation
import UIKit

class PresentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
