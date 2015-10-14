//
//  WinningNumberViewController.swift
//  jackpot
//
//  Created by david on 10/14/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class WinningNumberViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{

    @IBOutlet var picker: UIPickerView!
    
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
        createPickerArray()
        delegate?.numberWasChosen(53-picker.selectedRowInComponent(0))
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        //how many wheels
        return 6
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int //must return Int
    {
        //how many rows
        //        return 10 //creates 10 rows, starting from 0
        //        return cities.count //creates 2 rows, counting from cities array
        return 53
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? //must return String
    {
        //        return "\(cities[row])"
        //        return "\(cities[1])"
        //        return "\(row + 1)"
        return "\(53 - row)"
    }
    
    func createPickerArray()
    {
//        picker.
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
