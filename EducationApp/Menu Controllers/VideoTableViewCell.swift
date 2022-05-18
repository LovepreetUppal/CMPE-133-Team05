//
//  VideoTableViewCell.swift
//  Live Space
//
//  Created by Yura Dolotov on 23/05/2019.
//  Copyright © 2019 Iuliia Lebedeva. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet var cellBg: UIView!
    
    var video: Video! {
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
