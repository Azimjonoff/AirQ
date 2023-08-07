//
//  CountriesData.swift
//  AirQ
//
//  Created by Azimjonoff on 07/08/23.
//

import Foundation

struct CountryData: Codable {
    let data: [Country]
}

struct Country: Codable {
    let country: String
}
