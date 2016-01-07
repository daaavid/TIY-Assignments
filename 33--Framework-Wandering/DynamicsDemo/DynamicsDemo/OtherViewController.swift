//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by david on 11/18/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import CoreMotion

class OtherViewController: UIViewController, UICollisionBehaviorDelegate
{
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collison: UICollisionBehavior!
    var frame = CGRect(x: 0, y: 0, width: 60, height: 60)
    
    var firstContact = true
    
    var square: UIView!
    var snap: UISnapBehavior!
    
    var ball: Ball!
    
    var motionManager: CMMotionManager!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        ball = Ball(frame: frame)
        view.addSubview(ball)
        
        animator = UIDynamicAnimator(referenceView: view) //this view controller
        gravity = UIGravityBehavior(items: [ball]) //looking for an array of items (views)
        gravity.magnitude = 1.5
        animator.addBehavior(gravity)
        
        collison = UICollisionBehavior(items: [ball])
        frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        collison.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collison)
        
        collison.collisionDelegate = self
        
        let itemBehavior = UIDynamicItemBehavior(items: [ball])
        itemBehavior.elasticity = 0.8
        itemBehavior.friction = 0.1
        animator.addBehavior(itemBehavior)
        
        //density
        //friction
        //resistance to movement
        //angular resistance harder to spin
        //allowsrotation
        
        addBarrier([0,100,180,20])
        addBarrier([260,100,180,20])
        addBarrier([80,200,250,20])
        addBarrier([0,300,180,20])
        addBarrier([260,300,180,20])
        addBarrier([80,400,600,20])
        addBarrier([0,500,300,20])
        
        startMotionDetection()
    }
    
    func startMotionDetection()
    {
        let interval = 1.0
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = interval
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue()) {
//                            (data: CMAccelerometerData?, error: NSError?) in
                            (motion: CMDeviceMotion?, error: NSError?) in
            if motion != nil
            {
                let x = CGFloat(motion!.gravity.x)
                let y = CGFloat(motion!.gravity.y) * -1
                self.gravity.gravityDirection = CGVectorMake(x, y)
            }
            else
            {
                print(error?.localizedDescription)
            }
        }
    }
    
    func addBarrier(frame: [Int])
    {
        let barrierframe = CGRect(x: frame[0], y: frame[1], width: frame[2], height: frame[3])
        let barrier = UIView(frame: barrierframe)
        barrier.backgroundColor = UIColor.whiteColor()
        view.addSubview(barrier)
        
        //        collison.addItem(barrier)
        let path = UIBezierPath(rect: barrier.frame)
        collison.addBoundaryWithIdentifier("barrier", forPath: path)
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint)
    {
        print("boundary contact occured " + "\(identifier)")
        
        let collidingView = item as! Ball
        collidingView.borderColor = UIColor.yellowColor()
        collidingView.alpha = 0.2
        
        UIView.animateWithDuration(0.5)
        {
            collidingView.borderColor = UIColor.blackColor()
            collidingView.alpha = 1
        }
        
//        if firstContact
//        {
//            firstContact = !firstContact
//            frame = CGRect(x: 30, y: 0, width: 100, height: 100)
//            let square = UIView(frame: frame)
//            square.backgroundColor = UIColor.magentaColor()
//            view.addSubview(square)
//            
//            collison.addItem(square)
//            gravity.addItem(square)
//            
//            let attach = UIAttachmentBehavior(item: collidingView, attachedToItem: square)
//            animator.addBehavior(attach)
//            
//            let itemBehavior = UIDynamicItemBehavior(items: [square])
//            itemBehavior.elasticity = 2
//            animator.addBehavior(itemBehavior)
//        }
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
//    {
//        if snap != nil
//        {
//            animator.removeBehavior(snap)
//        }
//        
//        let touch = touches.first!
//        snap = UISnapBehavior(item: square, snapToPoint: touch.locationInView(view))
//        animator.addBehavior(snap)
//    }
    
//    func milliondollarman()
//    {
//        var updateCount = 0
//        collison.action =
//        {
//            if updateCount % 6 == 0
//            {
//                let outline = UIView(frame: square.bounds)
//                outline.transform = square.transform
//                outline.center = square.center
//                outline.alpha = 0.5
//                outline.backgroundColor = UIColor.clearColor()
//                outline.layer.borderColor = square.layer.presentationLayer()?.backgroundColor
//                outline.layer.borderWidth = 1.0
//                self.view.addSubview(outline)
//            }
//            
//            ++updateCount
//        }
//    }
}

