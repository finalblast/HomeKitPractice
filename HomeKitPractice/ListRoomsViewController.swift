//
//  ListRoomsViewController.swift
//  HomeKitPractice
//
//  Created by Nam (Nick) N. HUYNH on 3/18/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit
import HomeKit

class ListRoomsViewController: UITableViewController {
    
    var homeManager: HMHomeManager!
    var home: HMHome! {
        
        didSet {
            
            home.delegate = self
            
        }
        
    }
    
    struct TableViewValues {
    
        static let identifier = "Cell"
        
    }
    
    // MARK: TableView datasource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return home.rooms.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewValues.identifier, forIndexPath: indexPath) as UITableViewCell
        let room = home.rooms[indexPath.row] as HMRoom
        cell.textLabel.text = room.name
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let room = home.rooms[indexPath.row] as HMRoom
            home.removeRoom(room, completionHandler: { (error) -> Void in
                
                if error != nil {
                    
                    UIAlertController .showAlertControllerOnHostController(self, title: "Error", message: "\(error)", buttonTitle: "OK")
                    
                } else {
                    
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
                    
                }
                
            })
            
        }
        
    }
    
    // MARK: Segue preparing
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AddRoom" {
            
            let controller = segue.destinationViewController as AddRoomViewController
            controller.home = home
            
        }
        
        super.prepareForSegue(segue, sender: sender)
        
    }
    
}

extension ListRoomsViewController: HMHomeDelegate {
    
    func home(home: HMHome!, didAddRoom room: HMRoom!) {
        
        println("Added room")
        
    }
    
    func home(home: HMHome!, didRemoveRoom room: HMRoom!) {
        
        println("Removed room")
        
    }
    
}
