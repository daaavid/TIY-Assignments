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
    let repos: Int
    let image: String
//    let imageURL: String
//    let largeImageURL: String
//    let itemURL: String
//    let artistURL: String
    
  //  init(name: String, price: String, thumbnailImageURL: String, largeImageURL: String, itemURL: String, artistURL: String)
    init(login: String, name: String, email: String, repos: Int, image: String)
    {
        self.username = login
        self.name = name
        self.email = email
        self.repos = repos
        self.image = image
    }
    
    static func friendsWithJSON(results: NSDictionary) -> [Friend]
    {
        //friends with jason
        var friends = [Friend]()
        
        if results.count > 0
        {
//            for result in results
//            {
            var login = results.valueForKey("login") as? String
            if login == nil
            {
                login = "Not Listed"
            }
            var name = results.valueForKey("name") as? String
            if name == nil
            {
                name = "Not Listed"
            }
            var email = results.valueForKey("email") as? String
            if email == nil
            {
                email = "Not Listed"
            }
            var repos = results.valueForKey("public_repos") as? Int
            if repos == nil
            {
                repos = 0
            }
            var image = results.valueForKey("avatar_url") as? String
            if image == nil
            {
                image = "Not Listed"
            }
            
                
            friends.append(Friend(login: login!, name: name!, email: email!, repos: repos!, image: image!))
            print(friends)
//                albums.append(Album(name: name!, price: price!, thumbnailImageURL: thumbnailURL, largeImageURL: imageURL, itemURL: itemURL!, artistURL: artistURL))
//            }
        }
        
        return friends
    }
    
    func unknown() -> String
    {
        return "unknown"
    }
}