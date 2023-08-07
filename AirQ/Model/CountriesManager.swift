//
//  CountriesManager.swift
//  AirQ
//
//  Created by Azimjonoff on 07/08/23.
//

import Foundation

protocol CountriesManagerDelegate {
    func didUpdateCountries(_ countriesManager: CountriesManager, countries: [Country])
}

class CountriesManager {
    
    var delegate: CountriesManagerDelegate?
    
    func getCountires() {
        let url = "https://api.airvisual.com/v2/countries?key=03442986-76e1-4d06-a365-6180f7197e2c"
        
        print(url)
        performStatesRequest(with: url)
    }
    
    func performStatesRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let countries = self.parseCountriesJSON(safeData) {
                        self.delegate?.didUpdateCountries(self, countries: countries)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseCountriesJSON(_ countriesData: Data) -> [Country]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CountryData.self, from: countriesData)
            let countries = decodedData.data
            return countries
        } catch {
            print(error)
            return nil
        }
    }
    
}
