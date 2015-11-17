//
//  GlobalTimeTableViewController.swift
//  Global Time
//
//  Created by david on 11/17/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

protocol TimezonePopoverTableViewControllerDelegate
{
    func timezoneWasChosen(chosenTimezone: String)
}

class GlobalTimeTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate, TimezonePopoverTableViewControllerDelegate
{
    var allTimezones = [String]()
    var shownTimezones = [String]()
    var remainingTimezones = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return shownTimezones.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClockCell", forIndexPath: indexPath)
        
        

        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "TimezonePopover"
        {
            let popover = segue.destinationViewController as!TimezonePopoverTableViewController
            popover.timezones = self.remainingTimezones
            popover.delegate = self
            popover.popoverPresentationController?.delegate = self
            
            let contentHeight = 44 * CGFloat(remainingTimezones.count)
            popover.preferredContentSize = CGSizeMake(200, contentHeight)
        }
    }
    
    func timezoneWasChosen(chosenTimezone: String)
    {
        shownTimezones.append(chosenTimezone)
    }
}
