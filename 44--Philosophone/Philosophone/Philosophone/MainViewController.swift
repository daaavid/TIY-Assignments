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

let kSettingsKey = "Settings"

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
    func typeQuoteAgain()
}

class MainViewController: UIViewController, APIControllerProtocol, TypedCharacterTextDelegate, SettingsChangedDelegate
{
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var wordDivider: UILabel!
    
    @IBOutlet weak var settingsButton: UIButton!
    var settingsButtonPosition: CGRect?
    
    var apiController: APIController?
    
    let sound = TypewriterClack()
    
    var typeAgain = false

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        settingsButton.alpha = 0
        
        makeTestQuote()
        
        performSetup()
        
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
            
            GLOBAL_SETTINGS = Settings(hour: 6, categories: categories, sound: true)
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        settingsButton.slideVerticallyToOriginAndSpin(1, fromPointY: settingsButton.frame.height * 2, spin: true)
        
        if settingsButtonPosition != nil
        {
            settingsButton.frame = settingsButtonPosition!
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        if typeAgain
        {
            performSetup()
            typeAgain = false
        }
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        settingsButton.alpha = 0
    }
    
    func makeTestQuote()
    {
        let quote = "The only thing necessary for the triumph of evil is for good men to do nothing."
        let author = "Edmund Burke"
        
        GLOBAL_QUOTE = Quote(quote: quote, author: author)
    }
    
    func performSetup()
    {
        // quote
        
        quoteLabel.text = ""
        authorLabel.text = ""
        wordDivider.alpha = 0
        
        if GLOBAL_QUOTE != nil
        {
            quoteLabel.typeText(GLOBAL_QUOTE!.quote, interval: 0.035, delegate: self)
            
            setNotification()
        }
        else if GLOBAL_SETTINGS?.categories.count > 0
        {
            print("get quote")
            
            apiController = APIController(delegate: self)
            apiController?.getQuote(GLOBAL_SETTINGS!.categories)
        }
        else
        {
            quoteLabel.typeText("Select at least one quote category from the settings.", interval: 0.35, delegate: nil)
            authorLabel.text = ""
        }
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
    
    func quoteFinishedTyping()
    {
        wordDivider.appearWithFade(0.25)
        
        let global_queue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)
        dispatch_async(global_queue) { () -> Void in
            NSThread.sleepForTimeInterval(0.75)
            
            self.authorLabel.typeText(GLOBAL_QUOTE!.author, interval: 0.35, delegate: nil)
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
        
        if GLOBAL_QUOTE != nil
        {
            //new notification
            let newNotification = UILocalNotification()
            newNotification.timeZone = NSTimeZone.localTimeZone()
            
            newNotification.alertBody = "\(GLOBAL_QUOTE!.quote) - \n\(GLOBAL_QUOTE!.author) \n\nTap to schedule tomorrow's quote."
            
            newNotification.alertTitle = "Philosophone"
            let uuid = NSUUID()
            let userInfo = ["objectUUID" : uuid.UUIDString]
            newNotification.userInfo = userInfo
            
            newNotification.fireDate = getFireDate() //<<<<<<
            newNotification.repeatInterval = .Day
//            newNotification.fireDate = NSDate(timeInterval: 20, sinceDate: NSDate())
    
            print("notification scheduled \(newNotification) -- ")
            
            UIApplication.sharedApplication().scheduleLocalNotification(newNotification)
            print("\(UIApplication.sharedApplication().scheduledLocalNotifications?.count) notification(s) scheduled")
        }
        else
        {
            performSetup()
        }
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
    
    func notificationPopped()
    {
        //clear out old quote and get a new one
        print("notificationPopped")
        
//        GLOBAL_QUOTE = nil
        setNotification()
    }
    
    // MARK: - Settings
    
    @IBAction func settingsButtonTapped(sender: UIButton)
    {
        settingsButton.spin()
        settingsButtonPosition = settingsButton.frame
        
        sound.playSound()
        
        performSegueWithIdentifier("showSettingsSegue", sender: self)
    }
    
    func settingsDidChange()
    {
        setNotification()
    }
    
    func typeQuoteAgain()
    {
        typeAgain = true
    }
    
    func saveSettings()
    {
        let data = NSKeyedArchiver.archivedDataWithRootObject(GLOBAL_SETTINGS!)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: kSettingsKey)
        
        print("saved settings: ", GLOBAL_SETTINGS!)
    }
    
    func loadSettings()
    {
        let standardUserDefaults = NSUserDefaults.standardUserDefaults()
        if let data = standardUserDefaults.objectForKey(kSettingsKey) as? NSData
        {
            if let savedSettings = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Settings
            {
                GLOBAL_SETTINGS = savedSettings
                print("loaded settings: ", savedSettings)
            }
        }
    }
}

