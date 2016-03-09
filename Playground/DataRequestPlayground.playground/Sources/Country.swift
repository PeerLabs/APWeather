//
//  Country.swift
//  APWeather
//
//  Created by Abrar Peer on 8/03/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import Foundation

public struct Country : CustomStringConvertible {
    
    
//    "_countryID": "16",
//    "_name": "Australia"
    
    public var id : String
    
    public var name : String?
    
    public var description : String {
        
        get {
            
            if (name == nil) {
                
                return "Unkown Country with \(id)."
                
            } else {
                
                return "Country \(name!) with \(id)."
                
            }

        }
        
    }
    
    public init(countryId: String, countryName: String?) {
        
        self.id = countryId
        self.name = countryName
        
    }

    
}