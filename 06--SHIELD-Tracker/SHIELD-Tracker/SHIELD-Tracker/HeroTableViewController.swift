//
//  HeroListTableViewController.swift
//  SHIELD-Tracker
//
//  Created by david on 10/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class HeroTableViewController: UITableViewController
{
    var heroes = Array<Hero>()
//    var delegate = HeroTableDelegate?()
    
    var name: String = ""
    var homeworld: String = ""
    var power: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "S.H.I.E.L.D. Hero Tracker"
        
        loadHeroList()

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
        return heroes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HeroCell", forIndexPath: indexPath)


        let aHero = heroes[indexPath.row]
        
//        cell.textLabel?.text = aHero.name
        cell.textLabel?.text = aHero.name
        cell.detailTextLabel?.text = aHero.homeworld
        
        return cell
    }
    
    func loadHeroList()
    {
        do
        {
            let filePath = NSBundle.mainBundle().pathForResource("heroes", ofType: "json") //inside the main app bundle, there's a file called NOC, that's of type JSON. assign that filepath to filePath
            let dataFromFile = NSData(contentsOfFile: filePath!) //go to that location on the disk, go to that file, and store them as a nsdata object
            let heroData: NSArray! = try NSJSONSerialization.JSONObjectWithData(dataFromFile!, options: []) as! NSArray
            
            for heroDictionary in heroData
            {
                let aHero = Hero(dictionary: heroDictionary as! NSDictionary)
                
                heroes.append(aHero)
            }
//            self.heroes.sort { $0["name"] > $1["name"] }
//            let nameDiscriptor = NSSortDescriptor(key: "name", ascending: true, selector: Selector("caseInsensitiveCompare:"))
//            let sorted = (heroes as NSArray).sortedArrayUsingDescriptors([nameDiscriptor])
            heroes.sortInPlace{$0.name < $1.name}
            
        }
        catch let error as NSError
        {
            print(error)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let aHero = heroes[indexPath.row]
        let NVCfromTemplate = storyboard?.instantiateViewControllerWithIdentifier("HeroDetailViewController") as! HeroDetailViewController
        NVCfromTemplate.hero = aHero
        presentViewController(NVCfromTemplate, animated: true, completion: nil)
        
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "showDetailSegue"
//        {
//            let datePickerVC = segue.destinationViewController as! HeroDetailViewController
//            //data type will be uiviewcontroller. there is no data type delegate in uiviewcontroller. "i know that this is an instance of my datepickerviewcontroller" "cast"
//            datePickerVC.delegate = self
//            //self referring to the class that we're in. we're setting this class as the value for delegate
//            //does self conform to protocol? Yes, because we've signed up for it and fulfilled the conract by using the function dateWasChosen
//        }
//    }

}
