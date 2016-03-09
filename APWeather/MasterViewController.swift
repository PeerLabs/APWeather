//
//  MasterViewController.swift
//  APWeather
//
//  Created by Abrar Peer on 8/03/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var venueObjects = [Venue]()
    
    override func viewDidLoad() {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        //let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
//        if let split = self.splitViewController {
//            let controllers = split.viewControllers
//            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//        }
                
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
        
        #endif


        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif
        
        
        super.viewWillAppear(animated)
        
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
            
        #endif

        
    }
    
    

    
}


