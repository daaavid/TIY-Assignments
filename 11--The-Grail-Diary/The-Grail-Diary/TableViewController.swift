//
//  GrailTableViewController.swift
//  The-Grail-Diary
//
//  Created by david on 10/19/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController
{
    var astro = Array<SolSystem>()
    var name: String = ""
    var distance: String = ""
    var orbit: String = ""
    var mass: String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "S O L A R   S Y S T E M"
        
        loadAstroList()

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
//        return astro.count
        return astro.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as! AstroCell

        let astroBody = astro[indexPath.row]
        
        cell.nameLabel.text = astroBody.name
        cell.tempLabel.text = "MASS: " + astroBody.mass
        cell.distLabel.text = "DISTANCE: " + astroBody.distance
        cell.orbitLabel.text = "ORBIT: " + astroBody.orbit
        cell.picture.image = UIImage(named: astroBody.picture)

        return cell
    }

    func loadAstroList()
    {
        do
        {
            let filePath = NSBundle.mainBundle().pathForResource("astro", ofType: "json")
            let dataFromFile = NSData(contentsOfFile: filePath!)
            let astroData: NSArray! = try NSJSONSerialization.JSONObjectWithData(dataFromFile!, options: []) as! NSArray
            
            for astroDict in astroData
            {
                let astroBody = SolSystem(dictionary: astroDict as! NSDictionary)
                astro.append(astroBody)
            }
        }
        catch let error as NSError
        {
            print(error)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let astroBody = astro[indexPath.row]
        let ViewControllerfromTemplate = storyboard?.instantiateViewControllerWithIdentifier("AstroDetailViewController") as! AstroDetailViewController
        ViewControllerfromTemplate.astro = astroBody
        //        presentViewController(NVCfromTemplate, animated: true, completion: nil)
        navigationController?.pushViewController(ViewControllerfromTemplate, animated: true)
        
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
