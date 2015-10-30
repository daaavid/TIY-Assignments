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
    @IBOutlet var rainProb: UILabel!
    @IBOutlet var rainIntensity: UILabel!
    
    
    @IBOutlet var weatherImg: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
//    var lat = ""
//    var lng = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        animateBlurViews()
        
        if location?.weather != nil
        {
            assignWeatherImg((location?.weather!.icon)!)
            startGeocoder()
            
            cityLabel.text = location!.city
            quickWeatherLabel.text = location!.weather!.summary
            tempLabel.text = String(location!.weather!.temp).componentsSeparatedByString(".")[0] + "°"
            appTempLabel.text = "Feels like " + String(location!.weather!.apparentTemp).componentsSeparatedByString(".")[0] + "°"
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
        UIView.animateWithDuration(0.5, delay: 1.5, options: [], animations:
        {
            var img = self.weatherImg.frame
            img.origin.x += img.size.width + 400
            
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
//                annotation.title = "Lakeland, FL"
                self.mapView.addAnnotation(annotation)
//                let span = MKCoordinateSpanMake(Double(self.location!.lat)!, Double(self.location!.lng)!)
//                self.mapView.setRegion(MKCoordinateRegionMake(annotation.coordinate, span), animated: true)
                
                
                
                let annArr = [annotation]
                self.mapView.showAnnotations(annArr, animated: true)
                self.mapView.camera.altitude *= 1

//                var region: MKCoordinateRegion = self.mapView.region
//                var span: MKCoordinateSpan = self.mapView.region.span
//                
//                span.latitudeDelta *= span.latitudeDelta
//                span.longitudeDelta *= span.longitudeDelta
//                
//                region.span = span
//                
//                self.mapView.setRegion(region, animated: true)
                
            }
            
        })
        

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
