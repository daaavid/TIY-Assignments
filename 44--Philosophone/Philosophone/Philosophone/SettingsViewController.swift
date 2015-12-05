//
//  SettingsViewController.swift
//  Philosophone
//
//  Created by david on 12/4/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPopoverPresentationControllerDelegate
{
    @IBOutlet weak var hourLabel: UILabel!
    
    var presses = 1
    var hours = [
        6,
        8,
        12,
        16,
        20
    ]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func categoriesButtonTapped(sender: UIButton)
    {
        performSegueWithIdentifier("categoriesPopover", sender: nil)
    }

    @IBAction func hourButtonTapped(sender: UIButton)
    {
        if presses >= hours.count
        {
            presses = 0
        }
        
        var hour = hours[presses]
        var suffix = " A.M."
        
        if hour > 12
        {
            hour -= 12
            suffix = " P.M."
        }
        
        hourLabel.text = String(hour) + suffix
        
        GLOBAL_SETTINGS?.hour = hours[presses]
        print("set hour \(hours[presses])")
        
        presses++
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
