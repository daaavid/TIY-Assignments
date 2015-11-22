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
    var newContact = false
    
    var allTextFields: [UITextField]!
    let textFieldBG = UIColor(red: 0.25, green: 0.7, blue: 0.71, alpha: 1)

    override func viewDidLoad()
    {
        super.viewDidLoad()
        allTextFields = [nameTextField, numberTextField, emailTextField]
    }
    
    func setContact()
    {
        if let _ = contact
        {
            if contact.name == youName
            {
                familyButton.hidden = true
            }

            print(contact)
            setTextFields(contact)
        }
        else
        {
            familyButton.hidden = true
            let contacts = realm.objects(Contact).filter("name == %@", youName)
            contact = contacts.first
            setTextFields(contact)
        }
        
        toggleTextFields()
    }
    
    func setTextFields(contact: Contact)
    {
        nameTextField.text = contact.name
        numberTextField.text = contact.number
        
        emailTextField.text = contact.email
        emailTextField.placeholder = "Email"

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
                textField.backgroundColor = textFieldBG
            }
            else
            {
                textField.borderStyle = .None
                textField.backgroundColor = UIColor.clearColor()
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
        editContact()
    }
    
    func editContact()
    {
        edit = !edit
        
        if edit
        {
            self.view.alpha = 0.8
            UIView.animateWithDuration(0.4) { () -> Void in
                self.view.alpha = 1
            }
            
            toggleTextFields()
            editButton.setImage(UIImage(named: "editing"), forState: .Normal)
            nameTextField.becomeFirstResponder()
        }
        else
        {
            if checkEntry()
            {
                self.view.alpha = 0.8
                UIView.animateWithDuration(0.4) { () -> Void in
                    self.view.alpha = 1
                }
                
                toggleTextFields()
                
                if !newContact
                {
                    try! realm.write({ () -> Void in
                        self.contact.name = self.nameTextField.text!
                        self.contact.number = self.numberTextField.text!
                        self.contact.email = self.emailTextField.text!
                        print("realmWrite: Edit")
                        self.validEntry()
                    })
                }
                else
                {
                    try! realm.write({ () -> Void in
                        let newContact = Contact()
                        
                        newContact.name = self.nameTextField.text!
                        newContact.number = self.numberTextField.text!
                        
                        if self.emailTextField.text != ""
                        {
                            newContact.email = self.emailTextField.text!
                        }
                        
                        self.realm.add(newContact)
                        self.validEntry()
                    })
                }
            }
            else
            {
                edit = !edit
            }
        }
    }
    
    func checkEntry() -> Bool
    {
        var rc = false
        let validator = Validator()
        var validEdit = [false, false, false]
        
        if validator.validate("name", string: nameTextField.text!)
        {
            validEdit[0] = true
        }
        else
        {
            invalidEntry(nameTextField)
        }
        
        if validator.validate("phone", string: numberTextField.text!)
        {
            validEdit[1] = true
        }
        else
        {
            invalidEntry(numberTextField)
        }
        
        if emailTextField.text == ""
        {
            validEdit[2] = true
        }
        else if validator.validate("email", string: emailTextField.text!)
        {
            validEdit[2] = true
        }
        else
        {
            invalidEntry(emailTextField)
        }
        
        if validEdit[0] && validEdit[1] && validEdit[2]
        {
            rc = true
        }
        return rc
    }
    
    func invalidEntry(textField: UITextField)
    {
        textField.backgroundColor = UIColor.redColor()
    }
    
    func validEntry()
    {
        editButton.setImage(UIImage(named: "edit"), forState: .Normal)
        for textField in allTextFields
        {
            textField.backgroundColor = UIColor.clearColor()
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        //http://stackoverflow.com/questions/27609104/xcode-swift-formatting-text-as-phone-number
        if textField == numberTextField
        {
            let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
            let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            
            let decimalString = components.joinWithSeparator("") as NSString
            
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.characterAtIndex(0) == (1 as unichar)
            
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
            {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 10) ? false : true
            }
            var index = 0
            let formattedString = NSMutableString()
            
            if hasLeadingOne
            {
                formattedString.appendString("1 ")
                index += 1
            }
            if (length - index) > 3
            {
                let areaCode = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("(%@) ", areaCode)
                index += 3
            }
            if length - index > 3
            {
                let prefix = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            
            let remainder = decimalString.substringFromIndex(index)
            formattedString.appendString(remainder)
            textField.text = formattedString as String
            
            return false
        }
        else
        {
            return true
        }
    }

}
