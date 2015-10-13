//
//  LotteryTableViewController.swift
//  jackpot
//
//  Created by david on 10/13/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class LotteryTableViewController: UITableViewController
{

//    var lottoNumbersArray = Array<Int>()
//    var lottoNumbersArrArr = Array<Array<Int>>()
    
    var tickets = Array<Ticket>()
    //making a variable array that can be filled with tickets
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        var index = 10
//        while index > 0
//        {
//            for var x = 6; x > 0; x--
//            {
//                lottoNumbersArray.append(Int(arc4random() % 53))
//            }
//            
//            lottoNumbersArrArr.append(lottoNumbersArray)
//            lottoNumbersArray = []
//            index--
//        }
    
        //while index < 10
//        for var i = 10; i > 0; i--
//        {
        
//        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
//        return lottoNumbersArrArr.count
        return tickets.count
        //we want as many rows as there are elements in the tickets array
    }

    @IBAction func addButton(sender: UIBarButtonItem)
    {
//        createLottoNumbers()
        tickets.append(Ticket())
        //add a new Ticket object to the tickets array
        self.tableView.reloadData()
        //reload the view so we can see the new ticket after it's set in the next function
    }
    
//    func createLottoNumbers()//indexNum: Int) -> String
//    {
//        self.tableView.reloadData()
//
//        for var x = 6; x > 0; x--
//        {
//            lottoNumbersArray.append(Int(arc4random() % 53))
//        }
//
//        lottoNumbersArrArr.insert((lottoNumbersArray), atIndex: indexNum)
//        lottoNumbersArray = []
//        let ticketString = String(lottoNumbersArrArr)
//        lottoNumbersArrArr = []
//        
//        return ticketString
//        self.tableView.reloadData()
//    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("LottoCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = tickets[indexPath.row].ticket
        //set the cell text to be equal to a ticket from the tickets array at the index path of the row
        
//        cell.textLabel?.text = String(lottoNumbersArrArr[/*indexPath.row */0])
//        cell.textLabel?.text = createLottoNumbers(indexPath.row)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
//        let aNumber = lottoNumbersArray[indexPath.row]
//        createLottoNumbers(aNumber)

    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
