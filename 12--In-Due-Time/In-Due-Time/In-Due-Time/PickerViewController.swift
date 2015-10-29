//
//  PickerViewController.swift
//  In-Due-Time
//
//  Created by david on 10/21/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet var picker: UIDatePicker!
    var delegate: PickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        delegate?.dateWasChosen(formatTime(picker.date))
    }
    
    func formatTime(timeToFormat: NSDate) -> String
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMM dd", options: 0, locale: NSLocale(localeIdentifier: "en-US"))
        let formattedTime = formatter.stringFromDate(timeToFormat)//.uppercaseString
        return formattedTime
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
