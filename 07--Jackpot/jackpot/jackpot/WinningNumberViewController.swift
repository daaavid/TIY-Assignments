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
    @IBOutlet var numLabel: UILabel!
    
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
        
        showWinningNumber()
//        let chosenValues = picker.selectedRowInComponent(0)
//        let chosenArray = [chosenValues]
//        delegate?.numberWasChosen(chosenValues)
////        delegate?.numberWasChosen(
    }
    
//    init(arrayFromViewPicker: Array<Int>)
//    {
//        newTicket = arrayFromViewPicker
//    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        //how many wheels
        return 6
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int //must return Int
    {
    
        return 53
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? //must return String
    {

        return "\(row)"
//        return["\(row)"][1]
    }

    func showWinningNumber()
    {
 //       winningNumber = [1,2,3,4,5,6]
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

    @IBAction func refreshButton(sender: UIButton)
    {
        numLabel.text = formatTicket(getWinningNumbers())
//        numLabel.text = String(picker.selectedRowInComponent(0)) + String(picker.selectedRowInComponent(1))
//        numLabel.text = "\(picker.selectedRowInComponent(0).description) + \(picker.selectedRowInComponent(1).description) + \(picker.selectedRowInComponent(2).description) + \(picker.selectedRowInComponent(3).description) + \(picker.selectedRowInComponent(4).description) + \(picker.selectedRowInComponent(5).description)  \(picker.selectedRowInComponent(6).description)"


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
