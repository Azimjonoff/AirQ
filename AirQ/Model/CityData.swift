//
//  CityData.swift
//  AirQ
//
//  Created by Azimjonoff on 21/07/23.
//

import Foundation

struct CityData: Codable {
    let data: [City]
}

struct City: Codable {
    let city: String
}
