//
//  ViewController.swift
//  outaTime
//
//  Created by Ennui on 10/8/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

@objc protocol DatePickerDelegate
{
    func dateWasChosen(destDate: NSDate)
}

class TimeCircuitsViewController: UIViewController, DatePickerDelegate
{
    @IBOutlet var destTime: UILabel!
    @IBOutlet var presTime: UILabel!
    @IBOutlet var lastTimeDep: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var travBack: UIButton!
    
    var currentSpeed = 0
    var accelerate: NSTimer?
    var destTimeDashes = "--- -- ----"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //findPresTime()
        presTime.text = formatTime(NSDate())
        destTime.text = destTimeDashes
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowDatePickerSegue"
        {
            //storing string that connects to balloon
            let datePickerVC = segue.destinationViewController as! DatePickerViewController //view controller that this segue points at. in this case, the datepickerviewcontroller
            
            datePickerVC.delegate = self
            //self is referring to the timecircuitcontroller object
            //at the top, we declared that we were the datepickerviewcontroller delegate
        }
    }
    
//MARK: - delegate
    
    func dateWasChosen(destDate: NSDate)
    {
//        destTime.text = "\(destDate)"
        destTime.text = formatTime(destDate)
    }
        
//MARK: - THE ACTION HANDLERS
        //coming soon to a theater near you
    
    @IBAction func travBackTapped(sender: UIButton)
    {
        startSpeed()
    }

//MARK: - private
//  func findPresTime()
    func formatTime(timeToFormat: NSDate) -> String
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMM dd YYYY", options: 0, locale: NSLocale(localeIdentifier: "en-US"))
//        presTime.text = formatter.stringFromDate(NSDate()).uppercaseString
        let formattedTime = formatter.stringFromDate(timeToFormat).uppercaseString
        return String(formattedTime)
    }
    
    func startSpeed()
    {
        if accelerate == nil
        {
            accelerate = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: "updateSpeed", userInfo: nil, repeats: true)
            travBack.setTitle("SPEED NOT REACHED", forState: UIControlState.Normal)
        }
        else
        {
            stopSpeed()
        }
    }
    
    func stopSpeed()
    {
        accelerate?.invalidate()
        accelerate = nil
        
        travBack.setTitle("TRAVELING BACK (TO THE FUTURE)", forState: UIControlState.Normal)
        
        lastTimeDep.text = formatTime(NSDate())
        speedLabel.text = "0 MPH"

    }
    
    func updateSpeed()
    {
//        let newSpeed = Int(speedLabel.text!)! + 1
        let newSpeed = currentSpeed + 1
        currentSpeed = newSpeed
        speedLabel.text = ("\(currentSpeed) MPH")
        if newSpeed == 88
        {
            view.backgroundColor = UIColor.blackColor()
            stopSpeed()
            presTime.text = destTime.text
        }
    }
}

