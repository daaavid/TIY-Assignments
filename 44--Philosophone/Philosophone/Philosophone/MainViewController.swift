//
//  ViewController.swift
//  Philosophone
//
//  Created by david on 12/4/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

var GLOBAL_SETTINGS = Settings?()
var GLOBAL_QUOTE = Quote?()

let kNotificationKey = "Notification"

protocol APIControllerProtocol
{
    func quoteWasFound(quoteDict: NSDictionary)
}

protocol TypedCharacterTextDelegate
{
    func quoteFinishedTyping()
}

protocol SettingsChangedDelegate
{
    func settingsDidChange()
}

class MainViewController: UIViewController, APIControllerProtocol, TypedCharacterTextDelegate, SettingsChangedDelegate
{
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var wordDivider: UILabel!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    var apiController: APIController?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        let quote = "The only thing necessary for the triumph of evil is for good men to do nothing."
//        let author = "Edmund Burke"
//        
//        GLOBAL_QUOTE = Quote(quote: quote, author: author)
        
        performSetup()
    }
    
    func performSetup()
    {
        if GLOBAL_SETTINGS == nil
        {
            let categories = [
                "inspire",
                "management",
                "sports",
                "life",
                "funny",
                "love",
                "art"
            ]
            
            GLOBAL_SETTINGS = Settings(hour: 6, categories: categories)
        }
        
        // quote
        
        quoteLabel.text = ""
        authorLabel.text = ""
        wordDivider.alpha = 0
        
        if GLOBAL_QUOTE != nil
        {
            quoteLabel.typeText(GLOBAL_QUOTE!.quote, delegate: self)
            
            setNotification()
        }
        else if GLOBAL_SETTINGS?.categories.count > 0
        {
            apiController = APIController(delegate: self)
            apiController?.getQuote(GLOBAL_SETTINGS!.categories)
        }
        else
        {
            quoteLabel.typeText("Select at least one quote category from the settings.", delegate: nil)
            authorLabel.text = ""
        }
    }
    
    func quoteFinishedTyping()
    {
        wordDivider.appearWithFade(0.2)
        authorLabel.typeText(GLOBAL_QUOTE!.author, delegate: nil)
    }
    
    func quoteWasFound(quoteDict: NSDictionary)
    {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            if let quote = Quote.quoteFromAPIResults(quoteDict)
            {
                print(quote)
                GLOBAL_QUOTE = quote
                self.performSetup()
            }
        }
    }
    
    func setNotification()
    {
        //notification already exists
        if let existingNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        {
            for notification in existingNotifications
            {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
            }
        }
        
        let newNotification = UILocalNotification()
        newNotification.fireDate = getFireDate()
        newNotification.timeZone = NSTimeZone.localTimeZone()
        newNotification.alertBody = GLOBAL_QUOTE!.quote + " - " + GLOBAL_QUOTE!.author
        newNotification.alertTitle = "Philosophone"
        let uuid = NSUUID()
        let userInfo = ["objectUUID" : uuid.UUIDString]
        newNotification.userInfo = userInfo
        
        newNotification.repeatInterval = NSCalendarUnit.Day
        print(newNotification)
        
//        newNotification.addObserver(<#T##observer: NSObject##NSObject#>, forKeyPath: <#T##String#>, options: <#T##NSKeyValueObservingOptions#>, context: <#T##UnsafeMutablePointer<Void>#>)
        
        UIApplication.sharedApplication().scheduleLocalNotification(newNotification)
        
        print("\(UIApplication.sharedApplication().scheduledLocalNotifications?.count) notification(s) scheduled")
    }
    
    func settingsDidChange()
    {
        setNotification()
    }
    
    func getFireDate() -> NSDate?
    {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.hour = GLOBAL_SETTINGS!.hour
        components.timeZone = NSTimeZone.defaultTimeZone()
        
        let fireDate = calendar!.dateFromComponents(components)
        print(fireDate)
        return fireDate
    }
    
    @IBAction func settingsButtonTapped(sender: UIButton)
    {
        settingsButton.spin()
    }
}

