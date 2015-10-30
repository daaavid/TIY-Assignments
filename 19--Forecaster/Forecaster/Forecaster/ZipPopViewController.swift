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
        if isZip(textField.text!)
        {
            search(Int(textField.text!)!)
            rc = true
        }
        return rc
    }
    
    @IBAction func addCity(sender: UIButton)
    {
        if isZip(zipTextField.text!)
        {
            search(Int(zipTextField.text!)!)
        }
    }
    
    func isZip(zip: String) -> Bool
    {
        var rc = false
        
        if zip.characters.count == 5 && Int(zip) != nil
        {
            rc = true
        }
        else
        {
            print("false")
            zipTextField.text = ""
            zipTextField.placeholder = "Enter Zip"
        }
        
        return rc
    }
    
    func search(zip: Int)
    {
        let zipStr = String(zip)
        delegate?.zipWasChosen(zipStr)
    }
}
