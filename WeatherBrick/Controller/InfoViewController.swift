//
//  InfoViewController.swift
//  WeatherBrick
//
//  Created by Pavel Shabliy on 25.07.2023.
//  Copyright © 2023 VAndrJ. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var frame: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "image_background")
        background?.image = image
        background?.contentMode = .scaleAspectFill
        background?.clipsToBounds = true
            
        makeViewRoundCorners()
    }

    @IBAction func hideButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func makeViewRoundCorners() {
        let cornerRadius: CGFloat = 20.0

        frame?.layer.cornerRadius = cornerRadius
         
        frame?.layer.masksToBounds = true
        }
    
}
