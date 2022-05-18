//
//  Lessons.swift
//
//  Created by Iurii Dolotov on 20/09/2019.
//  Copyright © 2019 Irina Dolotova. All rights reserved.
//

import Foundation

struct Lessons
{
    let authorName: String
    let videoFileName: String
    let description: String
    let thumbnailFileName: String
    
    static func fetchVideos() -> [Lessons] {
        let v1 = Lessons(authorName: "Preparing an iOS app for release", videoFileName: "ev", description: "", thumbnailFileName: "lesson1")
        let v2 = Lessons(authorName: "Connect Firebase to iOS app", videoFileName: "v2", description: "", thumbnailFileName: "lesson2")
        let v3 = Lessons(authorName: "Implement database structure", videoFileName: "v3", description: "", thumbnailFileName: "lesson3")
        
        return [v1, v2, v3]
    }
}
