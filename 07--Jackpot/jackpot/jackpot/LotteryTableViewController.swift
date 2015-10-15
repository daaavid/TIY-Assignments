//
//  LotteryTableViewController.swift
//  jackpot
//
//  Created by david on 10/13/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

protocol PickerDelegate
{
    func numberWasChosen(winningTicketNum: Array<Int>)
//    func numberWasChosen(number: Int)
}

class LotteryTableViewController: UITableViewController, PickerDelegate
{

    @IBOutlet var numberDisplay: UIBarButtonItem!

    var ticketClass = Ticket()
    var ticketClassArray = Array<Ticket>()
//    var ticketClassArray = Array<Array<Int>>()
    var validate = Validator?()
    var winningTicket: Array<Int> = []
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Jackpot"
        newTicket()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ticketClassArray.count
        //we want as many rows as there are elements in the tickets array
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowWinningNumbers"
        {
            //storing string that connects to balloon
            let pickerVC = segue.destinationViewController as! WinningNumberViewController
            
            pickerVC.delegate = self
        }
    }

//MARK: - Action Handlers
    func numberWasChosen(winningTicketNum: Array<Int>)
    {
        winningTicket = winningTicketNum
//        let winningTicket = Ticket(arrayFromPicker: winningTicketNum)
        self.tableView.reloadData()
    }
    @IBAction func addButton(sender: UIBarButtonItem)
    {
        newTicket()
    }

    @IBAction func clearButton(sender: UIBarButtonItem)
    {
//        ticketClassArray = []
        self.tableView.reloadData()
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("LottoCell", forIndexPath: indexPath)

        let newTicket = ticketClassArray[indexPath.row]
    
        cell.textLabel?.text = newTicket.ticketString
        cell.detailTextLabel?.text = newTicket.checkWinningTicket(winningTicket)
//        cell.detailTextLabel?.text = ticketClass.checkWinningTicket(Ticket(arrayFromPicker: winningTicket), testTicket: newTicket)
//        cell.detailTextLabel?.text = ticketClass.checkWinningTicket(winningTicket, testTickingNum: winningTicket)
//        cell.detailTextLabel?.text = String(winningTicket)
//        cell.detailTextLabel?.text = String(validate?.validateTicket(newTicket, winningTicket: newTicket))
        
        
//        cell.detailTextLabel?.text = String(validate!.validateTicket(newTicket))
//        cell.detailTextLabel?.text = String(validate!.validateTicket(ticketClassArray))
        
        return cell
    }
    
    func newTicket()
    {
        ticketClassArray.append(Ticket())
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //nothing to see here
    }


    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
}
