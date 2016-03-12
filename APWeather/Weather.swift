//
//  Weather.swift
//  APWeather
//
//  Created by Abrar Peer on 8/03/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import Foundation

public struct Weather : CustomStringConvertible {
    
    //    "_weatherCondition": "Mostly Cloudy",
    //    "_weatherConditionIcon": "mostlycloudy",
    //    "_weatherWind": "Wind: SSE at 0kph",
    //    "_weatherHumidity": "Humidity: 85%",
    //    "_weatherTemp": "13",
    //    "_weatherFeelsLike": "13",
    
    public var condition : String?
    public var conditionIcon : String
    public var wind : String?
    public var humidity : String?
    public var tempValue : Int?
    public var temperature : String {
        
        get {
            
            if (tempValue != nil) {

                return "\(tempValue!)ºC"
            
            } else {
                
                return "Unknown Temp"
                
            }
            
        }
        
    }
    public var feelsLikeValue : Int?
    
    public var feelsLike : String {
        
        get {
            
            if (feelsLikeValue != nil) {
                
                return "\(feelsLikeValue!)ºC"
                
            } else{
                
                return "Unknown"
                
            }
            
        }
        
    }
    
    public var lastUpdatedDate : NSDate
    
    public var lastUpdatedDateString : String {
        
        get {
            
            return self.dateFormatter.stringFromDate(lastUpdatedDate)
            
        }
        
    }
    
    public var description : String {
        
        get {
            
            var conditionDesc = "Unknown Weather Conditions"
            var windDesc = "Unknown Wind Conditions"
            var tempDesc = "the temperature is Unknown"
            var humidityDesc = "the humidity is Unknown"
            var feelsLikeDesc = "it is Unknown what it feels like!"
            
            if (condition != nil) {
                
                conditionDesc = "Weather Condition is \(condition!)"
                
            }
            
            if (wind != nil) {
                
                windDesc = wind!
                
            }
            
            if (humidity != nil ) {
                
                humidityDesc = humidity!
                
            }
            
            if (tempValue != nil) {
                
                tempDesc = "the temperature is \(tempValue!)℃"
                
            }
            
            if (feelsLikeValue != nil) {
                
                
                feelsLikeDesc = "it feels like \(feelsLikeValue!)℃"
                
            }
            
            return  "\(conditionDesc), with \(windDesc), \(tempDesc), \(humidityDesc) and \(feelsLikeDesc). Last Updated: \(lastUpdatedDateString)."
            
        }
        
    }
    
    private let dateFormatter : NSDateFormatter
    
    public init(condition: String?, wind: String?, humidity: String?, temp: Int?, feelsLike : Int?, lastUpdatedDate: NSDate) {
        
        if (condition != nil) {
            
            self.condition = condition!
            
        } else {
            
            self.condition = "Unknown"
            
        }
        
        switch (self.condition!) {
            
        case "Thunderstorm":
            
            self.conditionIcon = "tstorms"
            
        case "Rain":
            
            self.conditionIcon = "rain"
            
        case "Overcast":
            
            self.conditionIcon = "cloudy"
            
        case "Mostly Cloudy":
            
            self.conditionIcon = "mostlycloudy"
            
        case "Clear":
            
            self.conditionIcon = "clear"
            
        case "Mist":
            
            self.conditionIcon = "hazy"
            
        case "Scattered Clouds":
            
            self.conditionIcon = "partlycloudy"
            
        case "Partly Clouds":
            
            self.conditionIcon = "partlycloudy"
            
        case "Light Rain Showers":
            
            self.conditionIcon = "rain"
            
        case "Haze":
            
            self.conditionIcon = "hazy"
            
        case "Fog":
            
            self.conditionIcon = "fog"
            
        case "Shallow Fog":
            
            self.conditionIcon = "fog"
            
        case "Patches of Fog":
            
            self.conditionIcon = "fog"
            
        case "Smoke":
            
            self.conditionIcon = "hazy"
            
        default:
            
            self.conditionIcon = "unknown"
            
        }
        
        if (wind != nil) {
            
            self.wind = wind!
            
        } else {
            
            self.wind = "Unknown"
            
        }
        
        if (humidity != nil) {
            
            self.humidity = humidity!
            
        } else {
            
            self.humidity = "Unknown"
            
        }
        
        self.tempValue = temp
        
        self.feelsLikeValue = feelsLike
        
        self.lastUpdatedDate = lastUpdatedDate
        
        let df = NSDateFormatter()
        df.dateStyle = NSDateFormatterStyle.LongStyle
        
        self.dateFormatter = df
        
        
    }
    
    
}