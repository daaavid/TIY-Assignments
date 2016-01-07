//
//  LocationManager.swift
//  Venue-Menu
//
//  Created by david on 11/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate
{
    var delegate: LocationManagerProtocol?
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    func configureLocationManager()
    {
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Denied && CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Restricted
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined
            {
                locationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse
        {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print(error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last //last location in array

        geocoder.reverseGeocodeLocation(location!, completionHandler:
            {(placemark: [CLPlacemark]?, error: NSError?) -> Void in
            
            if error == nil
            {
                self.locationManager.stopUpdatingLocation()
                
                let lat = location?.coordinate.latitude
                let lng = location?.coordinate.longitude
                
                let city = placemark?[0].locality
                let zip = placemark?[0].postalCode
                
                let foundLocation = Location.init(city: city!, zip: zip!, lat: lat!, lng: lng!)
                print("location was found")
                
                if let _ = self.delegate
                {
                    self.delegate!.locationWasFound(foundLocation)
                }
            }
            else
            {
                print(error?.localizedDescription)
            }
        })
    }
}