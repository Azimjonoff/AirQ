//
//  AirData.swift
//  
//
//  Created by Azimjonoff on 17/07/23.
//

import Foundation

protocol AirManagerDelegate {
    func didUpdateAir(_ airManager: AirManager, air: AirModel)
    func didFailWithError(error: Error)
}

class AirManager {
    
    var delegate: AirManagerDelegate?
    
    func performLocationRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            print(url)
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let air = self.parseLocationJSON(safeData) {
                        self.delegate?.didUpdateAir(self, air: air)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseLocationJSON(_ airData: Data) -> AirModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(AirData.self, from: airData)
            let cityName = decodedData.data.city
            let AQI = decodedData.data.current.pollution.aqius
            
            let city = AirModel(cityName: cityName, AQI: AQI)
            print(AQI)
            return city
            
        } catch {
            print(error)
            return nil
        }
    }
}
