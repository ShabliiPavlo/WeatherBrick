//
//  WeatherBrickTests.swift
//  WeatherBrickTests
//
//  Created by Pavel Shabliy on 10.08.2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import SnapshotTesting
import XCTest
@testable import WeatherBrick

class MyViewControllerTests: XCTestCase {
    
    func testInfoViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InfoViewController")
        
        assertSnapshot(matching: vc, as: .image)
    }
    
    func testMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        assertSnapshot(matching: vc, as: .image)
    }
    
}


//class WeatherBrickTests: XCTestCase {
//
//    var test : MainViewController!
//
//    override func setUp() {
//        super.setUp()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        test = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
//
//    }
//
//    override func tearDown() {
//        super.tearDown()
//        test = nil
//    }
//
//      func testMainViewController() {
//        assertSnapshot(matching: test, as: .image)
//      }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//}
