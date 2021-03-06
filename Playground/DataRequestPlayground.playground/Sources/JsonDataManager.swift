//
//  DataManager.swift
//  APWeather
//
//  Created by Abrar Peer on 8/03/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import Foundation

public class JsonDataManager {
    
    public class func getDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            let filePath = NSBundle.mainBundle().pathForResource("data", ofType:"json")
            
            let data = try! NSData(contentsOfFile:filePath!, options: NSDataReadingOptions.DataReadingUncached)
            
            success(data: data)
        
        })
        
    }
    
    public class func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        let loadDataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let responseError = error {
                
                completion(data: nil, error: responseError)
                
            } else {
                
                if let httpResponse = response as? NSHTTPURLResponse {
                    
                    if httpResponse.statusCode != 200 {
                        
                        let statusError = NSError(domain:"net.cloudfront", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                        
                        completion(data: nil, error: statusError)
                        
                    } else {
                        
                        completion(data: data, error: nil)
                        
                    }
                }
                
            }
        }
        
        loadDataTask.resume()
        
    }
    
}
