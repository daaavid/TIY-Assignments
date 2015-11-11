//
//  RegisterViewController.swift
//  In-Due-Time
//
//  Created by david on 11/4/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate
{
    let validator = Validator()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if usernameTextField.text! == ""
        {
            usernameTextField.becomeFirstResponder()
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccTapped(sender: UIButton)
    {
        createAccount()
    }
    
    func userCanRegister() -> Bool
    {
        var rc = false
        let username = usernameTextField.text!
        if passwordTextField.text != "" && validator.isValidEmail(username)
        {
            rc = true
        }
        if validator.isValidEmail(username) == false
        {
            usernameTextField.text = ""
            usernameTextField.placeholder = "Please enter a valid email"
            rc = false
        }
        
        return rc
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        var rc = false
        if usernameTextField.text != ""
        {
            rc = true
            usernameTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        if usernameTextField.text != "" && passwordTextField.text != ""
        {
            rc = true
            createAccount()
        }
        
        return rc
    }
    
    func createAccount()
    {
        if userCanRegister()
        {
            let user = PFUser()
            user.username = usernameTextField.text!
            user.password = passwordTextField.text!
            
            user.signUpInBackgroundWithBlock
            {
                    (succeeded: Bool, error: NSError?) -> Void in
                    
                    if !succeeded
                    {
                        print(error?.localizedDescription)
                    }
                    else
                    {
                        self.navigationController?.popToRootViewControllerAnimated(true)
                    }
            }
        }
    }
}
