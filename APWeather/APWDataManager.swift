//
//  DataManager.swift
//  APWeather
//
//  Created by Abrar Peer on 8/03/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import Foundation

public class APWDataManager : NSObject {
    
    
    public var filePath : String? {
        
        get {
            
            return NSBundle.mainBundle().pathForResource("data", ofType:"json")
            
        }
        
    }
    
    public var urlString = "http://dnu5embx6omws.cloudfront.net/venues/weather.json"
    
    public var url : NSURL? {
        
        get {
            
           return NSURL(string: self.urlString)
            
        }

    }
    
    public var error : NSError?
    
    public var venues : [Venue]
    
    public var lastRefreshedDate : NSDate?
    
    override init() {
        
        venues = [Venue]()
        
        error = nil
        
        lastRefreshedDate = nil
        
    }
    
    public class var sharedInstance: APWDataManager {
        
        struct Singleton {
            
            static let instance = APWDataManager()
            
        }
        
        return Singleton.instance
        
    }
    
    public func requestData() {
        
        if (self.url != nil) {
            
            loadDataFromURL(self.url!) { (data, error) -> Void in
                
                if (data != nil) {
                    
                    do {
                  
                        _ = try data?.writeToFile(self.filePath!, options: NSDataWritingOptions.DataWritingAtomic)
                        
                    } catch _ {
                        
                        self.error = NSError(domain:"APWDataManger", code:100, userInfo:[NSLocalizedDescriptionKey : "Error Trying to write to file"])
                        
                    }
                    
                } else {
                    
                    self.error = error
                    
                }
                
            }
            
            
            self.lastRefreshedDate = NSDate()

        }
        
        if (self.error != nil) {
            
            getDataFromFileWithSuccess { (data) -> Void in
                
                
                typealias Payload = [String: AnyObject]
                typealias PayloadData = [AnyObject]
                
                var json : Payload!
                
                do {

                    json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? Payload
                    
                    if let dataObjects = json["data"] as? PayloadData {
                        
                        let numberOfDataOjects = dataObjects.count
                        
                        print("\(numberOfDataOjects) Data Objects")
                        
                        self.venues = [Venue]()
                        
                        for object in dataObjects {
                            
                            
                            guard object["_venueID"] != nil else {
                                
                                print("No Venue Id Found")
                                continue
                                
                            }
                            
                            let venueId = object["_venueID"] as! String
                            
                            
                            guard object["_name"] != nil else {
                                
                                print("No Venue Name Found")
                                continue
                                
                            }
                            
                            let venueName = object["_name"] as! String
                            
                            
                            guard let sportObject = object["_sport"] else {
                                
                                print("No Sport Found")
                                continue
                                
                            }
                            
                            let sportId = sportObject?["_sportID"] as! String
                            
                            let sportName = sportObject?["_description"] as! String?
                            
                            guard let sport = Sport(sportId: sportId, sportName: sportName) as Sport? else {
                                
                                print("No Sport Found")
                                continue
                                
                            }
                            
                            print("Sport: \(sport)")
                            
                            
                            guard let countryObject = object["_country"] else {
                                
                                print("No Country Found")
                                continue
                                
                            }
                            
                            
                            let countryId = countryObject?["_countryID"] as! String
                            
                            let countryName = countryObject?["_name"] as! String?
                            
                            guard let country = Country(countryId: countryId, countryName: countryName) as Country? else {
                                
                                print("No Country Found")
                                continue
                                
                            }
                            
                            
                            print("Country: \(country)")
                            
                            
                            let weatherConditions = object["_weatherCondition"] as! String?
                            
                            let weatherWind = object["_weatherWind"] as! String?
                            
                            let weatherHumidity = object["_weatherHumidity"] as! String?
                            
                            var weatherTemp : Int?
                            
                            if let weatherTempRaw = object["_weatherTemp"] as! String? {
                                
                                weatherTemp = Int(weatherTempRaw)
                                
                            }
                            
                            var weatherFeelsLike : Int?
                            
                            if let weatherFeelsLikeRaw = object["_weatherFeelsLike"] as! String? {
                                
                                weatherFeelsLike = Int(weatherFeelsLikeRaw)
                                
                            }
                            
                            var weatherLastUpdatedDate : NSDate
                            
                            if let unixTimeStamp = object["_weatherLastUpdated"] as! Double? {
                                
                                let unixTimeInterval = NSTimeInterval(unixTimeStamp)
                                
                                weatherLastUpdatedDate = NSDate(timeIntervalSince1970: unixTimeInterval)
                                
                            } else {
                                
                                weatherLastUpdatedDate = NSDate(timeIntervalSince1970: NSTimeInterval(0))
                                
                            }
                            
                            
                            guard let weather = Weather(condition: weatherConditions, wind: weatherWind, humidity: weatherHumidity, temp: weatherTemp, feelsLike: weatherFeelsLike, lastUpdatedDate: weatherLastUpdatedDate) as Weather? else {
                                
                                print("No Weather Found")
                                continue
                                
                            }
                            
                            self.venues.append(Venue(venueId: venueId, venueName: venueName, venueCountry: country, venueSport: sport, venueWeather: weather))
                        
                        }
                        
                        
                    }
                    
                    
                } catch let errorType {
                    
                    self.error = NSError(domain: errorType._domain , code:errorType._code, userInfo:[NSLocalizedDescriptionKey : "Error Trying to write to file"])
                    
                }

                
                
            }
            
            
        }

        
    }

    
    private func getDataFromFileWithSuccess(success: ((data: NSData) -> Void)) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            let data = try! NSData(contentsOfFile:self.filePath!, options: NSDataReadingOptions.DataReadingUncached)
            
            success(data: data)
        
        })
        
    }
    
    public func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        
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
