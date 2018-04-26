//
//  Artwork.swift
//  ExploreDC
//
//  Created by sam on 4/26/18.
//  Copyright © 2018 Rubicon. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: Discipline
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: Discipline, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
        
    var subtitle: String? {
        return locationName
    }
    
    // pinTintColor for disciplines: Sculpture, Plaque, Mural, Monument, other
    var markerTintColor: UIColor  {
        switch discipline {
        case Discipline.cemetery:
            return .red
        case Discipline.etc:
            return .cyan
        case Discipline.government:
            return .blue
        case Discipline.memorial:
            return .purple
        case Discipline.museum:
            return .green
        case Discipline.event:
            return .orange
        }
    }
    
    var imageName: String? {
        switch discipline {
        case Discipline.cemetery:
            return "tomb.png"
        case Discipline.etc:
            return "tree.png"
        case Discipline.government:
            return "capi.png"
        case Discipline.memorial:
            return "monu.png"
        case Discipline.museum:
            return "muse.png"
        case Discipline.event:
            return "prot.png"
        }
    }
    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
}
