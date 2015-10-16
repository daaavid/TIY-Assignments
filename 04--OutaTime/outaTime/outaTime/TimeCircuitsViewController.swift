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

class TimeCircuitsViewController: UIViewController, DatePickerDelegate //we agree to fulfill any conditions in the function that are non-optional. must implement datewaschosen func
{
    @IBOutlet var destTime: UILabel!
    @IBOutlet var presTime: UILabel!
    @IBOutlet var lastTimeDep: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var travBack: UIButton!
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var setDestTime: UIButton!
    
    var baseSpeed = 0 //setting base speed to 0
    var currentSpeed = 0
    var accelerate: NSTimer? //setting timer up
    var decelerate: NSTimer?
    var presTimeBak = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presTime.text = formatTime(NSDate())
        destTime.text = "NOT SET"
        presTimeBak = presTime.text!
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        //runs any time we segue out of timecircuits
        //take datepickerviewcontroller
        if segue.identifier == "ShowDatePickerSegue"
        {
            let datePickerVC = segue.destinationViewController as! DatePickerViewController
            //data type will be uiviewcontroller. there is no data type delegate in uiviewcontroller. "i know that this is an instance of my datepickerviewcontroller" "cast"
            datePickerVC.delegate = self
            //self referring to the class that we're in. we're setting this class as the value for delegate
            //does self conform to protocol? Yes, because we've signed up for it and fulfilled the conract by using the function dateWasChosen
        }
    }
    
//MARK: - delegate
    
    func dateWasChosen(destDate: NSDate)
    {
        destTime.text = formatTime(destDate)
        //take the date from the date picker, format it, then assign it as the text in desTime
        errorLabel.text = ""
        //set the error label back to blank when going back to the main view
    }
        
//MARK: - THE ACTION HANDLERS
        //coming soon to a theater near you
    
    @IBAction func travBackTapped(sender: UIButton)
    {
        travelBackPressed()
    }

//MARK: - private

    func formatTime(timeToFormat: NSDate) -> String
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMM dd YYYY", options: 0, locale: NSLocale(localeIdentifier: "en-US"))
        let formattedTime = formatter.stringFromDate(timeToFormat).uppercaseString
        return formattedTime
    }
    
    func travelBackPressed()
    {
        
        if destTime.text == "NOT SET"
        {
            errorLabel.text = "ERROR: SET DESTINATION TIME"
        }
        else if destTime.text == presTime.text
        {
            errorLabel.text = "ERROR: DESTINATION SAME AS PRESENT"
        }
        else
        {
            view.backgroundColor = UIColor.blackColor()
            errorLabel.text = "ACCELERATING"
            presTimeBak = presTime.text!
            //storing the value of the current presTime so I can put it in lastTimeDep
            
            if accelerate == nil
            {
                accelTimer(0.15)
                travBack.setTitle("", forState: UIControlState.Normal)
                setDestTime.setTitle("", forState: UIControlState.Normal)
            }
        }
    }
    
//MARK: - timer stuff
    
    func destroyTimer()
    {
        accelerate?.invalidate()
        accelerate = nil
        
        decelerate?.invalidate()
        decelerate = nil
    }
    
    func accelTimer(tickInterval: Double)
    {
        accelerate = NSTimer.scheduledTimerWithTimeInterval(tickInterval, target: self, selector: "updateSpeed", userInfo: nil, repeats: true)
    }
    
    func decelTimer(tickInterval: Double)
    {
        decelerate = NSTimer.scheduledTimerWithTimeInterval(tickInterval, target: self, selector: "updateBrake", userInfo: nil, repeats: true)
    }
    
//MARK: - SPEED
    //with keanu reeves
    
    func stopSpeed()
    {
        destroyTimer()
        
        travBack.setTitle("TRAVEL BACK", forState: UIControlState.Normal)
        setDestTime.setTitle("SET DESTINATION TIME", forState: UIControlState.Normal)
        
        baseSpeed = 0
        lastTimeDep.text = presTimeBak
        speedLabel.text = ("\(baseSpeed) MPH")
        errorLabel.text = "ARRIVED"
    }
    
//sloppy
    func accelerateSpeed(currentSpeed: Int)
    {
        if currentSpeed == 7
        {
            destroyTimer()
            accelTimer(0.09)
        }
        if currentSpeed == 20
        {
            destroyTimer()
            accelTimer(0.1)
        }
        else if currentSpeed == 30
        {
            destroyTimer()
            accelTimer(0.12)
        }
        else if currentSpeed == 50
        {
            destroyTimer()
            accelTimer(0.15)
        }
        else if currentSpeed == 60
        {
            destroyTimer()
            accelTimer(0.18)
        }
        else if currentSpeed == 70
        {
            destroyTimer()
            accelTimer(0.22)
        }
        else if currentSpeed == 80
        {
            destroyTimer()
            accelTimer(0.28)
        }
    }
    
    func updateSpeed()
    {
        currentSpeed = baseSpeed + 1
        baseSpeed = currentSpeed
        
        accelerateSpeed(currentSpeed)
        
        if currentSpeed < 88
        {
            speedLabel.text = ("\(baseSpeed) MPH")
        }
            
        if currentSpeed == 88
        {
            speedLabel.text = "88 MPH"
            
            errorLabel.text = "SPEED REACHED"
            view.backgroundColor = UIColor.blackColor()
        }
        
        if currentSpeed == 92
        {
            errorLabel.text = "TRAVELING"
        }
        
        if currentSpeed == 100
        {
            presTime.text = destTime.text
            currentSpeed = 88
            destroyTimer()
            decelTimer(0.005)
            errorLabel.text = "DECELERATING"
        }
        
    }

//MARK:- brake
    //(but stay above 60 mph)
    
    func updateBrake()
    {
        speedLabel.text = ("\(baseSpeed) MPH")
        baseSpeed = currentSpeed
        currentSpeed = baseSpeed - 1
        
        if currentSpeed == 0
        {
            view.backgroundColor = UIColor.darkGrayColor()
            stopSpeed()
        }
    }
    
// :^)
    
}