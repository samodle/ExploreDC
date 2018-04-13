//
//  RubiconLocation.swift
//  ExploreDC
//
//  Created by sam on 4/11/18.
//  Copyright © 2018 Rubicon. All rights reserved.
//

import Foundation
import MapKit



class RubiconLocation {
    let title: String?
    let locationName: String
    let discipline: String
    let latitude: CGFloat
    let longitude: CGFloat
    var streetAddress: String = ""
    
    
    var panoPicNames = [String]() //file names of associated pics at this location
    
    init(title: String, locationName: String, discipline: String, latitude: CGFloat, longitude: CGFloat) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
    
}
