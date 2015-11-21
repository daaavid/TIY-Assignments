//
//  ViewController.swift
//  Contacts
//
//  Created by david on 11/20/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UISearchBarDelegate
{
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var addContactButtonView: UIView!
    @IBOutlet weak var navLabel: UILabel!
    
    let realm = try! Realm()
    var contacts: Results <Contact>!
    
    var currentCreateAction: UIAlertAction!
    weak var currentViewController: UIViewController?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        contacts = realm.objects(Contact).sorted("name")

        segmentChanged(segmentedControl)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        manageChildContents(true)
    }
    
    //MARK: - Action Handlers
    
    @IBAction func segmentChanged(sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            manageNavLabelAndSearchBar("Contacts")
            cycleViewController("Contacts")
        case 1:
            manageNavLabelAndSearchBar("Family")
            cycleViewController("Contacts")
        case 2:
            manageNavLabelAndSearchBar("Profile")
            cycleViewController("Profile")
        default: print("nothing to see here")
        }
    }
    
    @IBAction func addButtonTapped(sender: UIButton)
    {
        addFriend()
    }
    
    //MARK: - Child VCs and subviews
    
    func cycleViewController(identifier: String)
    {
        manageAddButtonView(identifier)

        let newVC = storyboard!.instantiateViewControllerWithIdentifier(identifier)
        newVC.view.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(newVC)
        
        addSubview(newVC.view, toView: containerView)

        newVC.view.alpha = 0
        UIView.animateWithDuration(0.4, animations:
        { () -> Void in
           
            newVC.view.alpha = 1
            if let currentVC = self.currentViewController
            {
                currentVC.view.alpha = 0
                currentVC.view.removeFromSuperview()
                currentVC.removeFromParentViewController()
            }
        } )

        currentViewController = newVC
        
        manageChildContents(false)
    }
    
    func addSubview(subView: UIView, toView parentView: UIView)
    {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView
            .addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[subView]|",
                options: [], metrics: nil, views: viewBindingsDict))
        parentView
            .addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[subView]|",
                options: [], metrics: nil, views: viewBindingsDict))
    }
    
    //MARK: - Manage Content
    
    func manageChildContents(isSearch: Bool)
    {
        if let contactsVC = self.childViewControllers[0] as? ContactsViewController
        {
            contactsVC.shownContacts.removeAll()
            switch segmentedControl.selectedSegmentIndex
            {
            case 0:
                //Contacts
                if isSearch
                {
                    for contact in self.contacts
                    {
                        if searchBar.text != "" && contact.name.lowercaseString.containsString(searchBar.text!.lowercaseString)
                        {
                            contactsVC.shownContacts.append(contact)
                        }
                        else if searchBar.text == ""
                        {
                            contactsVC.shownContacts.append(contact)
                        }
                    }
                }
                else
                {
                    for contact in self.contacts
                    {
                        contactsVC.shownContacts.append(contact)
                    }
                }
            case 1:
                //Family
                if isSearch
                {
                    for contact in self.contacts
                    {
                        if searchBar.text != "" && contact.favorite && contact.name.lowercaseString.containsString(searchBar.text!.lowercaseString)
                        {
                            contactsVC.shownContacts.append(contact)
                        }
                        else if searchBar.text == "" && contact.favorite
                        {
                            contactsVC.shownContacts.append(contact)
                        }
                    }
                }
                else
                {
                    for contact in self.contacts
                    {
                        if contact.favorite
                        {
                            contactsVC.shownContacts.append(contact)
                        }
                    }
                }
                default: print("wrong vc.")
            }
            
            contactsVC.tableView.reloadData()
        }
        else if let profileVC = self.childViewControllers[0] as? ProfileViewController
        {
//            let selectedContact = contacts.valueForKey(<#T##key: String##String#>)
//            profileVC.contact = selectedContact
        }
    }
    
    func manageAddButtonView(identifier: String)
    {
        if identifier != "Profile"
        {
            self.addContactButtonView.hidden = false
            self.addContactButtonView.alpha = 0
            UIView.animateWithDuration(0.4, animations:
                { () -> Void in
                    self.addContactButtonView.alpha = 1
            } )
        }
        else
        {
            self.addContactButtonView.hidden = true
        }
    }
    
    func manageNavLabelAndSearchBar(text: String)
    {
        navLabel.alpha = 0
        UIView.animateWithDuration(0.4, animations:
        { () -> Void in
                self.navLabel.text = text
                self.navLabel.alpha = 1
        } )
        
        let searchTextField = searchBar.valueForKey("searchField") as! UITextField
        searchBar.resignFirstResponder()
        
        if text == "Profile"
        {
            searchBar.text = ""
            searchBar.alpha = 0.8
            searchTextField.enabled = false
        }
        else
        {
            searchTextField.enabled = true
            searchBar.alpha = 1
        }
    }
    
    //MARK: - Add Friend
    
    func addFriend()
    {
        let alertController = UIAlertController(title: "Add Contact", message: "Add some info for this contact.", preferredStyle: .Alert)
        // .Alert and .ActionSheet
        currentCreateAction = UIAlertAction(title: "Create", style: .Default)
        { (action) -> Void in
            let newContact = Contact()
            let name = alertController.textFields?.first?.text
            let number = alertController.textFields?[1].text

            newContact.name = name!
            newContact.number = number!
            
            try! self.realm.write(
            { () -> Void in
                self.realm.add(newContact)
                self.cycleViewController("Contacts")

            })

        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.addAction(currentCreateAction)
        currentCreateAction.enabled = false
        
        alertController.addTextFieldWithConfigurationHandler
        { (textField) -> Void in
                textField.placeholder = "Name"
                textField.addTarget(self, action: "ContactNameFieldDidChange:", forControlEvents: .EditingChanged)
        }
        
        alertController.addTextFieldWithConfigurationHandler
            { (textField) -> Void in
                textField.placeholder = "Number"
                textField.addTarget(self, action: "ContactNumberFieldDidChange:", forControlEvents: .EditingChanged)
        }
        
        alertController.addTextFieldWithConfigurationHandler
            { (textField) -> Void in
                textField.placeholder = "Email"
                textField.addTarget(self, action: "ContactEmailFieldDidChange:", forControlEvents: .EditingChanged)
        }
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func ContactNameFieldDidChange(sender: UITextField)
    {
        self.currentCreateAction.enabled = sender.text?.characters.count > 0
    }
    
    func ContactNumberFieldDidChange(sender: UITextField)
    {
        self.currentCreateAction.enabled = sender.text?.characters.count > 0
    }
    
    func ContactEmailFieldDidChange(sender: UITextField)
    {
        self.currentCreateAction.enabled = sender.text?.characters.count > 0
    }
}

