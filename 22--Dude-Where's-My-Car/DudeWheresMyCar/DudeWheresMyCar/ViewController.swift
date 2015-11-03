//
//  ViewController.swift
//  DudeWheresMyCar
//
//  Created by david on 11/3/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//let kLocation1Key = "loc1"
//let kLocation2Key = "loc2"

let kPinsKey = "locs"

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var dropPinButton: UIBarButtonItem!
    @IBOutlet weak var showDirView: UIVisualEffectView!
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var pins = [Pin]()
    var location1 = MKPointAnnotation()
    var location2 = MKPointAnnotation()
    
    var hidden = true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        mapView.delegate = self
//        dropPinButton.enabled = false
        configureLocationManager()
        
        showDirView.hidden = true
        
        if pins.count > 0
        {
            showLoadedPins()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureLocationManager()
    {
        let locAuthStatus = CLLocationManager.authorizationStatus()
        
        if locAuthStatus != CLAuthorizationStatus.Denied && locAuthStatus != CLAuthorizationStatus.Restricted
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            
            if locAuthStatus == CLAuthorizationStatus.NotDetermined
            {
                locationManager.requestWhenInUseAuthorization()
            }
            else
            {
                dropPinButton.enabled = true
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print(error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        geocoder.reverseGeocodeLocation(location!, completionHandler: {(placemark: [CLPlacemark]?, error: NSError?) -> Void in
            
            if error != nil
            {
                print(error?.localizedDescription)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            else
            {
                self.locationManager.stopUpdatingLocation()
            
                print("reverse geocode success")
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                self.updateMapView(placemark!)
            }
            
        })
    }
    
    @IBAction func dropPinButton(sender: UIBarButtonItem)
    {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func clearPinButton(sender: UIBarButtonItem)
    {
        print("cleared")
        pins.removeAll()
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        dropPinButton.enabled = true
        
        showDirView.hidden = true
    }
    
    func updateMapView(placemarks: [CLPlacemark])
    {
        switch pins.count
        {
        case 0:
            location1.coordinate = placemarks[0].location!.coordinate
            location1.title = "Car"
            
            let pin = Pin(lat: location1.coordinate.latitude, lng: location1.coordinate.longitude, name: location1.title!)
            pins.append(pin)
            
            showLoadedPins()
            
        case 1:
            location2.coordinate = placemarks[0].location!.coordinate
            location2.title = "You"
            
            let pin = Pin(lat: location2.coordinate.latitude, lng: location2.coordinate.longitude, name: location2.title!)
            pins.append(pin)
            
            showLoadedPins()
            showDirViewAnimated()
            
        default: print("error")
        }
    }
    
    func saveData()
    {
        print("saveCityData")
        print("saved ")
        let locationData = NSKeyedArchiver.archivedDataWithRootObject(pins) ; print(pins)
        NSUserDefaults.standardUserDefaults().setObject(locationData, forKey: kPinsKey)
    }
    
    func loadData() -> Bool
    {
        print("loadCityData")
        print("loaded ")
        
        var rc = true
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(kPinsKey) as? NSData
        {
            if let savedPins = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [Pin]
            {
                pins = savedPins ; print(pins)
                rc = false

//                 self.reloadData()
            }
        }
        return rc
    }
    
    func showLoadedPins()
    {
        var annotations = [MKPointAnnotation]()
        
        for pin in pins
        {
            let annotation = MKPointAnnotation()
            annotation.coordinate.longitude = pin.lng
            annotation.coordinate.latitude = pin.lat
            annotation.title = pin.name
            
            print(pin.name, pin.lng, pin.lat, "was loaded")
            
            annotations.append(annotation)
        }
        
        if pins.count == 2
        {
            dropPinButton.enabled = false
            
            showDirViewAnimated()
        }
        
        mapView.removeAnnotations(mapView.annotations)
        self.mapView.showAnnotations(annotations, animated: true)
    }
    
    func showDirViewAnimated()
    {
        if showDirView.hidden == true
        {
            showDirView.hidden = false
//            UIView.animateWithDuration(0.5, animations:
//            {
//                var frame = self.showDirView.frame
//                frame.origin.y = 600
//                
//                self.showDirView.frame = frame
//            })
        }
//        else
//        {
//            UIView.animateWithDuration(0.5, animations:
//                {
//                    var frame = self.showDirView.frame
//                    frame.origin.y += frame.size.height
//                    
//                    self.showDirView.frame = frame
//            })
//        }
    }
    
    @IBAction func showDirButton(sender: UIButton)
    {
        showDirView.hidden = true
        showWalkingOverlay()
    }
    
    func showWalkingOverlay()
    {
        var annotations = [MKPointAnnotation]()

        for pin in pins
        {
            let annotation = MKPointAnnotation()
            annotation.coordinate.longitude = pin.lng
            annotation.coordinate.latitude = pin.lat
            annotation.title = pin.name
            
            print(pin.name, pin.lng, pin.lat)
            
            annotations.append(annotation)
        }
        
        let youPlacemark = MKPlacemark(coordinate: annotations[0].coordinate, addressDictionary: nil)
        let carPlacemark = MKPlacemark(coordinate: annotations[1].coordinate, addressDictionary: nil)
        
        let you = MKMapItem(placemark: youPlacemark)
        let car = MKMapItem(placemark: carPlacemark)
        
        let dirReq = MKDirectionsRequest()
        dirReq.transportType = MKDirectionsTransportType.Walking
        dirReq.source = you
        dirReq.destination = car
        
        let directions = MKDirections(request: dirReq)
        
        directions.calculateDirectionsWithCompletionHandler { (response: MKDirectionsResponse?, error: NSError?) -> Void in
            
            if error != nil
            {
                print(error?.localizedDescription)
            }
            else
            {
                print("direction request succes")
                for route in response!.routes
                {
                    self.mapView.addOverlay((route).polyline, level: MKOverlayLevel.AboveRoads)
                }
            }
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer
    {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.redColor()
        renderer.lineWidth = 3.0
        return renderer
    }
}

