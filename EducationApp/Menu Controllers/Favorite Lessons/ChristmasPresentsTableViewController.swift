//
//  ChristmasPresentsTableViewController.swift
//  YourMotivation
//
//  Created by Yura Dolotov on 11/02/2019.
//  Copyright © 2019 Yura Dolotov. All rights reserved.
//

import Foundation
import UIKit
import CoreData

var presents = [Present]()

class ChristmasPresentsTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tabBarItem = UITabBarItem(title: "Cheat Sheet", image: UIImage(named: "note"), tag: 3)
    }
    
    var managedObjextContext:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        managedObjextContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        loadData()
    }
    
    func loadData(){
        let presentRequest:NSFetchRequest<Present> = Present.fetchRequest()
        
        do {
            presents = try managedObjextContext.fetch(presentRequest)
            self.tableView.reloadData()
        }catch {
            print("Could not load data from database \(error.localizedDescription)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presents.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PresentsTableViewCell
        
        let presentItem = presents[indexPath.row]
        
        if let presentImage = UIImage(data: presentItem.image! as Data) {
            cell.backgroundImageView.image = presentImage
        }
        
        cell.nameLabel.text = presentItem.person
        cell.itemLabel.text = presentItem.presentName
        
        
        return cell
    }
    
    @IBAction func addPresent(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            picker.dismiss(animated: true, completion: {
                self.createPresentItem(with: image)
            })
        }
    }
    
    func createPresentItem (with image:UIImage) {
        
        let presentItem = Present(context: managedObjextContext)
        presentItem.image = NSData(data: image.jpegData(compressionQuality: 0.3)!) as Data
        
        
        let inputAlert = UIAlertController(title: "New theory", message: "Add new lesson to cheat sheet", preferredStyle: .alert)
        inputAlert.addTextField { (textfield:UITextField) in
            textfield.placeholder = "Theory"
        }
        inputAlert.addTextField { (textfield:UITextField) in
            textfield.placeholder = "Category"
        }
        
        inputAlert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action:UIAlertAction) in
            
            let personTextField = inputAlert.textFields?.first
            let presentTextField = inputAlert.textFields?.last
            
            if personTextField?.text != "" && presentTextField?.text != "" {
                presentItem.person = personTextField?.text
                presentItem.presentName = presentTextField?.text
                
                do {
                    try self.managedObjextContext.save()
                    self.loadData()
                }catch {
                    print("Could not save data \(error.localizedDescription)")
                }
                
            }
        }))
        
        inputAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(inputAlert, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            let item = presents[indexPath.row]
            presents.remove(at: indexPath.row)
            managedObjextContext.delete(item)

            do {
                try managedObjextContext.save()
            } catch {
                print ("Error")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {

        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
    }
    
}

    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }

    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
