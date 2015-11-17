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
let digitOffset: CGFloat = 16

@IBDesignable
class ClockView: UIView
{
    var animationTimer: CADisplayLink? //core animation display link
    //timer object that allows your application to synchronize its drawing to the refresh rate of the display
    var clockBGColor = UIColor.whiteColor()
    var borderColor = UIColor.blackColor()
    var digitColor = UIColor.blackColor()
    
    var colorHasNotBeenSet = true
    
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
        var radius: CGFloat = 6.0
        let center2 = CGRect(x: boundsCenter.x - radius, y: boundsCenter.y - radius, width: 2 * radius, height: 2 * radius)
        CGContextAddEllipseInRect(cxt, center2)
        CGContextSetFillColorWithColor(cxt, digitColor.CGColor)
        CGContextFillPath(cxt)
        
        //clock border
        CGContextAddEllipseInRect(cxt, CGRect(x: rect.origin.x + borderWidth/2, y: rect.origin.y + borderWidth/2, width: rect.size.width - borderWidth, height: rect.size.height - borderWidth))
        CGContextSetStrokeColorWithColor(cxt, borderColor.CGColor)
        CGContextSetLineWidth(cxt, borderWidth)
        CGContextStrokePath(cxt)
        
        //numerals
        let center = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
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
        
        
        //second hand
        let secHandPos = secondsHandPosition()
        CGContextSetStrokeColorWithColor(cxt, UIColor.redColor().CGColor)
        CGContextBeginPath(cxt)
        CGContextMoveToPoint(cxt, boundsCenter.x, boundsCenter.y)
        CGContextSetLineWidth(cxt, 1.0)
        CGContextAddLineToPoint(cxt, secHandPos.x, secHandPos.y)
        CGContextStrokePath(cxt)
        
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
        
        // second hand's center
        radius = 3.0
        let center3 = CGRect(x: boundsCenter.x - radius, y: boundsCenter.y - radius, width: 2 * radius, height: 2 * radius)
        CGContextAddEllipseInRect(cxt, center3)
        CGContextSetFillColorWithColor(cxt, UIColor.redColor().CGColor)
        CGContextFillPath(cxt)
        
    }
    
    func secondsHandPosition() -> CGPoint
    {
        let secondsAsRadians = Float(Double(seconds) / 60.0 * 2.0 * M_PI - M_PI_2)
        let handRadius = CGFloat(frame.size.width / 3.2)
        return CGPoint(x: handRadius*CGFloat(cosf(secondsAsRadians)) + boundsCenter.x, y: handRadius*CGFloat(sinf(secondsAsRadians)) + boundsCenter.y)
    }
    
    func minutesHandPosition() -> CGPoint
    {
        let minutesAsRadians = Float(Double(minutes) / 60.0 * 2.0 * M_PI - M_PI_2)
        let handRadius = CGFloat(frame.size.width / 3.6)
        return CGPoint(x: handRadius*CGFloat(cosf(minutesAsRadians)) + boundsCenter.x, y: handRadius*CGFloat(sinf(minutesAsRadians)) + boundsCenter.y)
    }
    
    func hoursHandPosition() -> CGPoint
    {
        let halfClock = Double(hours) + Double(minutes) / 60.0
        let hoursAsRadians = Float(halfClock / 12.0 * 2.0 * M_PI - M_PI_2)
        let handRadius = CGFloat(frame.size.width / 4.2)
        return CGPoint(x: handRadius*CGFloat(cosf(hoursAsRadians)) + boundsCenter.x, y: handRadius*CGFloat(sinf(hoursAsRadians)) + boundsCenter.y)
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
        
        if colorHasNotBeenSet
        {
            setBGColors()
            colorHasNotBeenSet = false
        }
        
        setNeedsDisplay() //reload view data
    }
        
    func setBGColors()
    {
        print("color set.")
        let day = isDay(hours)
        if !day
        {
            clockBGColor = UIColor.blackColor()
            borderColor = UIColor.whiteColor()
            digitColor = UIColor.whiteColor()
        }
    }
    
    func isDay(hour: Int) -> Bool
    {
        var isDay: Bool
        print(hour)
        switch hour
        {
        case 5...19:
            isDay = true
        default:
            isDay = false
        }
        return isDay
    }
}
