//
//  Venue.swift
//  APWeather
//
//  Created by Abrar Peer on 8/03/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import Foundation

public class Venue : CustomStringConvertible  {
    
    public var id : String
    public var name : String
    public var country : Country?
    public var sport : Sport?
    public var weather : Weather?
    
    public var description : String {
        
        get {
            
            
            var countryDescription = "an Unknown Country"
            
            
            if (country != nil) {
                
                countryDescription = country!.name!
                
            }
            
            var sportDescription = "an Unknown Sport"
            
            if (sport != nil) {
                
                sportDescription = sport!.name!
                
                
            }
            
            var weatherDescription = "unknown Weather Conditions"
            
            
            if (weather != nil) {
                
                weatherDescription = "\(weather!)"
                
            }
            
            return "Venue: \(name) with \(id) in \(countryDescription) is hosting \(sportDescription).\n\(weatherDescription)."
            
        }
        
    }
    
    public init(venueId: String, venueName: String, venueCountry: Country?, venueSport: Sport?, venueWeather: Weather?) {
        
        self.id = venueId
        self.name = venueName
        
        self.country = venueCountry
        self.sport = venueSport
        self.weather = venueWeather
        
    }

}



