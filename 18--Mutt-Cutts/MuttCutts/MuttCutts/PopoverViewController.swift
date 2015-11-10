//
//  PopoverViewController.swift
//  MuttCutts
//
//  Created by david on 10/28/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var firstLocationTextField: UITextField!
    @IBOutlet weak var secondLocationTextField: UITextField!
    
    var delegate: PopoverViewControllerDelegate?
    var locationArr = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if firstLocationTextField.text! == ""
        {
            firstLocationTextField.becomeFirstResponder()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButton(sender: UIButton)
    {
        search()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        var rc = false
        if textField.text?.componentsSeparatedByString(",").count == 2
        {
            switch textField
            {
            case firstLocationTextField:
                secondLocationTextField.becomeFirstResponder()
            default:
                secondLocationTextField.resignFirstResponder()
                rc = true
                search()
            }
        }
        else
        {
            switch textField
            {
            case firstLocationTextField:
                firstLocationTextField.placeholder = "Enter a valid City, State"
            default:
                secondLocationTextField.placeholder = "Enter a valid City, State"
            }
        }


        return rc
    }
    
    func search()
    {
        if firstLocationTextField.text != nil && secondLocationTextField.text != nil
        {
            let firstLocation = firstLocationTextField.text!
            let secondLocation = secondLocationTextField.text!
            locationArr.append(firstLocation); locationArr.append(secondLocation)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            delegate?.search(firstLocation, secondLocation: secondLocation)
        }
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
