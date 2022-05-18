//
//  LessonsViewController.swift
//
//  Created by Iurii Dolotov on 20/09/2019.
//  Copyright © 2019 Irina Dolotova. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import GSMessages
import Firebase

class LessonsViewController: UITableViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Video Lessons", image: UIImage(named: "Movie"), tag: 2)
    }
    
    @IBOutlet var tableBg: UITableView!
    @IBOutlet var dateItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "promo.jpg")!)
        //tableView.backgroundView = UIImageView(image: UIImage(named: "BgImage.png"))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    var videos: [Lessons] = Lessons.fetchVideos()
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    var arrayOfSegues = ["A", "B", "C"]
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonsCell", for: indexPath) as! LessonsViewCell
        let video = videos[indexPath.row]
        
        cell.video = video
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: arrayOfSegues[indexPath.row], sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 315
    }
    
    func playVideo(at indexPath: IndexPath)
    {
        let selectedVideo = videos[indexPath.row]
        let videoPath = Bundle.main.path(forResource: selectedVideo.videoFileName, ofType: "mp4")
        let videoPathURL = URL(fileURLWithPath: videoPath!)
        player = AVPlayer(url: videoPathURL)
        playerViewController.player = player
        
        self.present(playerViewController, animated: true, completion: {
            self.playerViewController.player?.play()
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
//        cell.layer.transform = rotationTransform
//        cell.alpha = 0
//        UIView.animate(withDuration: 0.75) {
//            cell.layer.transform = CATransform3DIdentity
//            cell.alpha = 1.0
//        }
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        //        let text = "Heeeey!!! Check this Workout Application📲 \n\nhttps://itunes.apple.com/us/app/live-space-iss-tracker/id1465174128?l=ru&ls=1&mt=8"
        let text = "Welcome to WeGrow!"
        let image = UIImage(named: "promo")
        let shareAll = [text, image!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

extension LessonsViewController {
    
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ОК", style: .default, handler: { action in })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
