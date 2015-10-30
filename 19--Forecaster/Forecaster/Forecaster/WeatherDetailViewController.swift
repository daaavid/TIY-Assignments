//
//  WeatherDetailViewController.swift
//  Forecaster
//
//  Created by david on 10/29/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class WeatherDetailViewController: UIViewController
{
    var location = Location?()
    
    @IBOutlet var latLabel: UILabel!
    @IBOutlet var lngLabel: UILabel!
    @IBOutlet var weatherImg: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
//    var lat = ""
//    var lng = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if location?.weather != nil
        {
            assignWeatherImg((location?.weather!.icon)!)
            startGeocoder()
        }
    }
    
    func assignWeatherImg(icon: String)
    {
        switch icon
        {
        case "clear-day": weatherImg.image = UIImage(named: "clear-day")
        animateWeatherImg()
        case "clear-night": weatherImg.image = UIImage(named: "clear-night")
        animateWeatherImg()
        case "rain": weatherImg.image = UIImage(named: "rain")
        animateWeatherImg()
        case "snow": weatherImg.image = UIImage(named: "snow")
        animateWeatherImg()
        case "sleet": weatherImg.image = UIImage(named: "sleet")
        animateWeatherImg()
        case "wind": weatherImg.image = UIImage(named: "wind")
        animateWeatherImg()
        case "fog": weatherImg.image = UIImage(named: "fog")
        animateWeatherImg()
        case "cloudy": weatherImg.image = UIImage(named: "cloudy")
        animateWeatherImg()
        case "partly-cloudy-day": weatherImg.image = UIImage(named: "partly-cloudy-day")
        animateWeatherImg()
        case "partly-cloudy-night": weatherImg.image = UIImage(named: "partly-cloudy-night")
        animateWeatherImg()
        default: weatherImg.image = UIImage(named: "na")
        animateWeatherImg()
        }
    }
    
    func animateWeatherImg()
    {
//        if location.imgHasBeenAnimated == false
//        {
            UIView.animateWithDuration(0.5, delay: 0.5, options: [], animations:
                {
                    var img = self.weatherImg.frame
                    img.origin.x += img.size.width + 100
                    
                    self.weatherImg.frame = img
                }, completion: nil)
//            location.imgHasBeenAnimated = true
//        }
    }
    
    func startGeocoder()
    {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString((location?.city)!, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?)-> Void in
            if let placemark = placemarks?[0]
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark.location?.coordinate)!
//                annotation.title = "Lakeland, FL"
                self.mapView.addAnnotation(annotation)
                let annArr = [annotation]
                self.mapView.camera.altitude *= 2
                self.mapView.showAnnotations(annArr, animated: true)
            }
            
        })
        

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
