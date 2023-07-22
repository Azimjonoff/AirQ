//
//  AirModel.swift
//  
//
//  Created by Azimjonoff on 19/07/23.
//

import Foundation

struct AirModel: Codable {
    
    let cityName: String
    let AQI: Int
    
    var AQILevel: String {
        switch AQI {
        case 0...50:
            return "Good"
        case 51...100:
            return "Moderate"
        case 101...150:
            return "Unhealthy for Sensitive Groups"
        case 151...200:
            return "Unhealthy"
        case 201...300:
            return "Very Unhealthy"
        default:
            return "Hazardous"
        }
    }
    
    var info: String {
        switch AQI {
        case 0...50:
            return "Air quality is considered satisfactory, and air pollution poses little or no risk"
        case 51...100:
            return "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution"
        case 101...150:
            return "Members of sensitive groups may experience health effects. The general public is not likely to be affected"
        case 151...200:
            return "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects"
        case 201...300:
            return "Health warnings of emergency conditions. The entire population is more likely to be affected"
        default:
            return "Health alert: everyone may experience more serious health effects"
        }
    }
}
