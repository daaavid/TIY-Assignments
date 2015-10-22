//
//  TableViewController.swift
//  High-Voltage
//
//  Created by david on 10/22/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class ElecPopoverTableViewController: UITableViewController
{
    var elecItems: [String]?
    var delegate: ElecPopoverTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return elecItems!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ElecCell", forIndexPath: indexPath)

        let anElecItem = elecItems?[indexPath.row]
        cell.textLabel?.text = anElecItem

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        delegate?.elecItemWasChosenFromPopover((elecItems?[indexPath.row])!)
    }

}