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
    
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var cityBlurView: UIVisualEffectView!
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var appTempLabel: UILabel!
    
    @IBOutlet var quickWeatherLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var rainProbabilityLabel: UILabel!
    
    @IBOutlet var weatherImg: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var latLabel: UILabel!
    @IBOutlet var lngLabel: UILabel!
    
    @IBOutlet var showForecastButton: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        mapView.mapType = MKMapType.HybridFlyover
        
        animateBlurViews()

        setLabels()
    }
    
    
    func setLabels()
    {
        if location?.weather != nil
        {
            assignWeatherImg((location?.weather!.icon)!)
            startGeocoder()
            
            let city = location!.city
            
            cityLabel.text = city
            quickWeatherLabel.text = location!.weather!.summary
            
            let humidity = location!.weather!.humidity
            var humidStr = ""
            
            switch humidity
            {
            case 0...40: humidStr = "It's horribly dry"
            case 40...50: humidStr = "It's very dry"
            case 50...55: humidStr = "It's somewhat dry"
            case 55...60: humidStr = "It's neither dry nor humid"
            case 60...65: humidStr = "It's somewhat humid"
            case 65...70: humidStr = "It's fairly humid"
            case 70...75: humidStr = "It's very humid"
            case 70...80: humidStr = "It's horribly humid"
            case 80...100: humidStr = "It's digustingly humid"
            default: break
            }
            
            humidityLabel.text = humidStr
            
            let rainProb = location!.weather!.precipProbability
            var rainStr = "No rain today"
            
            if rainProb != 0.0
            {
                switch rainProb
                {
                case 0.0...0.4: rainStr = "Rain is unlikely"
                case 0.4...0.6: rainStr = "It may rain"
                case 0.6...0.8: rainStr = "It will probably rain"
                case 0.8...0.9: rainStr = "Rain is very likely"
                default: break
                }
                
                if rainProb == 1.0
                {
                    let rainIntens = location!.weather!.precipIntensity
                    
                    switch rainIntens
                    {
                    case 0.0...0.2: rainStr = "It is raining lightly"
                    case 0.2...0.5: rainStr = "It is raining moderately"
                    case 0.5...0.8: rainStr = "It is raining heavily"
                    case 0.8...1.0: rainStr = "It is raining very heavily"
                    default: break
                    }
                }
            }
            
            rainProbabilityLabel.text = rainStr
            
            latLabel.text = location!.lat
            lngLabel.text = location!.lng
            
            
            let temp = location!.weather!.temp
            tempLabel.text = String(temp) + "°"
            
            let apparentTemp = location!.weather!.apparentTemp
            if temp == apparentTemp
            {
                appTempLabel.text = ", and feels like it too"
            }
            else
            {
                print(apparentTemp) ; print(temp)
                appTempLabel.text = ", but feels like " + String(apparentTemp) + "°"
            }
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
        UIView.animateWithDuration(0.5, delay: 1.0, options: [], animations:
        {
            var img = self.weatherImg.frame
            img.origin.x += img.size.width + 400
            
            self.tempLabel.frame = img
            self.appTempLabel.frame = img
            self.rainProbabilityLabel.frame = img
            self.humidityLabel.frame = img
            self.quickWeatherLabel.frame = img
            self.weatherImg.frame = img
        }, completion: nil)
    }
    
    func animateBlurViews()
    {
        UIView.animateWithDuration(0.5, delay: 0.5, options: [], animations:
        {
            var blurView = self.blurView.frame
            blurView.origin.y -= blurView.size.height + 600
            
            var cityBlurView = self.cityBlurView.frame
            cityBlurView.origin.y -= cityBlurView.size.height - 600
            
            self.blurView.frame = blurView
            self.cityBlurView.frame = cityBlurView
            
        }, completion: nil)

    }
    
    func startGeocoder()
    {
        let geocoder = CLGeocoder()
        let cityAndState = "\(location!.city), \(location!.state)"
        print(cityAndState)
        geocoder.geocodeAddressString(cityAndState, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?)-> Void in
            if let placemark = placemarks?[0]
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark.location?.coordinate)!
                annotation.title = self.location!.city
                annotation.subtitle = String(self.location!.weather!.temp).componentsSeparatedByString(".")[0] + "°"
//                self.mapView.addAnnotation(annotation)
                let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 15000, 15000)
                
                self.mapView.setRegion(region, animated: true)
            }
            
        })
        

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showForecastButton(sender: UIBarButtonItem)
    {
        let weekForecastVC = storyboard?.instantiateViewControllerWithIdentifier("WeekForecastTableViewController") as! WeekForecastTableViewController
        
        weekForecastVC.location = location
        
        navigationController?.pushViewController(weekForecastVC, animated: true)
    }
}
