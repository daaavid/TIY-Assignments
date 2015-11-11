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
}

class LotteryTableViewController: UITableViewController, PickerDelegate
{

    @IBOutlet var numberDisplay: UIBarButtonItem!

    var ticketClassArray = Array<Ticket>()
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("LottoCell", forIndexPath: indexPath)
        
        let newTicket = ticketClassArray[indexPath.row]
        
        cell.textLabel?.text = newTicket.ticketString
        cell.detailTextLabel?.text = newTicket.checkWinningTicket(winningTicket)
        
        if newTicket.checkWinningTicket(winningTicket) != "$ 0"
        {
            cell.backgroundColor = UIColor.greenColor()
        }
        else
        {
            cell.backgroundColor = UIColor.whiteColor()
        }

        return cell
    }
    
//MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowWinningNumbers"
        {
            let pickerVC = segue.destinationViewController as! WinningNumberViewController
            pickerVC.delegate = self
        }
    }
    

//MARK: - Action Handlers

    @IBAction func addButton(sender: UIBarButtonItem)
    {
        newTicket()
    }

    @IBAction func refreshButton(sender: UIBarButtonItem)
    {
        self.tableView.reloadData()
    }
    
    @IBAction func destroyButton(sender: UIBarButtonItem)
    {
        ticketClassArray = []
        self.tableView.reloadData()
    }
    
    
//MARK: - delegate
    
    func numberWasChosen(winningTicketNum: Array<Int>)
    {
        winningTicket = winningTicketNum
        self.tableView.reloadData()
    }

//MARK: - private

    func newTicket()
    {
        let ticket = Ticket()
        ticketClassArray.append(ticket)
        self.tableView.reloadData()
    }

}
