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
    @IBOutlet var errorLabel: UILabel!
    
    var baseSpeed = 0 //setting base speed to 0
    var accelerate: NSTimer? //setting timer up
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
        if segue.identifier == "ShowDatePickerSegue"
        {
            let datePickerVC = segue.destinationViewController as! DatePickerViewController
            datePickerVC.delegate = self

            
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
        return String(formattedTime)
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
            view.backgroundColor = UIColor.darkGrayColor()
            errorLabel.text = "ACCELERATING"
            presTimeBak = presTime.text!
            //storing the value of the current presTime so I can put it in lastTimeDep
            
            if accelerate == nil
            {
                timer(0.1)
                travBack.setTitle("", forState: UIControlState.Normal)
            }
        }
    }
    
    func timer(tickInterval: Double)
    {
        accelerate = NSTimer.scheduledTimerWithTimeInterval(tickInterval, target: self, selector: "updateSpeed", userInfo: nil, repeats: true)
    }
    
    func stopSpeed()
    {
        accelerate?.invalidate()
        accelerate = nil
        
        travBack.setTitle("TRAVEL BACK", forState: UIControlState.Normal)
        
        baseSpeed = 0
        lastTimeDep.text = presTimeBak
        speedLabel.text = ("\(baseSpeed) MPH")
    }
    
    func updateSpeed()
    {
        let currentSpeed = baseSpeed + 1
        baseSpeed = currentSpeed
        
        if currentSpeed == 88
        {
            stopSpeed()
            
            presTime.text = destTime.text
            errorLabel.text = "ARRIVED"
            view.backgroundColor = UIColor.blackColor()
        }
        
        speedLabel.text = ("\(baseSpeed) MPH")
    }
    
// :^)
    
}