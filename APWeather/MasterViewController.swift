//
//  MasterViewController.swift
//  APWeather
//
//  Created by Abrar Peer on 8/03/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDataSource/*, UITableViewDelegate */ {
    
    @IBOutlet weak var animator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var detailViewController: DetailViewController? = nil

    var dataRequester : DataRequester? = nil
    
    override func viewDidLoad() {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dataRequester = DataRequester.sharedInstance
        
        self.registerNotificationObservers()
        
        //tableView.delegate = self
        tableView.dataSource = self
        
                
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
        
        #endif
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif
        
        
        super.viewWillAppear(animated)
        
//        dataManager?.requestData()
        
        dataRequester?.requestData()
        
        startDownloadAnimator()
        
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
            
        #endif

        
    }
    
    func registerNotificationObservers() {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"recievedNotification:", name:nil, object: dataRequester)
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
            
        #endif
        
    }
    
    //MARK: Unregister Notification Observers
    
    func unregisterNotificationObservers() {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif

        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: nil, object: dataRequester)
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
            
        #endif

    }
    
    //MARK: Recieve Observed Notifications
    
    func recievedNotification(notification: NSNotification) {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif

        
        let name = notification.name
        
        switch (name) {
            
        case "APWRequestCompletedSuccessfully": successfullyCompletedRequest()
            
        default: break
            
        }
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
            
        #endif

        
    }
    
    func successfullyCompletedRequest() {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif
        
        animator.stopAnimating()
        
        animator.hidden = true
        
        tableView.hidden = false
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.tableView.reloadData()
            
        })

        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
            
        #endif
        
    }

    
    func startDownloadAnimator() {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif
        
        self.tableView.hidden = true
        
        self.animator?.startAnimating()
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
            
        #endif
        
    }

    // MARK: UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
            
        #endif
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
            
        #endif
        
        return (self.dataRequester?.numberOfVenues())!
         
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Started!")
            
        #endif
        
        let cell = tableView.dequeueReusableCellWithIdentifier("venueCell")!
       
        let venueNameLabel = cell.viewWithTag(1) as? UILabel
        let venueLastUpdatedLabel = cell.viewWithTag(2) as? UILabel
        let venueTempLabel = cell.viewWithTag(3) as? UILabel
        
        guard let venueItem = dataRequester?.venueAtIndex(indexPath.row) else {
            
            venueNameLabel!.text = "Unknown Venue"
            venueLastUpdatedLabel!.text = "Unknown"
            venueTempLabel!.text = "Unknown"
            
            return cell

        }
        
        
        print("\(venueItem)")
        
        venueNameLabel!.text = venueItem.fullName
        
        guard let venueWeather = venueItem.weather else {
            
            venueLastUpdatedLabel!.text = "Unknown"
            venueTempLabel!.text = "Unknown"
            
            return cell
            
        }
        
        venueLastUpdatedLabel!.text = venueWeather.lastUpdatedDateString
        venueTempLabel!.text = venueWeather.temperature

        #if DEBUG
            
            print("[\(__FILE__) : \(__FUNCTION__)] Finished!")
            
        #endif
        
        return cell
        

    }
    
}


