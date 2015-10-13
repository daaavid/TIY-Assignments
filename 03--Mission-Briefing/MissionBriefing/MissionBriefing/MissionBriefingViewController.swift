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
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nameTextField.text = ""
        passTextField.text = ""
        messageLabel.text = ""
        textView.text = ""
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Action Handlers
    
    @IBAction func authTapped(sender: UIButton)
    {
        authenticateAgent()
    }
    
    func authenticateAgent()// -> Bool
    {
        let correctPass = "password"
        let pass = passTextField.text
        
        if nameTextField.isFirstResponder()
        {
            nameTextField.resignFirstResponder()
        }

        if nameTextField.text!.isEmpty || passTextField.text!.isEmpty || pass != correctPass
        {
            incorrectOrEmptyPass()
        }

        if let name = nameTextField.text
        {
            if let pass = passTextField.text
            {
                if pass == correctPass
                {
                    let lastName = name.characters.split(" ").map {String($0)}
                    messageLabel.text = "Good evening, Agent \(lastName[1])"
                    view.backgroundColor = UIColor(red: 0.585, green: 0.780, blue: 0.188, alpha: 1.0)
                    textView.text = "This mission will be an arduous one, fraught with peril. You will cover much strange and unfamiliar territory. Should you choose to accept this mission, Agent \(lastName[1]), you will certainly be disavowed, but you will be doing your country a great service. This message will self destruct in 5 seconds."
                }
            }
        }
    }
    
    func incorrectOrEmptyPass()
    {
        view.backgroundColor = UIColor(red: 0.780, green: 0.188, blue: 0.188, alpha: 1.0)
        messageLabel.text = "Incorrect!"
    }

}