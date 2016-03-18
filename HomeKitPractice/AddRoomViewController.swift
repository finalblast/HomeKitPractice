//
//  AddRoomViewController.swift
//  HomeKitPractice
//
//  Created by Nam (Nick) N. HUYNH on 3/18/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit
import HomeKit

class AddRoomViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var home: HMHome!
    
    @IBAction func addRoom(sender: AnyObject) {
        
        if countElements(textField.text) == 0 {
            
            UIAlertController.showAlertControllerOnHostController(self, title: "Room's name", message: "Please enter the room's name", buttonTitle: "OK")
            return
            
        }
        
        home.addRoomWithName(textField.text, completionHandler: { (room, error) -> Void in
            
            if error != nil {
                
                UIAlertController.showAlertControllerOnHostController(self, title: "Error", message: "\(error)", buttonTitle: "OK")
                
            } else {
                
                self.navigationController?.popViewControllerAnimated(true)
                
            }
            
        })
        
    }
    
}
