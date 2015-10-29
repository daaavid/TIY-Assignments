//
//  ZipPopViewController.swift
//  Forecaster
//
//  Created by david on 10/29/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class ZipPopViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var zipTextField: UITextField!

    var delegate: ZipPopViewControllerDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if zipTextField.text! == ""
        {
            zipTextField.becomeFirstResponder()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        var rc = false
        if textField.text != "" && textField.text?.characters.count == 5
        {
            print(textField.text!)
            if let _ = Int(textField.text!)
            {
                print(textField.text!)
                rc = true
                delegate?.zipWasChosen(textField.text!)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        else
        {
            textField.text = "Please enter a valid zip code"
        }
        return rc
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
