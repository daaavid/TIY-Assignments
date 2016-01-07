//
//  Extensions.swift
//  ExtensionTest
//
//  Created by david on 12/1/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func appearWithFade(duration: Double)
    {
        self.alpha = 0
        UIView.animateWithDuration(duration) { () -> Void in
            self.alpha = 1
        }
    }
    
    func hideWithFade(duration: Double)
    {
        self.alpha = 1
        UIView.animateWithDuration(duration) { () -> Void in
            self.alpha = 0
        }
    }
    
    func slideHorizontally(duration: Double, fromPointX: CGFloat)
    {
        let originalX = self.frame.origin.x
        self.frame.origin.x += fromPointX
        UIView.animateWithDuration(duration) { () -> Void in
            self.frame.origin.x = originalX
        }
    }
    
    func slideVertically(duration: Double, fromPointY: CGFloat)
    {
        let originalY = self.frame.origin.y
        self.frame.origin.y += fromPointY
        UIView.animateWithDuration(duration) { () -> Void in
            self.frame.origin.y = originalY
        }
    }
}

extension UIImageView
{
    func downloadImgFrom(imageURL imageURL: String, contentMode: UIViewContentMode)
    {
        if let url = NSURL(string: imageURL)
        {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url,
                completionHandler: { (data, response, error) -> Void in
                    if data != nil
                    {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let image = UIImage(data: data!)
                            self.image = image
                            self.contentMode = contentMode
                        })
                    }
            })
            
            task.resume()
        }
        else
        {
            print("url \(imageURL) was invalid")
        }
    }
}