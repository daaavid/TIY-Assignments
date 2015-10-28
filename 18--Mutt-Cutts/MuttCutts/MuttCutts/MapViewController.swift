//
//  ViewController.swift
//  MuttCutts
//
//  Created by david on 10/28/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol PopoverViewControllerDelegate
{
    func search(firstLocation: String, secondLocation: String)
}

class MapViewController: UIViewController, UIPopoverPresentationControllerDelegate, PopoverViewControllerDelegate, MKMapViewDelegate
{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    let geocoder = CLGeocoder()
    var annotations = [MKPointAnnotation]()
    var secondLocation = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        blurView.hidden = true
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "popover"
        {
            let popVC = segue.destinationViewController as! PopoverViewController
            popVC.popoverPresentationController?.delegate = self
            popVC.delegate = self
            
            popVC.preferredContentSize = CGSizeMake(200, 140)
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
    
    func search(firstLocation: String, secondLocation: String)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        annotations.removeAll()
        
        print(firstLocation); print(secondLocation)
        
        geocoderSearch(firstLocation)
        self.secondLocation = secondLocation
    }
    
    func geocoderSearch(location: String)
    {
        geocoder.geocodeAddressString(location, completionHandler: {(placemarks: [CLPlacemark]?,
            error: NSError?) -> Void in
            //go do this and run the code once you've found it
            if let placemark = placemarks?[0] //grab first in placemarks array
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark.location?.coordinate)!
                
                let cityAndState = location.componentsSeparatedByString(",")
            
                annotation.title = cityAndState[0]
                annotation.subtitle = cityAndState[1]
                
                self.annotations.append(annotation)
                print("geocoder closure \(self.annotations)")
                
                if self.annotations.count == 1
                {
                    self.geocoderSearch(self.secondLocation)
                }
                self.refresh()
            }
        })
        print("geocoder search \(annotations)")
    }
    
    func refresh()
    {
        
        if annotations.count == 2
        {
//            let firstLoc = annotations[0].coordinate
//            let secondLoc = annotations[1].coordinate

            let firstDist = CLLocation(coordinate: annotations[0].coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, timestamp: NSDate())
            let secondDist = CLLocation(coordinate: annotations[1].coordinate, altitude: 0, horizontalAccuracy: 0, verticalAccuracy: 0, timestamp: NSDate())
            
            let lineOfSightDistance = firstDist.distanceFromLocation(secondDist)
            print("distance between \(annotations[0].title!) and \(annotations[1].title!): " + String(format: "%.2f", lineOfSightDistance * 0.00062137) + " miles")
            blurView.hidden = false
            distanceLabel.text = ("The distance between \(annotations[0].title!),\(annotations[0].subtitle!) and \(annotations[1].title!),\(annotations[1].subtitle!) is " + String(format: "%.2f", lineOfSightDistance * 0.00062137) + " miles")
            
            
            mapView.addAnnotations(annotations)
            mapView.showAnnotations(annotations, animated: true)
            mapView.camera.altitude * 0.8
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
//    func mapView
    
    @IBAction func clearButton(sender: UIBarButtonItem)
    {
        mapView.removeAnnotations(annotations)
        blurView.hidden = true
        distanceLabel.text = ""
    }
    
//    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer
//    {
//        mapView.addOverlay(overlay)
//    }
    
}

