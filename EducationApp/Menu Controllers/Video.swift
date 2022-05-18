//
//  Video.swift
//  Live Space
//
//  Created by Yura Dolotov on 23/05/2019.
//  Copyright © 2019 Iuliia Lebedeva. All rights reserved.
//

import Foundation

struct Video
{
    let authorName: String
    let videoFileName: String
    let description: String
    let thumbnailFileName: String
    
    static func fetchVideos() -> [Video] {
        let v1 = Video(authorName: "Computer Science", videoFileName: "ev", description: "Computer Science", thumbnailFileName: "3")
        let v2 = Video(authorName: "Web-development for beginners", videoFileName: "v2", description: "Web-development for beginners", thumbnailFileName: "2")
        let v3 = Video(authorName: "Swift for beginners", videoFileName: "v3", description: "Swift for beginners", thumbnailFileName: "1")
        
        return [v1, v2, v3]
    }
}
