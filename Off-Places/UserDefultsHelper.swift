//
//  UserDefultsHelper.swift
//  Off-Places
//
//  Created by Esraa on 4/29/19.
//  Copyright © 2019 example. All rights reserved.
//

import Foundation

class DataSaver {
    static var locations = [Location]()
    
    static func addLocation(location: Location) {
        if !(locations.map { $0.name}).contains(location.name) { locations.append(location) }
        if let encodedLocations = try? JSONEncoder().encode(locations) {
            UserDefaults.standard.set(encodedLocations, forKey: "SavedLocations")
        }
    }
    
    static func getLocations() -> [Location] {
        if let decodedLocations = try? JSONDecoder().decode([Location].self, from: UserDefaults.standard.value(forKey: "SavedLocations") as? Data ?? Data()) {
            return decodedLocations
        }
        return locations
    }
}
