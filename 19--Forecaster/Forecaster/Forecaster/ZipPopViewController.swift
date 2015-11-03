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
//    var locationArr = [Location]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if zipTextField.text! == ""
        {
            zipTextField.becomeFirstResponder()
            zipTextField.addTarget(self, action:"startedEditing", forControlEvents:UIControlEvents.EditingChanged)
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
    
    func startedEditing()
    {
        if zipTextField.text! == ""
        {
            setPlaceholderText()
        }

        if Int(zipTextField.text!) != nil
        {
            zipCitySegmentedControl.selectedSegmentIndex = 0
            changeKeyboard(0)
        }
        else if zipTextField.text!.characters.count > 0
        {
            zipCitySegmentedControl.selectedSegmentIndex = 1
            changeKeyboard(1)
        }
    }
    
    @IBAction func zipCitySegmentedControl(sender: UISegmentedControl)
    {
        switch zipCitySegmentedControl.selectedSegmentIndex
        {
        case 0:
            changeKeyboard(0)
        case 1:
            changeKeyboard(1)
        default: break
        }
        
        setPlaceholderText()
    }
    
    func changeKeyboard(cc: Int)
    {
        switch cc
        {
        case 0:
            zipTextField.resignFirstResponder()
            zipTextField.keyboardType = UIKeyboardType.NumberPad
            zipTextField.becomeFirstResponder()
        case 1:
            zipTextField.resignFirstResponder()
            zipTextField.keyboardType = UIKeyboardType.Alphabet
            zipTextField.becomeFirstResponder()
        default: break
        }
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
        if testAddress.count == 2// && testAddress[1].componentsSeparatedByString(" ")[1].characters.count == 2
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
