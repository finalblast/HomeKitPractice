//
//  AddHomeViewController.swift
//  HomeKitPractice
//
//  Created by Nam (Nick) N. HUYNH on 3/18/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit
import HomeKit

class AddHomeViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var homeManager: HMHomeManager!
    
    // MARK: ViewController life cycle
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
        
    }
    
    func displayAlertWithTitle(title: String, message: String) {
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func addHome(sender: AnyObject) {
        
        if countElements(textField.text) == 0 {
            
            displayAlertWithTitle("Home's name", message: "Please enter the home's name")
            return
            
        }
        
        homeManager.addHomeWithName(textField.text, completionHandler: { (home, error) -> Void in
            
            if error != nil {
                
                self.displayAlertWithTitle("Error happened", message: "\(error)")
                
            } else {
                
                self.navigationController?.popViewControllerAnimated(true)
                
            }
            
        })
        
    }
    
}
