//
//  SettingsViewController.swift
//  Tic Tac Toe
//
//  Created by Iurii Dolotov on 16/08/2019.
//  Copyright © 2019 Irina Dolotova. All rights reserved.
//

import UIKit
import StoreKit

class SettingsViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        
        buyButton.isEnabled = false
        SKPaymentQueue.default().add(self)
        getPurchaseInfo()
    }
    
    @IBOutlet var removeAdsLabel: UILabel!
    @IBOutlet var restoreLabel: UILabel!
    @IBOutlet var appNameLabel: UILabel!
    @IBOutlet var firstSeparator: UIView!
    @IBOutlet var secondSeparator: UIView!
    @IBOutlet var buyView: UIView!
    @IBOutlet var restoreView: UIView!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet var restoreButton: UIButton!
    @IBOutlet var alertView: UIView!
    @IBOutlet var alertLabel: UILabel!
    
    var product: SKProduct?
    var productID = "com.irinadolotova.tictactoe.full"
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        if (products.count == 0){
            showAlert(withTitle:"Whooops:(", withMessage: "Unable to find the in-app purchase to buy!")
        } else {
            product = products[0]
            //showAlert(withTitle: product!.localizedTitle, withMessage: product!.localizedDescription)
            buyButton.isEnabled = true
        }
        
        let invalids = response.invalidProductIdentifiers
        for product in invalids {
            print("Product not found: \(product)")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            
            switch transaction.transactionState{
                
            case SKPaymentTransactionState.purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                showAlert(withTitle:"Thank you for purchase", withMessage: "Enjoy the game and be happy:)")
                buyButton.isEnabled = false
                
                let save = UserDefaults.standard
                save.set(true, forKey: "Purchase")
                save.synchronize()
                
            case SKPaymentTransactionState.restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                showAlert(withTitle:"Suuuper!", withMessage: "Enjoy the game and be happy:)")
                buyButton.isEnabled = false
                
                let save = UserDefaults.standard
                save.set(true, forKey: "Purchase")
                save.synchronize()
                
            case SKPaymentTransactionState.failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                showAlert(withTitle:"Whooops:(", withMessage: "The purchase can not be completed")
                
            default:
                break
            }
        }
    }
    
    func getPurchaseInfo(){
        if SKPaymentQueue.canMakePayments() {
            let request = SKProductsRequest(productIdentifiers: NSSet(objects: self.productID) as! Set <String>)
            request.delegate = self
            request.start()
        } else {
            showAlert(withTitle:"Whoops:(", withMessage: "Please enable in-app purchases in the device settings")
        }
    }
    
    @IBAction func blockAds(_ sender: Any) {
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    ////////////===========EVERYTHING ABOUT IN-APP PURCHASE////////////===========
    
    @IBAction func restorePurchase(_ sender: Any) {
        SKPaymentQueue.default().restoreCompletedTransactions()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let text = "Heeeey!!! Check this Tic Tac Toe game📲"
        let image = UIImage(named: "tic")
        let shareAll = [text, image!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBOutlet var rateBtn: UIButton!
    @IBAction func rateButton(_ sender: Any) {
        rateMe()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func rateMe(){
        if let url = URL(string: "https://itunes.apple.com/us/app/live-space-iss-tracker/id1465174128?action=write-review"){
            UIApplication.shared.open(url, options: [:], completionHandler: {(result) in
                if result {
                    print ("Success")
                } else {
                    print ("Failed")
                }
            })
        }
    }
}

extension SettingsViewController {
    
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ОК", style: .default, handler: { action in })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
