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
//    @IBOutlet var rainIntensityLabel: UILabel!
    
    
    @IBOutlet var weatherImg: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var latLabel: UILabel!
    @IBOutlet var lngLabel: UILabel!
    
//    var lat = ""
//    var lng = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        animateBlurViews()

        setLabels()
    }
    
    
    func setLabels()
    {
        if location?.weather != nil
        {
            assignWeatherImg((location?.weather!.icon)!)
            startGeocoder()
            
            cityLabel.text = location!.city
            quickWeatherLabel.text = location!.weather!.summary
            
            let humidity = location!.weather!.humidity
            switch humidity
            {
            case 0.0...0.2: humidityLabel.text = "It's very dry today"
            case 0.2...0.4: humidityLabel.text = "It's dry today"
            case 0.4...0.6: humidityLabel.text = "It's neither dry nor humid"
            case 0.6...0.8: humidityLabel.text = "It's humid today"
            case 0.8...1.0: humidityLabel.text = "It's very humid today"
            default: "Humidity"
            }
            
            let rainProb = location!.weather!.precipProbability
            if rainProb != 0.0
            {
                
            }
            
            let rainIntens = location!.weather!.precipIntensity
            if rainIntens != 0.0
            {
            }
            
            latLabel.text = location!.lat
            lngLabel.text = location!.lng
            
            
            let temp =  String(location!.weather!.temp).componentsSeparatedByString(".")[0]
            tempLabel.text = temp + "°"
            
            let apparentTemp = String(location!.weather!.apparentTemp).componentsSeparatedByString(".")[0]
            if Int(apparentTemp) == Int(temp)
            {
                appTempLabel.text = "  fahrenheit"
            }
            else
            {
                print(apparentTemp) ; print(temp)
                appTempLabel.text = ", but feels like " + apparentTemp + "°"
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
        geocoder.geocodeAddressString((location?.city)!, completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?)-> Void in
            if let placemark = placemarks?[0]
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark.location?.coordinate)!
                annotation.title = self.location!.city
                annotation.subtitle = String(self.location!.weather!.temp).componentsSeparatedByString(".")[0] + "°"
//                self.mapView.addAnnotation(annotation)
                let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 20000, 20000)
                
                self.mapView.setRegion(region, animated: true)
            }
            
        })
        

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
