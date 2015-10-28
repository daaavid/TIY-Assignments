//
//  FriendListTableViewController.swift
//  Github-Friends
//
//  Created by david on 10/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

protocol NewFriendViewControllerProtocol
{
    func searchWasCompleted(results: NSDictionary)
}


class FriendListTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate, NewFriendViewControllerProtocol
{
    var friends = [Friend]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addTapped:")
        navigationItem.rightBarButtonItems = [addButton]
        let clearButton = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "clearTapped:")
        navigationItem.leftBarButtonItems = [clearButton]
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "FriendCell")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath)
        
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.username
        
        if cell.textLabel?.text == "Not Listed"
        {
            friends.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let chosenFriend = friends[indexPath.row]
        let detailVC = FriendDetailViewController()
        detailVC.friend = chosenFriend
        detailVC.populateLabels()
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func addTapped(sender: UIBarButtonItem)
    {
        let newFriendVC = NewFriendViewController()
        newFriendVC.delegate = self
        navigationController?.presentViewController(newFriendVC, animated: true, completion: nil)
    }
    
    func clearTapped(sender: UIBarButtonItem)
    {
        friends.removeAll()
        tableView.reloadData()
    }
    
    func searchWasCompleted(results: NSDictionary)
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)

        self.friends = self.friends + Friend.friendsWithJSON(results)
        self.tableView.reloadData()
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }
}
