//
//  WeatherBrickUnitTests.swift
//  WeatherBrickTests
//
//  Created by Pavel Shabliy on 10.08.2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import XCTest
@testable import WeatherBrick

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!
    var locatinManager: LocationManager!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.manegerPro
        locatinManager = LocationManager.locationManager
    }

    override func tearDown() {
        networkManager = nil
        locatinManager = nil
        super.tearDown()
    }

    func testRequestWeatherDataSuccess() {
        let expectation = self.expectation(description: "Weather data request")
        
        networkManager.requestWeatherData(cityName: "London") { weatherData in
            XCTAssertEqual(weatherData.city, "London")
            XCTAssertGreaterThan(weatherData.temperature, -100)
            XCTAssertFalse(weatherData.weather.isEmpty)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

    func testIsInternetAvailable() {
        let isConnected = networkManager.isInternetAvailable()
        XCTAssertTrue(isConnected)
    }
    
    func testRequestLocationDataSuccess() {
           let expectation = self.expectation(description: "Location data request should succeed")
           
        locatinManager.requestLocationData(longitude:  -122.4064, latitude: 37.7858) { myLocation in
               XCTAssertEqual(myLocation.myCity, "San Francisco")
               expectation.fulfill()
           }
           
           waitForExpectations(timeout: 10, handler: nil)
       }
}
