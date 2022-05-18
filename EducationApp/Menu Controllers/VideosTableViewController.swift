//
//  VideosTableViewController.swift
//  Live Space
//
//  Created by Yura Dolotov on 23/05/2019.
//  Copyright © 2019 Iuliia Lebedeva. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import GSMessages
import UserNotifications
import Firebase
import BottomDrawer
import GoogleMobileAds

class VideosTableViewController: UITableViewController, UNUserNotificationCenterDelegate, GADBannerViewDelegate, GADInterstitialDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "albums"), tag: 1)
    }
    
    @IBOutlet var tableBg: UITableView!
    @IBOutlet var dateItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upperMessageAlert()
        notifications()
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        interstitial.load(request)
    }
    
    var interstitial: GADInterstitial!
    func createAd() -> GADInterstitial{
        let inter = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        inter.load(GADRequest())
        return inter
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
            interstitial = createAd()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let save = UserDefaults.standard
        if save.value(forKey: "Purchase") == nil {
            print("No in-app purchase")
        } else {
            interstitial = GADInterstitial(adUnitID: "")
        }
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    
    func upperMessageAlert(){
        GSMessage.font = UIFont.boldSystemFont(ofSize: 16)
        GSMessage.successBackgroundColor = UIColor(hexString: "#F4F7FA")
        GSMessage.warningBackgroundColor = UIColor(hexString: "#F4F7FA")
        GSMessage.errorBackgroundColor   = UIColor(hexString: "#F4F7FA")
        GSMessage.infoBackgroundColor    = UIColor(hexString: "#F4F7FA")
        self.showMessage("Welcome to WeGrow!", type: .info, options: [
            .animations([.slide(.normal)]),
            .animationDuration(0.6),
            .autoHide(true),
            .autoHideDelay(3.0),
            .cornerRadius(0.0),
            .height(44.0),
            .hideOnTap(true),
            .margin(.zero),
            .padding(.init(top: 10, left: 30, bottom: 10, right: 30)),
            .position(.top),
            .textAlignment(.center),
            .textColor(.darkText),
            .textNumberOfLines(1),
            ])
    }
    
    func notifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {didAllow, error in})
        
        let content = UNMutableNotificationContent()
        
        //adding title, subtitle, body and badge
        content.title = "Hello! Are you here?"
        content.body = "It is time to learn some cool things!🔥"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false)
        
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    var videos: [Video] = Video.fetchVideos()
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    var arrayOfSegues = ["A", "B", "C"]
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        let video = videos[indexPath.row]
        
        cell.video = video
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: arrayOfSegues[indexPath.row], sender: self)

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
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    @IBAction func helpView(_ sender: Any) {
        let request = self.storyboard?.instantiateViewController(withIdentifier: "HelpPop") as? HelpPopMenu
        let v = BottomController()
        request?.view.backgroundColor = .red
        v.destinationController = request
        v.sourceController = self
        v.startingHeight = 550
        v.cornerRadius = 10
        v.movable = false
        v.modalPresentationStyle = .overCurrentContext
        self.present(v, animated: true, completion: nil)
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
    
    /////////-------RATE BUTTON-------/////////
    @IBOutlet var rateBtn: UIBarButtonItem!
    @IBAction func rateButton(_ sender: Any) {
        rateMe()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    func rateMe(){
        if let url = URL(string: "https://itunes.apple.com/us/app/office-workout/id1467168086?action=write-review"){
            UIApplication.shared.open(url, options: [:], completionHandler: {(result) in
                if result {
                    print ("Success")
                } else {
                    print ("Failed")
                }
            })
        }
    }
    /////////-------RATE BUTTON ENDS-------/////////
}

extension VideosTableViewController {
    
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}

