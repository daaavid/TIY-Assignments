//
//  LoginViewController.swift
//  In-Due-Time
//
//  Created by david on 11/4/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate
{
    let validator = Validator()
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.text = "david.j.c.johnson@gmail.com"
        passwordTextField.text = "million"
        
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
    
    func userCanSignIn() -> Bool
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
            login()
            rc = true
        }
        
        return rc
    }
    
    @IBAction func loginTapped(sender: UIButton)
    {
        login()
    }
    
    func login()
    {
        let password = passwordTextField.text!
        let username = usernameTextField.text!
        
        PFUser.logInWithUsernameInBackground(username, password: password)
            {
                (user: PFUser?, error: NSError?) -> Void in
                if error == nil
                {
//                    let account = Account.loadUser(username)
                    print("Login successful")
//                    let VC = self.storyboard?.instantiateViewControllerWithIdentifier("mapVC") as! ViewController
////                    todoVC.account = account
//                    self.navigationController?.pushViewController(VC, animated: true)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else
                {
                    print(error?.localizedDescription)
                    self.passwordTextField.text = ""
                    self.passwordTextField.placeholder = "Invalid password"
                }
        }
    }
}
