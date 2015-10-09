//
//  ViewController.swift
//  outaTime
//
//  Created by Ennui on 10/8/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

@objc protocol DatePickerDelegate //need this for class that's /recieving/ the data from timerpickerdelegate
{
    func timerWasChosen(timerCount: Int)
    //as back button is tapped, and view is transitioning back to main screen, return time
}

class TimeCircuitsViewController: UIViewController, DatePickerDelegate
{
    @IBOutlet var destTime: UILabel!
    @IBOutlet var presTime: UILabel!
    @IBOutlet var lastTimeDep: UILabel!
    @IBOutlet var speed: UILabel!
//    @IBOutlet var travBack: UIButton!
    
    let formatter = NSDateFormatter()
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMM dd YYYY", options: 0, locale: NSLocale(localeIdentifier: "en-US"))
        presTime.text = formatter.stringFromDate(NSDate()).uppercaseString
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
            let datePickerVC = segue.destinationViewController as! DatePickerViewController //view controller that this segue points at. in this case, the timerpickerviewcontroller
            
            datePickerVC.delegate = self
            //self is referring to the countdownviewcontroller object
            //at the top, we declared that we were the timerpickerviewcontroller delegate
            
        }
    }
    
    func timerWasChosen(timerCount: Int)
    {
//        destTime.text = "\(timerCount)"
    }
    
    

}

