//
//  Created by Volodymyr Andriienko on 11/3/21.
//  Copyright © 2021 VAndrJ. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    @IBOutlet weak var stoneIndicator: UIImageView!
    @IBOutlet weak var temperatureValue: UILabel!
    @IBOutlet weak var weatherStatus: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var cityName = ""
    var stoneView = StoneType()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
        if  NetworkManager.manegerPro.isInternetAvailable() != true {
            self.stoneIndicator.isHidden = true
        }
        guard let cityName = searchTextField.text, !cityName.isEmpty else { return }
        self.cityName = cityName
        
        NetworkManager.manegerPro.requestWeatherData(cityName: cityName) { [weak self] weatherData in
            self?.updateWeatherUI(with: weatherData)
        }
    }
    
    func updateWeatherUI(with weatherData: WeatherManager) {
        self.cityLabel.text = "\(weatherData.city), \(weatherData.country)"
        self.weatherStatus.text = weatherData.weather
        self.temperatureValue.text = String(Int(weatherData.temperature))
        self.updateStoneUI(weather: weatherData.weather, temperature: weatherData.temperature)
    }
    
    func updateStoneUI(weather:String, temperature:Double) {
        if weather == "Rain" {
            self.stoneIndicator.image = UIImage(named:stoneView.stoneType[3])
        } else if weather == "Snow" {
            self.stoneIndicator.image = UIImage(named:stoneView.stoneType[2])
        } else if temperature >= 40 {
            self.stoneIndicator.image = UIImage(named:stoneView.stoneType[0])
        } else if weather == "Mist" {
            self.stoneIndicator.alpha = 0.5
        } else {
            self.stoneIndicator.image = UIImage(named:stoneView.stoneType[1])
        }
    }
}

extension MainViewController: UITextFieldDelegate {
}

