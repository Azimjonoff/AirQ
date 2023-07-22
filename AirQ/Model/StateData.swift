//
//  CityModel.swift
//  AirQ
//
//  Created by Azimjonoff on 19/07/23.
//

import Foundation

struct StateData: Codable {
    let data: [State]
}

struct State: Codable {
    let state: String
}
