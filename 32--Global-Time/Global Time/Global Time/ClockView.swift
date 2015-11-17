//
//  ClockView.swift
//  Clock
//
//  Created by david on 11/17/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

let borderWidth: CGFloat = 2
let borderAlpha: CGFloat = 1
let digitOffset: CGFloat = 10

@IBDesignable
class ClockView: UIView
{
    var animationTimer: CADisplayLink? //core animation display link
    //timer object that allows your application to synchronize its drawing to the refresh rate of the display
    var timezone: NSTimeZone?
    {
        didSet //anytime timezone has been set (also can willSet)
        {
            animationTimer = CADisplayLink(target: self, selector: "timerFired:")
            animationTimer!.frameInterval = 8 //8 frame interval. how many frames before this will fire again
            let currentLoop = NSRunLoop.currentRunLoop()
            animationTimer!.addToRunLoop(currentLoop, forMode: NSRunLoopCommonModes)
        }
    }
    
    var time: NSDate?
    var seconds = 0
    var minutes = 0
    var hours = 0
    
    var boundsCenter: CGPoint
    let clockBGColor = UIColor.blackColor()
    let borderColor = UIColor.whiteColor()
    let digitColor = UIColor.whiteColor()
    
    var digitFont: UIFont
    
    override init(frame: CGRect)
    {
        digitFont = UIFont()
        boundsCenter = CGPoint()
        
        super.init(frame: frame)
        
        let fontSize = 8 + frame.size.width/50
        digitFont = UIFont.systemFontOfSize(fontSize)
        boundsCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        digitFont = UIFont()
        boundsCenter = CGPoint()
        
        super.init(coder: aDecoder)
        
        let fontSize = 8 + frame.size.width/50
        digitFont = UIFont.systemFontOfSize(fontSize)
        boundsCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect)
    {
        //clock face
        let cxt = UIGraphicsGetCurrentContext() //gets current canvas space
        CGContextAddEllipseInRect(cxt, rect) //rect being the current rectangle
        CGContextSetFillColorWithColor(cxt, clockBGColor.CGColor)
        CGContextFillPath(cxt)
        
        //clock center
        var radius: CGFloat = 6
        let center2 = CGRect(x: boundsCenter.x - radius, y: boundsCenter.y - radius, width: radius * 2, height: radius * 2)
        CGContextAddEllipseInRect(cxt, center2)
        CGContextSetFillColorWithColor(cxt, digitColor.CGColor)
        CGContextFillPath(cxt)
        
        //clock border
        CGContextAddEllipseInRect(cxt, CGRect(x: rect.origin.x + borderWidth/2, y: rect.origin.y + borderWidth/2, width: rect.size.width - borderWidth, height: rect.size.height - borderWidth))
        CGContextSetStrokeColorWithColor(cxt, borderColor.CGColor)
        CGContextSetLineWidth(cxt, borderWidth)
        CGContextStrokePath(cxt)
        
        //numerals
        let center = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
        let markingDistanceFromCenter = rect.size.width / 2.0 - digitFont.lineHeight / 4.0 - 15 + digitOffset
        let offset = 4
        
        for digit in 0..<12
        {
            let hourString: String
            if digit + 1 < 10
            {
                hourString = " " + String(digit + 1)
            }
            else
            {
                hourString = String(digit + 1)
            }
            let labelX = center.x + (markingDistanceFromCenter - digitFont.lineHeight / 2.0) * CGFloat(cos((M_PI / 180) * Double(digit + offset) * 30 + M_PI))
            let labelY = center.y - 1 * (markingDistanceFromCenter - digitFont.lineHeight / 2.0) * CGFloat(sin((M_PI / 180) * Double(digit + offset) * 30))
            hourString.drawInRect(CGRect(x: labelX - digitFont.lineHeight / 2.0, y: labelY - digitFont.lineHeight / 2.0, width: digitFont.lineHeight, height: digitFont.lineHeight), withAttributes: [NSForegroundColorAttributeName: digitColor, NSFontAttributeName: digitFont])
        }
        
        //minute hand 
        let minHandPos = minutesHandPosition()
        CGContextSetStrokeColorWithColor(cxt, digitColor.CGColor)
        CGContextBeginPath(cxt)
        CGContextMoveToPoint(cxt, boundsCenter.x, boundsCenter.y)
        CGContextSetLineWidth(cxt, 4.0)
        CGContextAddLineToPoint(cxt, minHandPos.x, minHandPos.y)
        CGContextStrokePath(cxt)
        
        //hour hand
        let hourHandPos = hoursHandPosition()
        CGContextSetStrokeColorWithColor(cxt, digitColor.CGColor)
        CGContextBeginPath(cxt)
        CGContextMoveToPoint(cxt, boundsCenter.x, boundsCenter.y)
        CGContextSetLineWidth(cxt, 4.0)
        CGContextAddLineToPoint(cxt, hourHandPos.x, hourHandPos.y)
        CGContextStrokePath(cxt)
        
        //second hand
        let secHandPos = secondsHandPosition()
        CGContextSetStrokeColorWithColor(cxt, UIColor.redColor().CGColor)
        CGContextBeginPath(cxt)
        CGContextMoveToPoint(cxt, boundsCenter.x, boundsCenter.y)
        CGContextSetLineWidth(cxt, 1.0)
        CGContextAddLineToPoint(cxt, secHandPos.x, secHandPos.y)
        CGContextStrokePath(cxt)
        
        //second hand center
        radius = 3
        let center3 = CGRect(x: boundsCenter.x - radius, y: boundsCenter.y - radius, width: radius * 2, height: radius * 2)
        CGContextAddEllipseInRect(cxt, center3)
        CGContextSetFillColorWithColor(cxt, UIColor.redColor().CGColor)
        CGContextFillPath(cxt)
        
    }
    
    func hoursHandPosition() -> CGPoint
    {
        let hoursAsRadians = Float(Double(hours) / 60 * 2 * M_PI - M_PI_2)
        let handRadius = CGFloat(frame.size.width / 4.2)
        return CGPoint(x: handRadius * CGFloat(cosf(hoursAsRadians)) + boundsCenter.x, y: handRadius * CGFloat(sinf(hoursAsRadians)) + boundsCenter.y)
    }
    
    func minutesHandPosition() -> CGPoint
    {
        let minutesAsRadians = Float(Double(minutes) / 60 * 2 * M_PI - M_PI_2)
        let handRadius = CGFloat(frame.size.width / 3.6)
        return CGPoint(x: handRadius * CGFloat(cosf(minutesAsRadians)) + boundsCenter.x, y: handRadius * CGFloat(sinf(minutesAsRadians)) + boundsCenter.y)
    }

    func secondsHandPosition() -> CGPoint
    {
        let secondsAsRadians = Float(Double(seconds) / 60 * 2 * M_PI - M_PI_2)
        let handRadius = CGFloat(frame.size.width / 3.2)
        return CGPoint(x: handRadius * CGFloat(cosf(secondsAsRadians)) + boundsCenter.x, y: handRadius * CGFloat(sinf(secondsAsRadians)) + boundsCenter.y)
    }
    
    func timerFired(sender: AnyObject)
    {
        time = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        calendar.timeZone = self.timezone!
        let timeComponents = calendar.components([.Hour, .Minute, .Second], fromDate: time!)
        
        hours = timeComponents.hour
        minutes = timeComponents.minute
        seconds = timeComponents.second
        
        setNeedsDisplay() //reload view data
    }
}
