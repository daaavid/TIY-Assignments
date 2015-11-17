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
    var delegate: TimezonePopoverTableViewControllerDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timezones.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TimezoneCell", forIndexPath: indexPath)

        let timezone = timezones[indexPath.row]
        cell.textLabel?.text = timezone

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let timezone = timezones[indexPath.row]
        delegate?.timezoneWasChosen(timezone)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
