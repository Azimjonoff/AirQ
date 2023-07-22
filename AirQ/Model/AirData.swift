//
//  AirData.swift
//  AirQ
//
//  Created by Azimjonoff on 19/07/23.
//

import Foundation

struct AirData: Codable {
    let data: Dataa
}

struct Dataa: Codable {
    let city: String
    let current: Current
}

struct Current: Codable {
    let pollution: Pollution
}

struct Pollution: Codable {
    let aqius: Int
}
