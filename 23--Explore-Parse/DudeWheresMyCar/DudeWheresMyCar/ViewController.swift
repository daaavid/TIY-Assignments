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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var dropPinButton: UIBarButtonItem!
    
    @IBOutlet weak var dirButtonBlurView: UIVisualEffectView!
    @IBOutlet weak var showDirBlurView: UIVisualEffectView!
    @IBOutlet var dirDistanceLabel: UILabel!
    @IBOutlet var dirTimeLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    var pins = [Pin]()
    var parsePin = PFObject(className:"Pin")

    var location1 = MKPointAnnotation()
    var location2 = MKPointAnnotation()
    
    var login = false
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if login == false
        {
            let VC = self.storyboard?.instantiateViewControllerWithIdentifier("loginVC") as! LoginViewController
            //                    todoVC.account = account
            self.navigationController?.presentViewController(VC, animated: true, completion: nil)
            login = true
        }
//        self.mapView.camera.altitude *= 1.5

        mapView.delegate = self
//        dropPinButton.enabled = false
        configureLocationManager()
        
        dirButtonBlurView.hidden = true
        showDirBlurView.hidden = true
        
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
//        let parsePin = PFObject(className:"Pin")
        do
        {
            parsePin.ACL = PFACL(user: PFUser.currentUser()!)
            try parsePin.deleteInBackground()
        }
        catch
        {
            print("error")
        }
        
        pins.removeAll()
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        
        dropPinButton.enabled = true
        
        dirButtonBlurView.hidden = true
        showDirBlurView.hidden = true
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
            dirButtonBlurViewAnimated()
            
        default: print("error")
        }
    }
    
    func showLoadedPins()
    {
        let annotations = pinsToAnnotations()
        
        if pins.count == 2
        {
            dropPinButton.enabled = false
            
            dirButtonBlurViewAnimated()
        }
        
        mapView.removeAnnotations(mapView.annotations)
        
        self.mapView.showAnnotations(annotations, animated: true)
//        self.mapView.camera.altitude *= 1.5
    }
    
    func pinsToAnnotations() -> [MKPointAnnotation]
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
        return annotations
    }
    
    func dirButtonBlurViewAnimated()
    {
        if dirButtonBlurView.hidden == true
        {dirButtonBlurView.hidden = false}
    }
    
    @IBAction func showDirButton(sender: UIButton)
    {
        dirButtonBlurView.hidden = true
        showWalkingOverlay()
    }
    
    // MARK: - Directions
    
    func showWalkingOverlay()
    {
        let annotations = pinsToAnnotations()
        
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
                print("direction request success")
                
                for route in response!.routes
                {
                    self.mapView.addOverlay((route).polyline, level: MKOverlayLevel.AboveRoads)
                }
                
                let distance = response!.routes.first!.distance * 0.00062137
                let time = response!.routes.first!.expectedTravelTime
                self.showDirectionLabels(distance, time: time)
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
    
    func showDirectionLabels(distance: Double, time: Double)
    {
        showDirBlurView.hidden = false
        
        let formattedDistance = String(format: "%.2f", distance)
        let formattedTime = String(format: "%.2f" , (time / 60))
        
        dirDistanceLabel.text = "Distance: " + formattedDistance + " miles"
        dirTimeLabel.text = "ETA " + formattedTime + " minutes"
    }
    
    // MARK: - Save, Load
    
    func saveData()
    {
        print("saveData")
 
        for pin in pins
        {
//            let parsePin = PFObject(className:"Pin")
            parsePin["lat"] = pin.lat
            parsePin["lng"] = pin.lng
            parsePin["title"] = pin.name
            parsePin.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    print("saved ")
                } else {
                    print("save failed")
                }
            }
        }
    }
    
    func loadData()
    {
        print("loadData")
        
        let query = PFQuery(className:"Pin")
        query.findObjectsInBackgroundWithBlock {
            (results: [PFObject]?, error: NSError?) -> Void in
            if error == nil && results != nil {
                print("loaded ")
                
                self.pins.removeAll()
                for result in results!
                {
                    let lat = result["lat"] as! Double
                    let lng = result["lng"] as! Double
                    let name = result["title"] as! String

                    let pin = Pin(lat: lat, lng: lng, name: name)
                    
                    self.pins.append(pin)
                    print(self.pins)
                    self.showLoadedPins()
                }
                
            } else {
                print("load failed")
            }
        }
    }
}

