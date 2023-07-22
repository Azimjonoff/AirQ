//
//  ViewController.swift
//  AirQ
//
//  Created by Azimjonoff on 17/07/23.
//

import UIKit
import DropDown

class CityViewController: UIViewController, StateManagerDelegate, CityManagerDelegate {
    
    @IBOutlet var countryView: UIView!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var stateView: UIView!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var cityView: UIView!
    @IBOutlet var cityLabel: UILabel!
    
    let countryDropDown = DropDown()
    let stateDropDown = DropDown()
    let cityDropDown = DropDown()
    
    let stateManager = StateManager()
    let cityManager = CityManager()
    
    let countries = ["Uzbekistan", "Russia", "India", "USA", "China"]
    var statess = [""]
    var citiess = [""]
    
    var country = ""
    var state = ""
    var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stateManager.delegate = self
        cityManager.delegate = self
        
        countryView.layer.borderWidth = 0.5
        countryView.layer.cornerRadius = 5
        countryDropDown.anchorView = countryView
        countryDropDown.dataSource = countries
        countryDropDown.bottomOffset = CGPoint(x: 0, y: (countryDropDown.anchorView?.plainView.bounds.height)!)
        
        stateView.layer.borderWidth = 0.5
        stateView.layer.cornerRadius = 5
        stateDropDown.anchorView = stateView
        stateDropDown.dataSource = statess
        stateDropDown.bottomOffset = CGPoint(x: 0, y: (stateDropDown.anchorView?.plainView.bounds.height)!)
        
        cityView.layer.borderWidth = 0.5
        cityView.layer.cornerRadius = 5
        cityDropDown.anchorView = cityView
        cityDropDown.dataSource = citiess
        cityDropDown.bottomOffset = CGPoint(x: 0, y: (cityDropDown.anchorView?.plainView.bounds.height)!)
        
    }
    
    @IBAction func countryPressed(_ sender: Any) {
        countryDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.countryLabel.text = item
            self?.country = item
            self?.stateManager.getStates(country: item)
        }
        countryDropDown.show()
    }
    
    
    @IBAction func statePressed(_ sender: Any) {
        stateDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.stateLabel.text = item
            let country = self?.country
            self?.state = item
            self?.cityManager.getCities(country: country!, state: item)
        }
        stateDropDown.show()
    }
    
    @IBAction func cityPressed(_ sender: Any) {
        cityDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.cityLabel.text = item
            self?.city = item
        }
        cityDropDown.show()
    }
    
    
    @IBAction func goPressed(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(identifier: "Info") as? InfoViewController {
            navigationController?.pushViewController(vc, animated: true)
            let url = "https://api.airvisual.com/v2/city?city="+city+"&state="+state+"&country="+country+"&key=03442986-76e1-4d06-a365-6180f7197e2c"
            vc.airManager.performLocationRequest(with: url)
        }
    }
    
    func didUpdateStates(_ stateManager: StateManager, states: [State]) {
        DispatchQueue.main.async {
            self.statess.removeAll()
            for state in states {
                self.statess.append(state.state)
            }
            self.stateDropDown.dataSource = self.statess
        }
    }
    
    func didUpdateCities(_ cityManager: CityManager, cities: [City]) {
        DispatchQueue.main.async {
            self.citiess.removeAll()
            for city in cities {
                self.citiess.append(city.city)
            }
            self.cityDropDown.dataSource = self.citiess
        }
    }
}

