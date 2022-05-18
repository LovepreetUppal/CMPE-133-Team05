//
//  LessonsViewCell.swift
//
//  Created by Iurii Dolotov on 20/09/2019.
//  Copyright © 2019 Irina Dolotova. All rights reserved.
//

import UIKit

class LessonsViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet var cellBg: UIView!
    
    var video: Lessons! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        
        thumbnailImageView.image = UIImage(named: video.thumbnailFileName)
        thumbnailImageView.layer.cornerRadius = 8.0
        thumbnailImageView.layer.masksToBounds = true
        
        usernameLabel.text = video.authorName
    }
}
