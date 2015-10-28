//
//  File.swift
//  Github-Friends
//
//  Created by david on 10/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class APIController
{
    var delegate: APIControllerProtocol
    
    init(delegate: APIControllerProtocol)
    {
        self.delegate = delegate
    }
    
    func searchGithubFor(searchTerm: String)
    {
        let githubSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        if let username = githubSearchTerm.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())
        {
            print(username)

            let url = NSURL(string: "https://api.github.com/users/\(username)")
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
                print("Task completed")
                if error != nil
                {
                    print(error!.localizedDescription)
                }
                else
                {
                    if let dictionary = self.parseJSON(data!)
                    {
                        self.delegate.didReceiveAPIResults(dictionary)
//                        if let results: NSArray = dictionary/*["results"]*/ as? NSArray
//                        if let results: NSArray = dictionary[""] as? NSArray
//                        {
//                            self.delegate.didReceiveAPIResults(results)
//                        }
//                        if let results: NSArray = dictionary as? NSArray
//                        {
//                            self.delegate.didReceiveAPIResults(results)
//                        }
                    }
                }
            })
            task.resume()
        }
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
    
    
    
}