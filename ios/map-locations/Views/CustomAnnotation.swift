//
//  CustomAnnotation.swift
//  map-locations
//
//  Created by Nic on 9/27/24.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    
    let location: Location
    var coordinate: CLLocationCoordinate2D {
        location.coordinate
    }
    var title: String? {
        location.name
    }
    var subtitle: String? {
        location.description
    }
    
    init(location: Location) {
        self.location = location
        super.init()
    }
}
