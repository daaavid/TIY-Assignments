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
    @IBOutlet var zipCitySegmentedControl: UISegmentedControl!

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
        if checkTextField(textField.text!)
        {
            search(textField.text!)
            rc = true
        }
        return rc
    }
    
    @IBAction func zipCitySegmentedControl(sender: UISegmentedControl)
    {
        switch zipCitySegmentedControl.selectedSegmentIndex
        {
        case 0:
            zipTextField.resignFirstResponder()
            zipTextField.keyboardType = UIKeyboardType.NumberPad
            zipTextField.becomeFirstResponder()
            
            self.reloadInputViews()
        case 1:
            zipTextField.resignFirstResponder()
            zipTextField.keyboardType = UIKeyboardType.Alphabet
            zipTextField.becomeFirstResponder()
            
            self.reloadInputViews()

        default: break
        }
        
        setPlaceholderText()
    }
    
//    @IBAction func addCity(sender: UIButton)
//    {
//        if isZip(zipTextField.text!)
//        {
//            search(Int(zipTextField.text!)!)
//        }
//    }
   
    @IBAction func goButton(sender: UIButton)
    {
        if checkTextField(zipTextField.text!)
        {
            search(zipTextField.text!)
        }
    }
    
    func checkTextField(text: String) -> Bool
    {
        var rc = false
        switch zipCitySegmentedControl.selectedSegmentIndex
        {
        case 0:
            if isZip(text)
            {
                rc = true
            }
            else
            {
                setPlaceholderText()
            }
        case 1:
            if isAddress(text)
            {
                rc = true
            }
            else
            {
                setPlaceholderText()
            }
        default: break
        }
        return rc
    }
    
    func isAddress(address: String) -> Bool
    {
        var rc = false
        
        let testAddress = address.componentsSeparatedByString(",")
        if testAddress.count == 2 && testAddress[1].componentsSeparatedByString(" ")[1].characters.count == 2
        {
            rc = true
        }
        return rc
    }
    
    func isZip(zip: String) -> Bool
    {
        var rc = false
        
        if zip.characters.count == 5 && Int(zip) > 00051
        {
            rc = true
        }
        
        return rc
    }
    
    func search(searchTerm: String)
    {
        var cc = 2
        switch zipCitySegmentedControl.selectedSegmentIndex
        {
        case 0: cc = 0
        case 1: cc = 1
        default: break
        }
        
        delegate?.zipWasChosen(searchTerm, cc: cc)
    }
    
    func setPlaceholderText()
    {
        switch zipCitySegmentedControl.selectedSegmentIndex
        {
        case 0:
            zipTextField.text = ""
            zipTextField.placeholder = "Enter Zip"

        case 1:
            zipTextField.text = ""
            zipTextField.placeholder = "Enter City, ST"
        default: break
        }
    }
}
