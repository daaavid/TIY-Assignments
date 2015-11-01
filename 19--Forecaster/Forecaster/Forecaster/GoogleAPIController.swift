//
//  GoogleZipAPIController.swift
//  Forecaster
//
//  Created by david on 10/29/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class GoogleZipAPIController
{
    var googleAPI: GoogleZipAPIControllerProtocol
    var task: NSURLSessionDataTask!
    
    init(delegate: GoogleZipAPIControllerProtocol)
    {
        self.googleAPI = delegate
    }
    
    func search(zipCode: String)
    {
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=santa+cruz&components=postal_code:\(zipCode)&sensor=false")
        let session = NSURLSession.sharedSession()
        task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            print("Task completed")
            if error != nil
            {
                print(error!.localizedDescription)
            }
            else
            {
                if let results = self.parseJSON(data!)
                {
                    if let results: NSArray = results["results"] as? NSArray
                    {
                        self.googleAPI.googleSearchWasCompleted(results)
//                        if let dictionary = results[0] as? NSDictionary
//                        {
//                            self.googleAPI.googleSearchWasCompleted(dictionary)
//                        }
                    }
                }
            }
        })
        task.resume()
    }
    
    func parseJSON(data: NSData) -> NSDictionary?
    {
        do
        {
            let dictionary: NSDictionary! = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
            print("parseJSON")
            
            return dictionary
        }
        catch let error as NSError
        {
            print(error)
            return nil
        }
    }
    
    func cancelSearch()
    {
        task.cancel()
    }


}