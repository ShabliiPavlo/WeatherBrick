//
//  NetworkManager.swift
//  WeatherBrick
//
//  Created by Pavel Shabliy on 30.07.2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager {
    
    static let manegerPro = NetworkManager()
    
    func requestWeatherData(cityName: String, completion: @escaping (WeatherManager) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=4cdcf6c88b1d745b2d3601b52ae18dd4&units=metric"
        
        AF.request(url).responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let allData):
                let temperature = allData.main?.temp ?? 0.0
                let weather = allData.weather?.first?.main ?? ""
                let city = allData.name ?? ""
                let country = allData.sys?.country ?? ""
                let weatherData = WeatherManager(temperature: temperature, weather: weather, city: city, country: country)
                
                completion(weatherData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func isInternetAvailable() -> Bool {
        let networkManager = NetworkReachabilityManager()
        return networkManager?.isReachable ?? false
    }
}



