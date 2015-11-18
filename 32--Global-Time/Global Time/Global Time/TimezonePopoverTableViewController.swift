//
//  TimeZonePopoverTableViewController.swift
//  Global Time
//
//  Created by david on 11/17/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class TimezonePopoverTableViewController: UITableViewController, UISearchBarDelegate
{
    var timezones = [String]()
    var shownTimezones = [String]()
    var shownTimezonesBak = [String]()
    var indexTitles = [String]()
    var delegate: TimezonePopoverTableViewControllerDelegate?
    var narrowed = false
    var contentWidth: CGFloat = 0
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad()
    {
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor(hue:0.744, saturation:0.855, brightness:0.852, alpha:1)
        let searchBarTextField = searchBar.valueForKey("searchField") as! UITextField
        searchBarTextField.textColor = UIColor.whiteColor()
        
        for timezone in timezones
        {
            let narrowedTimeZone = timezone.componentsSeparatedByString("/")[0]
            if !shownTimezones.contains(narrowedTimeZone)
            {
                shownTimezones.append(narrowedTimeZone)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        for timezone in timezones
        {
            let firstLetter = String([Character](timezone.characters)[0])
            if !indexTitles.contains(firstLetter)
            {
                indexTitles.append(firstLetter)
            }
        }
    }
    
    // MARK: - search bar
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        
        shownTimezonesBak = shownTimezones
        shownTimezones.removeAll()
        
        for timezone in shownTimezonesBak
        {
            let formattedSearchText = searchBar.text!
                    .lowercaseString
                    .stringByReplacingOccurrencesOfString(" ", withString: "_")
            
            if timezone.lowercaseString.containsString(formattedSearchText)
            {
                shownTimezones.append(timezone)
            }
        }
        print(shownTimezones)
        
        let contentHeight = CGFloat(shownTimezones.count * 44 + 44)
        if narrowed
        {
            self.preferredContentSize = CGSizeMake(contentWidth * 10.5, contentHeight)
        }
        else
        {
            self.preferredContentSize = CGSizeMake(150, contentHeight)
        }
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        shownTimezones = shownTimezonesBak
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return shownTimezones.count
    }

    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]?
    {
        return indexTitles
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView
            .dequeueReusableCellWithIdentifier("TimezoneCell", forIndexPath: indexPath)

        let timezone = shownTimezones[indexPath.row]
        let formattedTimezone = timezone
            .stringByReplacingOccurrencesOfString("/", withString: ", ")
            .stringByReplacingOccurrencesOfString("_", withString: " ")
        cell.textLabel!.text = formattedTimezone

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
                    let characterCount = CGFloat(timezone.characters.count)
                    if characterCount > contentWidth
                    {
                        contentWidth = characterCount
                    }
                }
            }
            
            self.preferredContentSize = CGSizeMake(contentWidth * 10.5, 300)
            searchBar.hidden = false
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
