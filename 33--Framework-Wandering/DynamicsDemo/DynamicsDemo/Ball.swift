//
//  Ball.swift
//  DynamicsDemo
//
//  Created by david on 11/18/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

var borderWidth: CGFloat = 2
var borderAlpha: CGFloat = 1

class Ball: UIView
{
    var bgColor = UIColor.clearColor()
    var centerColor = UIColor.redColor()
    var borderColor = UIColor.whiteColor()
    var boundsCenter: CGPoint
    
    override init(frame: CGRect)
    {
        boundsCenter = CGPoint()
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder)
    {
        boundsCenter = CGPoint()
        super.init(coder: aDecoder)
        initialize()
    }

    func initialize()
    {
        boundsCenter = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect)
    {
        //face
        let cxt = UIGraphicsGetCurrentContext() //gets current canvas space
        CGContextAddEllipseInRect(cxt, rect) //rect being the current rectangle
        CGContextSetFillColorWithColor(cxt, bgColor.CGColor)
        CGContextFillPath(cxt)
        
        //border
        CGContextAddEllipseInRect(cxt, CGRect(x: rect.origin.x + borderWidth/2, y: rect.origin.y + borderWidth/2, width: rect.size.width - borderWidth, height: rect.size.height - borderWidth))
        CGContextSetStrokeColorWithColor(cxt, borderColor.CGColor)
        CGContextSetLineWidth(cxt, borderWidth)
        CGContextStrokePath(cxt)
    }
}
