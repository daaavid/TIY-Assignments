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
    var winningNumber: Array<Int> = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        delegate?.numberWasChosen(getWinningNumbers())
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        //how many wheels
        return 6
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int //must return Int
    {
        //how many rows
        return 53
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? //must return String
    {
        return "\(row)"
    }

    func getWinningNumbers() -> Array<Int>
    {
        for var x = 0; x <= 5; x++
        {
            winningNumber.append(picker.selectedRowInComponent(x))
        }
        let tempArray = winningNumber
        winningNumber = []
        return tempArray
    }
    
    func formatTicket(ticketArray: Array<Int>) -> String
    {
        var ticketAsString = ""
        for number in ticketArray
        {
            ticketAsString = ticketAsString + "\(number)" + " "
        }
        return ticketAsString
    }
}
