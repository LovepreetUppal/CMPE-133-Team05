//
//  ComputerScienceViewController.swift
//
//  Created by Iurii Dolotov on 19/09/2019.
//  Copyright © 2019 Irina Dolotova. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleMobileAds

class ComputerScienceViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate {
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    var wordData = String()
    var translation = String()
    var ref: DatabaseReference!
    var databaseHandler: DatabaseHandle!
    
    var savedWord = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.isHidden = true
        bannerView.delegate = self

        ref = Database.database().reference()
        databaseHandler = ref.child("ENGLISH-ComputerScienceMain").observe(.childAdded) { (snapshot) in
            
            let word = snapshot.value as? String
            
            if let actualWord = word {
                self.wordData = actualWord
                print(self.wordData)
                
                self.wordLabel.text = self.wordData
                self.savedWord = self.wordData
            }
        }
        
        databaseHandler = ref.child("ENGLISH-ComputerScienceCategory").observe(.childAdded) { (snapshot) in
            
            let wordTranslation = snapshot.value as? String
            
            if let actualWord = wordTranslation {
                self.wordData = actualWord
                print(self.wordData)
                
                self.title = self.wordData
                self.translation = self.wordData
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let save = UserDefaults.standard
        if save.value(forKey: "Purchase") == nil {
            bannerView.adUnitID = "ca-app-pub-7175817548312954/1685235155"
            bannerView.adSize = kGADAdSizeSmartBannerPortrait
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        } else {
            bannerView.isHidden = true
        }
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = true
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let text = self.wordLabel.text!
        let image = UIImage(named: "wallpaper01")
        let shareAll = [text, image!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func copyJoke(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        showAlert(withTitle:"Super!", withMessage: "The material has been copied and you can add it to the Cheat Sheet👍🏻")
        UIPasteboard.general.string = wordLabel.text
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        self.viewDidLoad()
        self.viewWillAppear(true)
    }

}

extension ComputerScienceViewController {
    
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}

