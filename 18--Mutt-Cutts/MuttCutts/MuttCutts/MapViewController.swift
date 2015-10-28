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
    var distance: CLLocationDistance?
    var annotations = [MKPointAnnotation]()
    var secondLocation = ""
    var mapRoute: MKRoute?
    
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
            
            popVC.preferredContentSize = CGSizeMake(200, 100)
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
        geocoder.geocodeAddressString(location, completionHandler:
        {
            (placemarks: [CLPlacemark]?, error: NSError?) -> Void in
            //go do this and run the code once you've found it
            if let placemark = placemarks?[0] //grab first in placemarks array
            {
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark.location?.coordinate)!
                annotation.title = location
                
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
//            let lineOfSightDistance = firstDist.distanceFromLocation(secondDist)
            mapView.addAnnotations(annotations)
            mapView.showAnnotations(annotations, animated: true)
            mapView.camera.altitude * 0.8
            route()
        }
    }

    func route()
    {
        //http://studyswift.blogspot.com/2014/10/mkdirections-draw-route-from-location.html
        
        let plot = MKDirectionsRequest()
        
        plot.source = MKMapItem(placemark: MKPlacemark(coordinate: annotations[0].coordinate, addressDictionary: nil))
        plot.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotations[1].coordinate, addressDictionary: nil))
        plot.transportType = .Automobile
        
        let route = MKDirections(request: plot)
        
        route.calculateDirectionsWithCompletionHandler
        {
            (response: MKDirectionsResponse?, error: NSError?) -> Void in
            
            if error == nil
            {
                self.distance = response!.routes.first?.distance
                
                self.mapRoute = response!.routes[0]
                self.mapView.addOverlay((self.mapRoute?.polyline)!)
                
                self.annotations[0].subtitle = "Origin"
                self.annotations[1].subtitle = "Destination"
                
                self.setDistLabel()
            }
            else if error != nil
            {
                print(error)
            }

        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer
    {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.redColor()
        renderer.lineWidth = 3
        return renderer
    }
    
    func setDistLabel()
    {
        distanceLabel.text = ("The distance between \(annotations[0].title!) and \(annotations[1].title!) is " + String(format: "%.2f", distance! * 0.00062137) + " miles")
        blurView.hidden = false
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    @IBAction func clearButton(sender: UIBarButtonItem)
    {
        mapView.removeAnnotations(annotations)
        mapRoute = nil
        blurView.hidden = true
        distanceLabel.text = ""
    }
    
}

