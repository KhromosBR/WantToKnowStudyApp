//
//  Place.swift
//  QueroConhecer
//
//  Created by Ricardo Duarte on 2018-06-03.
//  Copyright © 2018 KTech. All rights reserved.
//

import Foundation
import MapKit

struct Place {
    let name: String
    let latitude: CLLocationDegrees
    let longitude : CLLocationDegrees
    let address: String
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func getFormattedStreetAddress(with placemark: CLPlacemark) -> String {
        var address = ""
        //Street number
        if let number = placemark.subThoroughfare {
            address += number
        }
        //Street name
        if let street = placemark.thoroughfare {
            address += " \(street)"
        }
        
        //Bairro
        if let subLocality = placemark.subLocality {
            address += ", \(subLocality)"
        }
        //city
        if let city = placemark.locality{
            address += "\n\(city)"
        }
        //state
        if let state = placemark.administrativeArea{
            address += " - \(state)"
        }
        //postal code
        if let postalCode = placemark.postalCode {
            address += "\nPostal Code: \(postalCode)"
        }
        //Country
        if let country = placemark.country{
            address += "\n\(country)"
        }
        return address
    }
    
}
