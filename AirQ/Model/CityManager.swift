//
//  CityManager.swift
//  AirQ
//
//  Created by Azimjonoff on 21/07/23.
//

import Foundation

protocol CityManagerDelegate {
    func didUpdateCities(_ cityManager: CityManager, cities: [City])
}

class CityManager {
    
    var delegate: CityManagerDelegate?
    
    func getCities(country: String, state: String) {
        let url = "https://api.airvisual.com/v2/cities?state=" + state + "&country=" + country + "&key=03442986-76e1-4d06-a365-6180f7197e2c"
        
        performCitiesRequest(with: url)
    }
    
    func performCitiesRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let cities = self.parseCitiesJSON(safeData) {
                        self.delegate?.didUpdateCities(self, cities: cities)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseCitiesJSON(_ citiesData: Data) -> [City]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CityData.self, from: citiesData)
            let cities = decodedData.data
            return cities
        } catch {
            print(error)
            return nil
        }
    }
    
}
