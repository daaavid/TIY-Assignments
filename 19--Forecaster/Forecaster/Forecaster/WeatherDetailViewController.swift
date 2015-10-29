//
//  WeatherDetailViewController.swift
//  Forecaster
//
//  Created by david on 10/29/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController
{
    var weather = Weather?()
    
    @IBOutlet var latLabel: UILabel!
    @IBOutlet var lngLabel: UILabel!
    
//    var lat = ""
//    var lng = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        latLabel.text = weather!.lat
        lngLabel.text = weather!.lng
//        print(lat)
//        print(lng)
//        latLabel.text = self.lat
//        lngLabel.text = self.lng
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populate()
    {
        print("populate() " + weather!.lat + weather!.lng)

    }

}
