//
//  Location.swift
//  Off-Places
//
//  Created by Esraa on 4/29/19.
//  Copyright © 2019 example. All rights reserved.
//

import Foundation

struct Location: Codable {
    var name: String
    var coordinates: Coordinates
}

struct Coordinates: Codable {
    var latitude, longitude: Double
}
