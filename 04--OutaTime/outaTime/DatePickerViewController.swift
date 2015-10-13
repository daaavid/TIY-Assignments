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
        super.viewWillDisappear(animated)
        delegate?.dateWasChosen(picker.date)
        //if delegate /has/ a function, call dateWasChosen. if not, don't bother
        //as the view disappears, we pull the date from the picker and jump to dateWasChosen
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}