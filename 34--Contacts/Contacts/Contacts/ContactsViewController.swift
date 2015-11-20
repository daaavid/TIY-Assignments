//
//  ContactsViewController.swift
//  Contacts
//
//  Created by david on 11/20/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import RealmSwift

protocol SearchProtocol
{
    func didSearch(results: [Contact])
}

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchProtocol
{
    @IBOutlet weak var tableView: UITableView!
    
    var you: Contact?
    var contacts: Results <Contact>!
    var filterString: String?
    var shownContacts = [Contact]()
    let realm = try! Realm()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        contacts = realm.objects(Contact)
//            .filter("name != %@", you!.name)
            .sorted("name")
        
        for contact in contacts
        {
            shownContacts.append(contact)
        }
        
        if let _ = filterString
        {
            for contact in contacts
            {
                contacts = contacts.filter(filterString!, contact.favorite)
            }
        }

//        for contact in contacts
//        {
//            shownContacts.append(contact)
//        }

        // Do any additional setup after loading the view.
    }
    
    func didSearch(results: [Contact])
    {
        shownContacts = results
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
    /*
    let ContactDetailVC = storyboard?.instantiateViewControllerWithIdentifier("ContactDetailViewController") as! ContactDetailViewController
    let selectedContact = contacts[indexPath.row]
    ContactDetailVC.Contact = selectedContact
    
    navigationController?.pushViewController(ContactDetailVC, animated: true)
    */
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
