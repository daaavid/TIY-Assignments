//
//  ProfileViewController.swift
//  Contacts
//
//  Created by david on 11/20/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import RealmSwift

class ProfileViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var familyButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var contact: Contact!
    let realm = try! Realm()
    
    var edit = false
    
    var allTextFields: [UITextField]!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func setContact()
    {
        allTextFields = [nameTextField, numberTextField, emailTextField]
        
        if let _ = contact
        {
            print(contact)
            setTextFields(contact)
        }
        else
        {
            //bad way to do this
            familyButton.hidden = true
            let contacts = realm.objects(Contact).filter("name == %@", youName)
            for contact in contacts
            {
                self.contact = contact
                setTextFields(self.contact)
            }
        }
        toggleTextFields()
    }
    
    func setTextFields(contact: Contact)
    {
        nameTextField.text = contact.name
        numberTextField.text = contact.number
        emailTextField.text = contact.email
        
        if contact.favorite
        {
            familyButton.setImage(UIImage(named: "isFamily"), forState: .Normal)
        }
    }
    
    func toggleTextFields()
    {
        for textField in allTextFields
        {
            textField.enabled = edit
            if edit
            {
                textField.borderStyle = .RoundedRect
                textField.backgroundColor = UIColor.clearColor()
            }
            else
            {
                textField.borderStyle = .None
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        var rc = false
        if textField.text != ""
        {
            switch textField
            {
            case nameTextField:
                numberTextField.becomeFirstResponder()
            case numberTextField:
                emailTextField.becomeFirstResponder()
            default:
                textField.resignFirstResponder()
                editButtonPressed(editButton)
            }
            rc = true
        }
        return rc
    }

    @IBAction func familyButtonPressed(sender: UIButton)
    {
        try! realm.write({ () -> Void in
            self.contact.favorite = !self.contact.favorite
        })
        
        if contact.favorite
        {
            familyButton.setImage(UIImage(named: "isFamily"), forState: .Normal)
        }
        else
        {
            familyButton.setImage(UIImage(named: "family"), forState: .Normal)
        }
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
            var validEdit = 0
            
            for textField in allTextFields
            {
                if textField.text != ""
                {
                    validEdit++
                }
            }
            
            if validEdit == 3
            {
                try! realm.write({ () -> Void in
                    self.contact.name = self.nameTextField.text!
                    self.contact.number = self.numberTextField.text!
                    self.contact.email = self.emailTextField.text!
                    
                    print("realmWrite: Edit")
                })
            }
        }
    }
}
