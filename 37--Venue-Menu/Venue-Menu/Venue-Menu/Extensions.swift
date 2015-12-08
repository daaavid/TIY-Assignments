//
//  Extensions.swift
//  Venue-Menu
//
//  Created by david on 11/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

extension UIImageView
{
    func downloadedFrom(var imageURL: String, contentMode: UIViewContentMode)
    {
        imageURL = imageURL.stringByReplacingOccurrencesOfString("\\", withString: "")
        var task = NSURLSessionDataTask()
        
        if let url = NSURL(string: imageURL)
        {
            task = NSURLSession.sharedSession().dataTaskWithURL(url,
                completionHandler: { (data, response, error) -> Void in
                
                    if data != nil
                    {
                        let image = UIImage(data: data!)
                        dispatch_async(dispatch_get_main_queue()) { () -> Void in
                            self.image = image
                            self.contentMode = contentMode
                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                            task.cancel()
                        }
                    }
                    else
                    {
                        print(error?.localizedDescription)
                    }
                    
            })
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            task.resume()
        }
        else
        {
            print("imageURL: \(imageURL) was invalid")
        }
    }
}

extension String
{
    func pigLatin(var string: String)
    {
        var characters = string.characters
        let firstChar = characters.first
        characters.removeFirst()
        
        string = ""
        for character in characters
        {
            string = string + String(character)
        }
        
        string = string + String(firstChar) + "ay"
    }
}

extension UIView
{
    func round()
    {
        let width = bounds.width < bounds.height ? bounds.width : bounds.height
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(ovalInRect: CGRectMake(bounds.midX - width / 2, bounds.midY - width / 2, width, width)).CGPath
        self.layer.mask = mask
    }
}

extension UIView
{
    //https://www.andrewcbancroft.com/2014/10/15/rotate-animation-in-swift/
    func spin(duration: CFTimeInterval = 0.3, completionDelegate: AnyObject? = nil)
    {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}
/*
extension UIImage
{
    var rounded: UIImage
    {
        let imageView = UIImageView(image: self)
        imageView.layer.cornerRadius = size.height < size.width ? size.height/2 : size.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    var circle: UIImage
    {
        let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
*/