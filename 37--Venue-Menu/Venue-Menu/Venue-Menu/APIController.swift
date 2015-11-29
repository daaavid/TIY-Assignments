//
//  APIController.swift
//  Venue-Menu
//
//  Created by david on 11/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class APIController
{
    var delegate: APIControllerProtocol
    var task: NSURLSessionDataTask!
    
    init(delegate: APIControllerProtocol)
    {
        self.delegate = delegate
    }

    func search(term: String, location: Location, searchOption: String)
    {
        print("api search")
        
        let client_id = "3CTEMHPNFURJSSCYEJTXIBDWG4UKD30NTL0QNPKMB331L2T0"
        let client_secret = "EQSMTQTYTWUUGI5SKE5UA3OCYHL2C3HJJC20ZTY1OEHC4ABM"
        let baseURL = "https://api.foursquare.com/v2/venues/\(searchOption)?client_id=\(client_id)&client_secret=\(client_secret)&v=20130815%20"
        let locationAndTerm = "&ll=\(location.lat),\(location.lng)&query=\(term)"

        let urlString = baseURL + locationAndTerm
        
        let url = NSURL(string: urlString)
        print(url)
        
        let session = NSURLSession.sharedSession()
        task = session.dataTaskWithURL(url!,
            completionHandler: { data, response, error -> Void in
                print("task")
                if error == nil
                {
                    if let results = self.parseJSON(data!)
                    {
//                        print(results)
                        let response = results["response"] as! NSDictionary
                        let venues = response["venues"] as! [NSDictionary]
                        self.delegate.venuesWereFound(venues)
//                        print(venues)
//                        self.task.cancel()
                    }
                }
                else
                {
                    print(error?.localizedDescription)
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