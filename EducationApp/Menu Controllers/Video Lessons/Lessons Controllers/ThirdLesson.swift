//
//  NasaTvViewController.swift
//  Live Space
//
//  Created by Yura Dolotov on 23/05/2019.
//  Copyright © 2019 Iuliia Lebedeva. All rights reserved.
//

import UIKit
import YoutubeKit

class ThirdLesson: UIViewController {
    
    private var player: YTSwiftyPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addSlideMenuButton()
        // Create a new player
        player = YTSwiftyPlayer(
            frame: CGRect(x: 0, y: 0, width: 640, height: 480),
            playerVars: [.playsInline(true), .videoID("uu2vVCOa9Xo"), .loopVideo(true), .showRelatedVideo(false)])
        
        // Enable auto playback when video is loaded
        player.autoplay = true
        
        // Set player view
        view = player
        
        // Set delegate for detect callback information from the player
        player.delegate = self
        
        // Load video player
        player.loadPlayer()
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let text = "Welcome to WeGrow!"
        let shareAll = [text] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}

extension ThirdLesson: YTSwiftyPlayerDelegate {
    
    func playerReady(_ player: YTSwiftyPlayer) {
        print(#function)
        // After loading a video, player's API is available.
        // e.g. player.mute()
    }
    
    func player(_ player: YTSwiftyPlayer, didUpdateCurrentTime currentTime: Double) {
        print("\(#function):\(currentTime)")
    }
    
    func player(_ player: YTSwiftyPlayer, didChangeState state: YTSwiftyPlayerState) {
        print("\(#function):\(state)")
    }
    
    func player(_ player: YTSwiftyPlayer, didChangePlaybackRate playbackRate: Double) {
        print("\(#function):\(playbackRate)")
    }
    
    func player(_ player: YTSwiftyPlayer, didReceiveError error: YTSwiftyPlayerError) {
        print("\(#function):\(error)")
    }
    
    func player(_ player: YTSwiftyPlayer, didChangeQuality quality: YTSwiftyVideoQuality) {
        print("\(#function):\(quality)")
    }
    
    func apiDidChange(_ player: YTSwiftyPlayer) {
        print(#function)
    }
    
    func youtubeIframeAPIReady(_ player: YTSwiftyPlayer) {
        print(#function)
    }
    
    func youtubeIframeAPIFailedToLoad(_ player: YTSwiftyPlayer) {
        print(#function)
 }
}
