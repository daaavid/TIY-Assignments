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
//    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addContactButton: UIButton!
    
    weak var currentViewController: UIViewController?

    let realm = try! Realm()
    var contacts: Results <Contact>!
    
    var currentCreateAction: UIAlertAction!
    
    override func viewDidLoad()
    {
        searchBar.delegate = self
        super.viewDidLoad()
        contacts = realm.objects(Contact).sorted("name")
        
        cycleViewController("Contacts")
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
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        print("textDidChange")
        
        let contactsVC = self.childViewControllers[0] as! ContactsViewController
        contactsVC.shownContacts.removeAll()
        
        for contact in self.contacts
        {
            if contact.name.lowercaseString.containsString(searchBar.text!.lowercaseString)
            {
                contactsVC.shownContacts.append(contact)
            }
        }
    }
    
    @IBAction func segmentChanged(sender: UISegmentedControl)
    {
        print(childViewControllers)
        
        switch sender.selectedSegmentIndex
        {
        case 0: cycleViewController("Contacts")
        case 1: cycleViewController("Favorites")
        case 2: cycleViewController("Profile")
        default: print("nothing to see here")
        }
    }
    
    func cycleViewController(identifier: String)
    {
        let newVC = storyboard!.instantiateViewControllerWithIdentifier(identifier)
        
        if identifier != "Profile"
        {
            self.addContactButton.hidden = false
            self.addContactButton.alpha = 0
            UIView.animateWithDuration(0.4, animations:
                { () -> Void in
                    self.addContactButton.alpha = 1
            } )
        }
        else
        {
            self.addContactButton.hidden = true
        }
        
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
            }
    
        } )
        
        if let currentVC = currentViewController
        {
            currentVC.view.removeFromSuperview()
            currentViewController?.removeFromParentViewController()
        }

        currentViewController = newVC
    }
    
    
    @IBAction func addButtonTapped(sender: UIButton)
    {
        addFriend()
    }
    
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
}

