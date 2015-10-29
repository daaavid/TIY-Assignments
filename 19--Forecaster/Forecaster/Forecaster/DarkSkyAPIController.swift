//
//  DarkSkyAPIController.swift
//  Forecaster
//
//  Created by david on 10/29/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class DarkSkyAPIController
{
    var darkSkyAPI: DarkSkyAPIControllerProtocol
    var task: NSURLSessionDataTask!
    
    init(delegate: DarkSkyAPIControllerProtocol)
    {
        self.darkSkyAPI = delegate
    }
    
    func search(lat: String, long: String)
    {
        let url = NSURL(string: "https://api.forecast.io/forecast/20e7ef512551da7f8d7ab6d2c9b4128c/\(lat), \(long)")
        let session = NSURLSession.sharedSession()
        task = session.dataTaskWithURL(url!, completionHandler: {data, reponse, error -> Void in
            if error != nil
            {
                print(error!.localizedDescription)
            }
            else
            {
                if let dictionary = self.parseJSON(data!)
                {
                    self.darkSkyAPI.darkSkySearchWasCompleted(dictionary)
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