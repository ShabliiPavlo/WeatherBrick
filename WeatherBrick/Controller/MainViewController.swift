//
//  Created by Volodymyr Andriienko on 11/3/21.
//  Copyright © 2021 VAndrJ. All rights reserved.
//
import CoreLocation
import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var stoneIndicaorSide: NSLayoutConstraint!
    
    @IBOutlet weak var otherSide: NSLayoutConstraint!
    @IBOutlet weak var stoneIndicator: UIImageView!
    @IBOutlet weak var temperatureValue: UILabel!
    @IBOutlet weak var weatherStatus: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var cityName = ""
    var stoneView = StoneType()
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                view.addGestureRecognizer(tapGesture)
        
        // Добавляем жест PanGestureRecognizer к веревке
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleBrick(_:)))
        stoneIndicator?.addGestureRecognizer(panGesture)
        stoneIndicator?.isUserInteractionEnabled = true
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
        self.updateStoneUI(weather: weatherData.weather, temperature: weatherData.temperature, windSpeed: weatherData.windSpeed)
    }
    
    func updateAnimation() {
        UIView.animate(withDuration: 3, delay: 0, options: [.autoreverse,.repeat], animations: {
               self.stoneIndicaorSide.constant = -200
               self.view.layoutIfNeeded()
           }) { _ in
               // Возвращаем рисунок в центр после завершения анимации
               UIView.animate(withDuration: 3, delay: 0, options: []) {
                   self.stoneIndicaorSide.constant = 80
                   self.view.layoutIfNeeded()
               }
           }
    }
    
    func updateStoneUI(weather:String, temperature:Double, windSpeed:Double) {
        if weather == "Rain" {
            self.stoneIndicator.image = UIImage(named:stoneView.stoneType[3])
        } else if weather == "Snow" {
            self.stoneIndicator.image = UIImage(named:stoneView.stoneType[2])
        } else if temperature >= 40 {
            self.stoneIndicator.image = UIImage(named:stoneView.stoneType[0])
        } else if weather == "Mist" {
            self.stoneIndicator.alpha = 0.5
        } else if weather == "Thunderstorm" {
            self.stoneIndicator.image = UIImage(named:stoneView.stoneType[3])
        } else {
            self.stoneIndicator.image = UIImage(named:stoneView.stoneType[1])
        }
        if windSpeed > 8.0 {
            updateAnimation()
        }
    }
    
    @objc func handleBrick(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: stoneIndicator)
        
        switch recognizer.state {
        case .began, .changed:
            // Обновляем положение веревки
            stoneIndicator.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
            
        case .ended:
            // Вернуть веревку в исходное положение с анимацией
            UIView.animate(withDuration: 0.3) {
                self.stoneIndicator.transform = .identity
            }
            
            // Выполните обновление данных
            manager.requestLocation()
            
        default:
            break
        }
    }
}

extension MainViewController: UITextFieldDelegate {
}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Found user's location: \(location)")
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            LocationManager.locationManager.requestLocationData(longitude: lon, latitude: lat) { [weak self] myLocation in
                // Закодируем название города перед запросом погоды
                if let encodedCityName = myLocation.myCity.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    NetworkManager.manegerPro.requestWeatherData(cityName: encodedCityName) { [weak self] weatherData in
                        self?.updateWeatherUI(with: weatherData)
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension MainViewController {
    
    func nukeAllAnimations() {
        self.view.subviews.forEach({$0.layer.removeAllAnimations()})
        self.view.layer.removeAllAnimations()
        self.view.layoutIfNeeded()
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            if gesture.state == .ended {
                // Вызовите здесь вашу функцию
                yourFunctionToCall()
            }
        }
        
        func yourFunctionToCall() {
            // Ваш код для выполнения действия по касанию
            nukeAllAnimations()
        }
}
