//
//  TimeZonePopoverTableViewController.swift
//  Global Time
//
//  Created by david on 11/17/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class TimezonePopoverTableViewController: UITableViewController
{
    var timezones = [String]()
    var shownTimezones = [String]()
    var delegate: TimezonePopoverTableViewControllerDelegate?
    var narrowed = false
    
    override func viewDidLoad()
    {
        for timezone in timezones
        {
            let narrowedTimeZone = timezone.componentsSeparatedByString("/")[0]
            if !shownTimezones.contains(narrowedTimeZone)
            {
                shownTimezones.append(narrowedTimeZone)
            }
        }
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
        let cell = tableView.dequeueReusableCellWithIdentifier("TimezoneCell", forIndexPath: indexPath)

//        let timezone = timezones[indexPath.row]
        let timezone = shownTimezones[indexPath.row]
        cell.textLabel?.text = timezone

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if !narrowed
        {
            shownTimezones.removeAll()
            
            for timezone in timezones
            {
                if timezone.containsString(cell.textLabel!.text!)
                {
                    shownTimezones.append(timezone)
                }
            }
            
            self.preferredContentSize = CGSizeMake(300, 300)
            self.tableView.reloadData()
            narrowed = true
        }
            
        else
        {
            let timezone = shownTimezones[indexPath.row]
            delegate?.timezoneWasChosen(timezone)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
