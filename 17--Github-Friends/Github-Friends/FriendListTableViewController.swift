//
//  FriendListTableViewController.swift
//  Github-Friends
//
//  Created by david on 10/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

protocol APIControllerProtocol
{
    func didReceiveAPIResults(results: NSDictionary)
}

//protocol NewFriendViewControllerProtocol
//{
//    func searchWasCompleted(results: NSDictionary)
//}

//protocol NewFriendViewControllerProtocol
//{
//    func searchWasCompleted(results: [Friend])
//}

protocol NewFriendViewControllerProtocol
{
    func searchWasCompleted(username: String)
}

class FriendListTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate, NewFriendViewControllerProtocol, APIControllerProtocol
{
    var friends = [Friend]()
    var displayFriends = [[Friend]]()
    
    var api: APIController!
    var searchTerm = ""
//    var nfvc: NewFriendViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        api = APIController(delegate: self)
        api.searchGithubFor("daaavid")

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addTapped:")
        navigationItem.rightBarButtonItems = [addButton]
        let clearButton = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "clearTapped:")
        navigationItem.leftBarButtonItems = [clearButton]
        

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "FriendCell")
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
//        return friends.count
        return friends.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath)
        
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.username
        if friend.username == ""
        {
            cell.textLabel?.text = "Not Found!"
        }
        
        if cell.textLabel?.text == "Not Found!"
        {
            friends.removeAtIndex(indexPath.row)
        }
//        let friend = displayFriends[indexPath.row]
//        cell.textLabel?.text =
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
//        newFriendVC.delegate = self
//        newFriendVC.popoverPresentationController?.delegate
//        newFriendVC.delegate = self
        newFriendVC.delegate = self
    
        newFriendVC.modalPresentationStyle = .Popover
        newFriendVC.preferredContentSize = CGSizeMake(200, 200)
        
        
        
//        navigationController?.presentViewController(newFriendVC, animated: true, completion: nil)
        
        navigationController?.pushViewController(newFriendVC, animated: true)
        
    }
    
    func clearTapped(sender: UIBarButtonItem)
    {
        friends.removeAll()
        tableView.reloadData()
    }
    
//    func searchWasCompleted(results: NSDictionary)
//    {
//        navigationController?.dismissViewControllerAnimated(true, completion: nil)
//        
//        print("searchWasCompleted")
//        dispatch_async(dispatch_get_main_queue(), {
//            self.friends = Friend.friendsWithJSON(results)
//            self.tableView.reloadData()
//            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//            print("searchWasCompleted")
//        })
////
////        self.friends = Friend.friendsWithJSON(results)
////        self.tableView.reloadData()
//    }
    
//    func searchWasCompleted(results: [Friend])
//    {
//        navigationController?.dismissViewControllerAnimated(true, completion: nil)
//        
//        print("searchWasCompleted")
//        dispatch_async(dispatch_get_main_queue(), {
//            self.friends = results
//            self.tableView.reloadData()
//            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//            print("searchWasCompleted")
//        })
//        //
//        //        self.friends = Friend.friendsWithJSON(results)
//        //        self.tableView.reloadData()
//    }
    
    func searchWasCompleted(username: String)
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
        print("searchWasCompleted")
        
//        self.friends = nfvc.friends
        print("searchWasCompleted")
        
//        api.searchGithubFor("daaavid")
        api.searchGithubFor(username)
        self.tableView.reloadData()
        //
        //        self.friends = Friend.friendsWithJSON(results)
        //        self.tableView.reloadData()
        
//        api = APIController(delegate: self)
//        api.searchGithubFor("daaavid")
    }
    
    func didReceiveAPIResults(results: NSDictionary)
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.friends = self.friends + Friend.friendsWithJSON(results)
            self.tableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }

    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        let view = segue.destinationViewController as! NewFriendViewController
//        view.delegate = self
//    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        //        return UIModalPresentationStyle.None
        return .None
    }
    
    // MARK: - API Controller Protocol
    
//    func didReceiveAPIResults(results: NSDictionary)
//    {
//        dispatch_async(dispatch_get_main_queue(), {
//            self.friends = Friend.albumsWithJSON(results)
//            self.tableView.reloadData()
//            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//        })
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
