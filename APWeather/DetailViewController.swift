//
//  DetailViewController.swift
//  APWeather
//
//  Created by Abrar Peer on 7/03/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var venue : Venue? {
        
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var venueIdLabel: UILabel!

    @IBOutlet weak var venueNameLabel: UILabel!

    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var sportIdLabel: UILabel!
    
    @IBOutlet weak var sportNameLabel: UILabel!
    
    @IBOutlet weak var weatherConditionsLabel: UILabel!
    
    @IBOutlet weak var weatherHumidityLabel: UILabel!
    
    @IBOutlet weak var weatherTempLabel: UILabel!
    
    @IBOutlet weak var weatherFeelsLikeLabel: UILabel!
    
    @IBOutlet weak var weatherUpdatedDateLabel: UILabel!
    
    func configureView() {
        
        // Update the user interface for the detail item.
        if let venue = self.venue {
            
            if let titlebar = self.navTitle {
                
                titlebar.title? = "Details for \(venue.name)"
                
            }
            
            if let label = self.venueIdLabel {
                
                 label.text = venue.id
                
            }
            
            if let label = self.venueNameLabel {
                
                label.text = venue.name
            }
            
            if let label = self.countryNameLabel {
                
                label.text = venue.country?.name
                
            }
            
            if let label = self.sportIdLabel {
                
                label.text = venue.sport?.id
            }
            
            if let label = self.sportNameLabel {
                
                label.text = venue.sport?.name
                
            }
            
            if let label = self.weatherConditionsLabel {
                
                label.text = venue.weather?.condition
                
            }
            
            if let label = self.weatherHumidityLabel {
                
                label.text = venue.weather?.humidity
                
            }
            
            if let label = self.weatherTempLabel {
                
                label.text = venue.weather?.temperature
                
            }
            
            if let label = self.weatherFeelsLikeLabel {
                
                label.text = venue.weather?.feelsLike
                
            }
            
            if let label = self.weatherUpdatedDateLabel {
                
                label.text = venue.weather?.lastUpdatedDateString
                
            }
            
        } else {
            
            navTitle.title? = "Unknown"
            
            venueIdLabel.text = "Unknown"
            venueNameLabel.text = "Unknown"
            countryNameLabel.text = "Unknown"
            sportIdLabel.text = "Unknown"
            sportNameLabel.text = "Unknown"
            weatherConditionsLabel.text = "Unknown"
            weatherHumidityLabel.text = "Unknown"
            weatherTempLabel.text = "Unknown"
            weatherFeelsLikeLabel.text = "Unknown"
            weatherFeelsLikeLabel.text = "Unknown"
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

