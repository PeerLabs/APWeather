//
//  DataRequester.swift
//  APWeather
//
//  Created by Abrar Peer on 11/03/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import Foundation

public class DataRequester : NSObject {
    
    public var requestUrlString = "https://dnu5embx6omws.cloudfront.net/venues/weather.json"
    
    public var requestURL : NSURL? {
        
        get {
            
            return NSURL(string: self.requestUrlString)
            
        }
        
    }

    public var lastRequestedDate : NSDate?
    
    private var venues : [Venue]
    
    
    // MARK - Initialiser
    
    override init() {
        
        
        lastRequestedDate = nil
        venues = [Venue]()
        
        super.init()
        
    }
    
    func requestData() {
        
        let urlRequest = NSMutableURLRequest(URL: requestURL!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                
                print("Everyone is fine, file downloaded successfully.")
                
                typealias Payload = [String: AnyObject]
                typealias PayloadData = [AnyObject]
                
                var json : Payload!
                
                do {
                    
                    json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? Payload
                    
                    if let dataObjects = json["data"] as? PayloadData {
                        
                        let numberOfDataOjects = dataObjects.count
                        
                        print("\(numberOfDataOjects) Data Objects")
                        
                        self.venues.removeAll()
                        
                        for object in dataObjects {
                            
                            
                            print("Processing Object: \(object)")
                            
                            
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
                            
                            
                            guard countryObject?["_countryID"] != nil else {
                                
                                print("No Country ID Found")
                                continue
                                
                            }

                            
                            guard countryObject?["_name"] != nil else {
                                
                                print("No Country Name Found")
                                continue
                                
                            }
                            
                            let countryId = countryObject?["_countryID"] as! String
                            
                            let countryName = countryObject?["_name"] as! String
                            
                            guard let country = Country(countryId: countryId, countryName: countryName) as Country? else {
                                
                                print("Country could Not Be Created")
                                continue
                                
                            }
                            
                            
                            print("Country: \(country)")
                            
                            
                            let weatherConditions = object["_weatherCondition"] as! String?
                            
                            let weatherWind = object["_weatherWind"] as! String?
                            
                            let weatherHumidity = object["_weatherHumidity"] as! String?
                            
                            var weatherTemp : Int? = nil
                            
                            guard let weatherTempRaw = object["_weatherTemp"] as! String? else {
                                
                                weatherTemp = 0
                                continue
                                
                            }
                            
                            weatherTemp = Int(weatherTempRaw)
                            
                            var weatherFeelsLike : Int? = nil
                            
                            guard let weatherFeelsLikeRaw = object["_weatherFeelsLike"] as! String? else {
                                
                                weatherFeelsLike = 0
                                continue
                                
                            }
                            
                            weatherFeelsLike = Int(weatherFeelsLikeRaw)
                            
                            var weatherLastUpdatedDate : NSDate
                            
                            if let unixTimeStamp = object["_weatherLastUpdated"] as! Double? {
                                
                                let unixTimeInterval = NSTimeInterval(unixTimeStamp)
                                
                                weatherLastUpdatedDate = NSDate(timeIntervalSince1970: unixTimeInterval)
                                
                            } else {
                                
                                weatherLastUpdatedDate = NSDate(timeIntervalSince1970: NSTimeInterval(0))
                                
                            }
                            
                            print("DEBUG:")
                            print("\tCreating WeatherObject with the following values:")
                            print("\t\tCondition:\t\(weatherConditions)")
                            print("\t\tWind:\t\(weatherWind!)")
                            print("\t\thumidity:\t\(weatherHumidity!)")
                            print("\t\tTemp:\t\(weatherTemp!)")
                            print("\t\tFeels Like:\t\(weatherFeelsLike!)")
                            print("\t\tUpdated:\t\(weatherLastUpdatedDate)")
                            
                            guard let weather = Weather(condition: weatherConditions, wind: weatherWind, humidity: weatherHumidity, temp: weatherTemp, feelsLike: weatherFeelsLike, lastUpdatedDate: weatherLastUpdatedDate) as Weather? else {
                                
                                print("No Weather Found")
                                continue
                                
                            }
                            
                            print("Creating Venue Object with the following details:")
                            print("\tVenueID: \(venueId)")
                            print("\tVenueName: \(venueName)")
                            print("\tCountry: \(country)")
                            print("\tSport: \(sport)")
                            print("\tWeather: \(weather)")
                            
                            let venue = Venue(venueId: venueId, venueName: venueName, venueCountry: country, venueSport: sport, venueWeather: weather)
                            
                            print("Created Venue: \(venue)")
  
                            self.venues.append(venue)
                            
                        }
                        
                        self.lastRequestedDate = NSDate()
                        
                    }
                    
                    self.postNotification("APWRequestCompletedSuccessfully", error: nil)
                    
                    
                } catch let errorType {
                    
                    print("Something went wrong! Reason: \(errorType)")
                    
                }
                
            }
            
        }
        
        task.resume()
    
    }
    
    func postNotification(notificationName: String, error: NSError?) {
    
        
        switch (notificationName) {
            
        case "APWRequestCompletedSuccessfully":
            
            let userInfoDict = [NSLocalizedDescriptionKey :  NSLocalizedString("Request Completed Successfully", value: "Request Completed Successfully!", comment: "")]
            
            NSNotificationCenter.defaultCenter().postNotificationName("APWRequestCompletedSuccessfully", object: self, userInfo: userInfoDict)
            
            
        default:
            
            let userInfoDict = [NSLocalizedDescriptionKey :  NSLocalizedString("Unknown Error", value: "An unknown error has occured!", comment: "")]
            
            NSNotificationCenter.defaultCenter().postNotificationName("APWUnknownError", object: self, userInfo: userInfoDict)
            
            
        }
        
    }
    
    //MARK: - Query Methods
    
    public func numberOfVenues() -> Int {
        
        return self.venues.count
        
    }
    
    public func venueAtIndex(index: Int) -> Venue? {
        
        if (index < venues.count-1) {
            
            return venues[index]
            
        } else {
            
            return nil
            
        }
        
    }


    //MARK: - Singleton
    
    public class var sharedInstance: DataRequester {
        
        struct Singleton {
            
            static let instance = DataRequester()
            
        }
        
        return Singleton.instance
        
    }
    
    
    
    
    

    
}