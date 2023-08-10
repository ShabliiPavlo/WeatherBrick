//
//  LocationManager.swift
//  WeatherBrick
//
//  Created by Pavel Shabliy on 03.08.2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import UIKit
import Alamofire

class LocationManager {
    
    static let locationManager = LocationManager()
    
    func requestLocationData(longitude: Double,latitude: Double,completion: @escaping (MyLocation) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=4cdcf6c88b1d745b2d3601b52ae18dd4&units=metric"
        
        AF.request(url).responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let allData):
                
                let city = allData.name ?? "" 
                let myLocation = MyLocation(myCity: city)
                
                completion(myLocation)
            case .failure(let error):
                print(error)
            }
        }
    }
}


