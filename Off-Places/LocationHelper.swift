//
//  LocationHelper.swift
//  Off-Places
//
//  Created by Esraa on 4/29/19.
//  Copyright © 2019 example. All rights reserved.
//

import UIKit
import MapKit

struct LocationHelper {
    static func getLocationName(_ location: CLLocation, completionHandler: @escaping (String) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            placemarks?.forEach { (placemark) in
                if let city = placemark.locality {
                    completionHandler(city)
                }
            }
        }
    }
}
