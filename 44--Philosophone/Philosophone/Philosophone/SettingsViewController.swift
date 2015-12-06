//
//  SettingsViewController.swift
//  Philosophone
//
//  Created by david on 12/4/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UIViewController, UIPopoverPresentationControllerDelegate
{
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var soundOnOffLabel: UILabel!
    @IBOutlet weak var typeQuoteAgainLabel: UILabel!
    
    let sound = TypewriterClack()
    
    var delegate: SettingsChangedDelegate!
    
    var presses: Int!
    
    var hours = [
        6,
        8,
        10,
        12,
        14,
        16,
        18,
        20,
        22,
        24
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let mainVC = navigationController?.viewControllers[0] as! MainViewController
        delegate = mainVC
        
        presses = hours.indexOf(GLOBAL_SETTINGS!.hour)!
        print(presses)
        
        setHourLabel()
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        typeQuoteAgainLabel.alpha = 0
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        sound.playSound()
    }
    
    @IBAction func categoriesButtonTapped(sender: UIButton)
    {
        sound.playSound()
        
        performSegueWithIdentifier("categoriesPopover", sender: nil)
    }

    @IBAction func hourButtonTapped(sender: UIButton)
    {
        sound.playSound()
        
        presses = presses + 1
        
        if presses >= hours.count
        {
            presses = 0
        }
        
        GLOBAL_SETTINGS?.hour = hours[presses]

        setHourLabel()
        
        delegate.settingsDidChange()
    }
    
    @IBAction func soundButtonTapped(sender: UIButton)
    {
        if soundOnOffLabel.text == "On"
        {
            soundOnOffLabel.text = "Off"
            GLOBAL_SETTINGS?.sound = false
        }
        else
        {
            soundOnOffLabel.text = "On"
            GLOBAL_SETTINGS?.sound = true
        }
        
        sound.playSound()
    }
    
    @IBAction func typeQuoteAgainButtonTapped(sender: UIButton)
    {
        if typeQuoteAgainLabel.alpha == 0
        {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.typeQuoteAgainLabel.alpha = 1
            })
            
            delegate.typeQuoteAgain()
        }
        else
        {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.typeQuoteAgainLabel.alpha = 0
            })
        }
    }
    
    
    func setHourLabel()
    {
        var hour = GLOBAL_SETTINGS!.hour
        
        var suffix = " A.M."
        
        if hour >= 12
        {
            if hour > 12
            {
                hour -= 12
            }
            suffix = " P.M."
        }
        
        hourLabel.text = String(hour) + suffix
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "categoriesPopover"
        {
            let categoriesPopover = segue.destinationViewController as! CategoriesPopoverTableViewController
            categoriesPopover.popoverPresentationController?.delegate = self
            let contentHeight = 44.0 * CGFloat(categoriesPopover.categoriesDictionary.keys.count)
            categoriesPopover.preferredContentSize = CGSizeMake(200.0, contentHeight)
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
}
