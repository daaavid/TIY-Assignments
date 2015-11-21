//
//  ContactsViewController.swift
//  Contacts
//
//  Created by david on 11/20/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    var contacts: Results <Contact>!
    var filterString: String?
    var shownContacts = [Contact]()
    let realm = try! Realm()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return shownContacts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath)
    
        let Contact = shownContacts[indexPath.row]
        cell.textLabel?.text = Contact.name
        cell.detailTextLabel?.text = Contact.number
    
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let selectedContact = shownContacts[indexPath.row]
        let profileVC = storyboard?.instantiateViewControllerWithIdentifier("Profile") as! ProfileViewController
        profileVC.contact = selectedContact
        
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
