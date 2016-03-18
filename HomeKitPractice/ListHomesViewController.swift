//
//  ListHomesViewController.swift
//  HomeKitPractice
//
//  Created by Nam (Nick) N. HUYNH on 3/18/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit
import HomeKit

class ListHomesViewController: UITableViewController {
    
    struct TableViewValues {
    
        static let identifier = "Cell"
        
    }
    
    lazy var homeManager: HMHomeManager = {
        
       let manager = HMHomeManager()
        manager.delegate = self
        return manager
        
    }()
    
    // MARK: ViewController life cycle
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = editButtonItem()
        
    }
    
    // MARK: Tableview datasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfRows = homeManager.homes.count
        if numberOfRows == 0 && editing {
            
            setEditing(!editing, animated: true)
            
        }
        
        editButtonItem().enabled = (numberOfRows > 0)
        return numberOfRows
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewValues.identifier, forIndexPath: indexPath) as UITableViewCell
        
        let home = homeManager.homes[indexPath.row] as HMHome
        cell.textLabel.text = home.name
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let home = homeManager.homes[indexPath.row] as HMHome
            homeManager.removeHome(home, completionHandler: { (error) -> Void in
                
                if error != nil {
                    
                    UIAlertController.showAlertControllerOnHostController(self, title: "Error", message: "\(error)", buttonTitle: "OK")
                    
                } else{
                    
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    
                }
                
            })
            
        }
        
    }
    
    // MARK: Segue preparing
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AddHome" {
            
            let controller = segue.destinationViewController as AddHomeViewController
            controller.homeManager = homeManager
            
        } else if segue.identifier == "ShowRoom" {
            
            let controller = segue.destinationViewController as ListRoomsViewController
            controller.homeManager = homeManager
            let home = homeManager.homes[tableView.indexPathForSelectedRow()!.row] as HMHome
            controller.home = home
            
        }
        
        super.prepareForSegue(segue, sender: sender)
        
    }
    
    // MARK: Setting editting mode
    
    override func setEditing(editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        self.navigationItem.rightBarButtonItem?.enabled = !editing
        
    }
    
}

extension ListHomesViewController: HMHomeManagerDelegate {
    
    func homeManagerDidUpdateHomes(manager: HMHomeManager!) {
        
        tableView.reloadData()
        
    }
    
}

extension UIAlertController {
    
    class func showAlertControllerOnHostController(hostController: UIViewController, title: String, message: String, buttonTitle: String) {
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        controller.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.Default, handler: nil))
        hostController.presentViewController(controller, animated: true, completion: nil)
        
    }
    
}
