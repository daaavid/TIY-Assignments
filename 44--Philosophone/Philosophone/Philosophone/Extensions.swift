//
//  Extensions.swift
//  Philosophone
//
//  Created by david on 12/4/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func spin()
    {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = 0.3
        
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
    
    func appearWithFade(duration: Double)
    {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.alpha = 0
            UIView.animateWithDuration(duration) { () -> Void in
                self.alpha = 1
            }
        }
    }
}

extension UILabel
{
    func typeText(quote: String, delegate: TypedCharacterTextDelegate?)
    {
        if self.text != ""
        {
            self.text = ""
        }
        
        let global_queue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
        
        dispatch_async(global_queue) { () -> Void in
            
            for character in quote.characters
            {
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.text = self.text! + String(character)
                }
                
                NSThread.sleepForTimeInterval(0.025)
            }
            
            delegate?.quoteFinishedTyping()
            
        }
    }
}