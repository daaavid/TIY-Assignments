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
    func numberWasChosen(winningTicketNum: Int)
//    func numberWasChosen(number: Int)
}

class LotteryTableViewController: UITableViewController, PickerDelegate
{

    @IBOutlet var numberDisplay: UIBarButtonItem!

    var ticketClass = Ticket()
    var ticketClassArray = Array<Ticket>()
//    var ticketClassArray = Array<Array<Int>>()
    var validate = Validator?()

    override func viewDidLoad()
    {
        super.viewDidLoad()
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


    @IBAction func addButton(sender: UIBarButtonItem)
    {
        ticketClassArray.append(Ticket())
        //add a new Ticket object to the tickets array
        self.tableView.reloadData()
        //reload the view so we can see the new ticket after it's set in the next function
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("LottoCell", forIndexPath: indexPath)

        let newTicket = ticketClassArray[indexPath.row]
        
        cell.textLabel?.text = newTicket.ticketString
        cell.detailTextLabel?.text = String(validate?.validateTicket(newTicket, winningTicket: newTicket))
        
        
//        cell.detailTextLabel?.text = String(validate!.validateTicket(newTicket))
//        cell.detailTextLabel?.text = String(validate!.validateTicket(ticketClassArray))
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {

    }

    func numberWasChosen(winningTicketNum: Int)
    {
        numberDisplay.title = "\(winningTicketNum)"
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
}
