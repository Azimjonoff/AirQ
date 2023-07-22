//
//  InfoViewController.swift
//  AirQ
//
//  Created by Azimjonoff on 17/07/23.
//

import UIKit

class InfoViewController: UIViewController, AirManagerDelegate {
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    var airManager = AirManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        airManager.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .plain, target: self, action: #selector(locatePressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchPressed))
        
    }
    
    @objc func locatePressed() {
        let url = "https://api.airvisual.com/v2/nearest_city?key=03442986-76e1-4d06-a365-6180f7197e2c"
        
        airManager.performLocationRequest(with: url)
    }
    
    @objc func searchPressed() {
        if let vc = storyboard?.instantiateViewController(identifier: "CustomCity") as? CityViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func didUpdateAir(_ airManager: AirManager, air: AirModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = air.cityName
            self.scoreLabel.text = String(air.AQI)
            self.levelLabel.text = air.AQILevel
            self.infoLabel.text = air.info
            
            switch air.AQI {
            case 0...50:
                self.view.backgroundColor = .green
            case 51...100:
                self.view.backgroundColor = .yellow
            case 101...150:
                self.view.backgroundColor = .orange
            case 151...200:
                self.view.backgroundColor = .red
            case 201...300:
                self.view.backgroundColor = .brown
            default:
                self.view.backgroundColor = .darkGray
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
