//
//  StateManager.swift
//  AirQ
//
//  Created by Azimjonoff on 21/07/23.
//

import Foundation

protocol StateManagerDelegate {
    func didUpdateStates(_ stateManager: StateManager, states: [State])
}

class StateManager {
    
    var delegate: StateManagerDelegate?
    
    func getStates(country: String) {
        let url = "https://api.airvisual.com/v2/states?country=" + country + "&key=03442986-76e1-4d06-a365-6180f7197e2c"
        
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
                    if let states = self.parseStatesJSON(safeData) {
                        self.delegate?.didUpdateStates(self, states: states)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseStatesJSON(_ statesData: Data) -> [State]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(StateData.self, from: statesData)
            let states = decodedData.data
            return states
        } catch {
            print(error)
            return nil
        }
    }
    
}
