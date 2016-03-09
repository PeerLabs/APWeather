//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

var str = "Hello, playground"

typealias Payload = [String: AnyObject]
typealias PayloadData = [AnyObject]

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true



JsonDataManager.getDataFromFileWithSuccess { (data) -> Void in
    
    // TODO: Process data
    
    var json : Payload!
    
    //JSON Deserialization
    
//    let url = "http://dnu5embx6omws.cloudfront.net/venues/weather.json"
    
    do {
        
        
//        
        json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? Payload
        
    } catch {
        
        print(error)
        
        XCPlaygroundPage.currentPage.finishExecution()
        
    }

    if let dataObjects = json["data"] as? PayloadData {
        
        let numberOfDataOjects = dataObjects.count
        
        print("\(numberOfDataOjects) Data Objects")
        
        
        var venues = [Venue]()
        
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
            

            guard let weather = Weather(condition: weatherConditions, wind: weatherWind, humidity: weatherHumidity, temp: weatherTemp, feelsLike: weatherTemp, lastUpdatedDate: weatherLastUpdatedDate) as Weather? else {
                
                print("No Weather Found")
                continue
                
            }
            
            
            venues.append(Venue(venueId: venueId, venueName: venueName, venueCountry: country, venueSport: sport, venueWeather: weather))
            
            
            
            
            
            

            
//            "_sport": {
//                "_sportID": "1",
//                "_description": "Horse Racing"
            
            
//            print("Sport is \(sportObject)")
            
            
            
//            let sportObject = object["_sport"]
//            
//            let sport = Sport(sportId: sportObject!["_sportID"], sportName: sportObject["_description"])
            
            
            
            
//            print("Venue Name: \(object["_name"]!) with Id \(object["_venueID"]!)")
//            print("\n")
            
        }

        
        
        
        
    }
    
    

    
    
    

    
}

