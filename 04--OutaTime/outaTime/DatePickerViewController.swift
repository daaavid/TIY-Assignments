//
//  DatePickerViewController.swift
//  outaTime
//
//  Created by Ennui on 10/8/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController
{
    
    @IBOutlet weak var picker: UIDatePicker!
    
    var delegate: DatePickerDelegate?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(animated: Bool) //function already exists in parent, so we must override it
    {
        //runs as view is about to disappear
        //viewDidDisappear after it's gone
        //viewDidAppear, viewWillAppear etc
        
//        delegate?.timerWasChosen(60-picker.s) //asking picker to give us selected row in selected (0) component
        super.viewWillDisappear(animated) //still runs viewWillDisappear, but we're going to add custom commands after
        delegate?.dateWasChosen(picker.date)
    }

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
//    {
//        //how many wheels
//        return 1
//    }
//    
//    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int //must return Int
//    {
//        //how many rows
//        //        return 10 //creates 10 rows, starting from 0
//        //        return cities.count //creates 2 rows, counting from cities array
//        return 60
//    }
//    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? //must return String
//    {
//        //        return "\(cities[row])"
//        //        return "\(cities[1])"
//        //        return "\(row + 1)"
//        return "\(60 - row)"
//    }
//    
}