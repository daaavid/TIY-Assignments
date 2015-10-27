//
//  Friend.swift
//  Github-Friends
//
//  Created by david on 10/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

struct Friend
{
    let username: String
    let name: String
    let email: String
//    let imageURL: String
//    let largeImageURL: String
//    let itemURL: String
//    let artistURL: String
    
  //  init(name: String, price: String, thumbnailImageURL: String, largeImageURL: String, itemURL: String, artistURL: String)
    init(login: String, name: String, email: String)
    {
        self.username = login
        self.name = name
        self.email = email
    }
    
    static func albumsWithJSON(results: NSArray) -> [Friend]
    {
        var friends = [Friend]()
        
        if results.count > 0
        {
            for result in results
            {
                var login = result["login"] as? String
                if login == nil
                {
                    login = ""
                }
                var name = result["name"] as? String
                if name == nil
                {
                    name = ""
                }
                var email = result["email"] as? String
                if email == nil
                {
                    email = ""
                }
                
                friends.append(Friend(login: login!, name: name!, email: email!))
//                albums.append(Album(name: name!, price: price!, thumbnailImageURL: thumbnailURL, largeImageURL: imageURL, itemURL: itemURL!, artistURL: artistURL))
            }
        }
        
        return friends
    }
    
    func unknown() -> String
    {
        return "unknown"
    }
}