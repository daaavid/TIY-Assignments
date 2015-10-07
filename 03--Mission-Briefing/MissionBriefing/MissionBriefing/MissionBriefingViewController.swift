//
//  MissionBriefingViewController.swift
//  Mission Briefing
//
//  Created by Ben Gohlke on 10/7/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class MissionBriefingViewController: UIViewController, UITextFieldDelegate
{
    // Place IBOutlet properties below
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nameTextField.text = ""
        passTextField.text = ""
        messageLabel.text = ""
        textView.text = ""
        
        //
        // 3. The three UI elements need to be emptied on launch
        //    Hint: there is a string literal that represents empty
        //
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Handlers
    
    @IBAction func goTapped(sender: UIButton)
    {
        authenticateAgent()
    }
    
    func authenticateAgent() -> Bool
    {
        // This will cause the keyboard to dismiss when the authenticate button is tapped
        var rc = false
        let correctPass = "password"
        
//        let name2 = nameTextField.text
//        let pass2 = passTextField.text
        
        if nameTextField.isFirstResponder()
        {
            nameTextField.resignFirstResponder()
        }
        
//        if passTextField.isFirstResponder()
//        {
//            passTextField.resignFirstResponder()
//        }
        
        //
        // 4. Check whether there is text in BOTH the name and password textfields
        //
        
        if let name = nameTextField.text
        {
            if let pass = passTextField.text
            {
                if pass == correctPass
                {
                    rc = true
                    let lastName = name.characters.split(" ").map {String($0)}
                    messageLabel.text = "Good evening, Agent \(lastName[1])"
                    view.backgroundColor = UIColor(red: 0.585, green: 0.780, blue: 0.188, alpha: 1.0)
                    textView.text = "This mission will be an arduous one, fraught with peril. You will cover much strange and unfamiliar territory. Should you choose to accept this mission, Agent \(lastName[1]), you will certainly be disavowed, but you will be doing your country a great service. This message will self destruct in 5 seconds."
                }
            }
            //
            // 5. The greeting label needs to be populated with the the string "Good evening, Agent #", where # is the last name of
            //    the agent logging in. The agent's full name is listed in the text field, but you need to pull out just the last
            //    name. Open the Apple Documentation and go to the page for NSString. There is a section in the left called "Dividing
            //    Strings". You should be able to find a method that allows you to break up a string using a delimiter. In our case,
            //    the delimiter would be a space character.
            //
            
            
            
            
            
            
            //
            // 6. The mission briefing textview needs to be populated with the briefing from HQ, but it must also include the last
            //    name of the agent that logged in. Perhaps you could use the text in the textfield to get the agent's last name.
            //    How would you inject that last name into the paragraph of the mission briefing?
            //    Set the textview text property to the paragraph in "MissionBriefing.txt"
            //
            
            
            
            
            
            //
            // 7. The view's background color needs to switch to green to indicate a successful login by the agent.
            //
            //    The color's RGB value is Red: 0.585, Green: 0.78, Blue: 0.188 with an alpha of 1. There is a class method on the
            //    UIColor class that returns a color object with custom defined RGBA values. Open the documentation and look for a
            //    method on UIColor that can take red, green, blue and alpha values as arguments.
            //
            //    Once you have the color object, you should be able to set the view's background color to this object.
            //
            
        
        }
        else
        {
//           view.backgroundColor = UIColor(red: 0.780, green: 0.188, blue: 0.188, alpha: 1.0)
//           view.backgroundColor = UIColor.redColor()
            //
            // 8. The view's background color needs to switch to red to indicate a failed login by the agent.
            //
            //    The color's RGB value is Red: 0.78, Green: 0.188, Blue: 0.188 with an alpha of 1. There is a class method on the
            //    UIColor class that returns a color object with custom defined RGBA values. Open the documentation and look for a
            //    method on UIColor that can take red, green, blue and alpha values as arguments.
            //
            //    Once you have the color object, you should be able to set the view's background color to this object.
            //
            
            
            
            
            
            
        }
        
        return rc
        
    }

}