//
//  ProfileViewController.swift
//  Contacts
//
//  Created by david on 11/20/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController
{
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var familyButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var contact: Contact!
    let realm = try! Realm()
    
    var edit = false

    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let _ = contact
        {
            print(contact)
            nameTextField.text = contact.name
        }
        else
        {
            //bad way to do this
            let contacts = realm.objects(Contact).filter("name == %@", youName)
            for contact in contacts
            {
                self.contact = contact
                nameTextField.text = contact.name
            }
        }
        toggleTextFields()
    }
    
    func toggleTextFields()
    {
        let toggle = !nameTextField.enabled
        
        nameTextField.enabled = toggle
        numberTextField.enabled = toggle
        emailTextField.enabled = toggle
    }

    @IBAction func familyButtonPressed(sender: UIButton)
    {
        try! realm.write({ () -> Void in
            self.contact.favorite = !self.contact.favorite
        })
    }
    
    @IBAction func editButtonPressed(sender: UIButton)
    {
        edit = !edit
        toggleTextFields()
        
        self.view.alpha = 0.4
        UIView.animateWithDuration(0.4) { () -> Void in
            self.view.alpha = 1
        }
        
        if edit
        {
            editButton.setImage(UIImage(named: "editing"), forState: .Normal)
            nameTextField.becomeFirstResponder()
        }
        else
        {
            editButton.setImage(UIImage(named: "edit"), forState: .Normal)
            try! realm.write({ () -> Void in
                self.contact.name = self.nameTextField.text!
//                self.contact.number =
//                self.contact.email =
            })
        }
        
    }
}
