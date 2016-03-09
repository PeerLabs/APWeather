//
//  Sport.swift
//  APWeather
//
//  Created by Abrar Peer on 8/03/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import Foundation

public struct Sport : CustomStringConvertible{
    
//    "_sportID": "1",
//    "_description": "Horse Racing"
    
    public var id : String
    
    public var name : String?
        
    public init(sportId: String, sportName: String?) {
        
        self.id = sportId
        self.name = sportName
        
    }
    
    public var description : String {
        
        get {
            
            if (name == nil) {
                
                return "Unknown Sport with \(id)."
                
            } else {
                
                return "Sport \(name!) with \(id)."
            }
            
            
            
        }
        
    }

    
    
}