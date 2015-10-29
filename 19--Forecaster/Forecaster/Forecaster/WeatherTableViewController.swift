//
//  WeatherTableViewController.swift
//  Forecaster
//
//  Created by david on 10/29/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

protocol ZipPopViewControllerDelegate
{
    func zipWasChosen(zip: String)
}

protocol DarkSkyAPIControllerProtocol
{
    func darkSkySearchWasCompleted(results: NSDictionary)
}

protocol GoogleZipAPIControllerProtocol
{
    func googleSearchWasCompleted(results: NSArray)
}

class WeatherTableViewController: UITableViewController, ZipPopViewControllerDelegate, UIPopoverPresentationControllerDelegate, DarkSkyAPIControllerProtocol, GoogleZipAPIControllerProtocol
{
    var weatherArr = [Weather]()
    var googleAPI: GoogleZipAPIController!
    var darkskyAPI: DarkSkyAPIController!
//    var weatherDetailVC: WeatherDetailViewController!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        print("videogames")
//        googleAPI = GoogleZipAPIController(delegate: self)
//        googleAPI.search("53094")
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = true


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherArr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell", forIndexPath: indexPath) as! WeatherCell
        
        let weather = weatherArr[indexPath.row]
//        cell.textLabel?.text = weather.city
//        cell.detailTextLabel?.text = "\(weather.lat), \(weather.lng)"
        cell.cityLabel.text = weather.city
        cell.quickWeatherLabel.text = weather.lat
        cell.tempLabel.text = weather.lng
        
        print(weather.lat)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let chosenWeather = weatherArr[indexPath.row]
        
        let weatherDetailVC = storyboard?.instantiateViewControllerWithIdentifier("WeatherDetail") as! WeatherDetailViewController
        
        weatherDetailVC.weather = chosenWeather
        
        weatherDetailVC.populate()
        
        navigationController?.pushViewController(weatherDetailVC, animated: true)
    }
    
    //MARK: - View
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "popover"
        {
            let popVC = segue.destinationViewController as! ZipPopViewController
            popVC.popoverPresentationController?.delegate = self
            popVC.delegate = self
            
            popVC.view.backgroundColor = UIColor.whiteColor()
            popVC.preferredContentSize = CGSizeMake(200, 40)
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }

    //MARK: - Private
    
    func zipWasChosen(zip: String)
    {
        print(zip)
        
        googleAPI = GoogleZipAPIController(delegate: self)
        googleAPI.search(zip)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func darkSkySearchWasCompleted(results: NSDictionary)
    {
        dispatch_async(dispatch_get_main_queue(), {
 //           self.weatherArr = self.weatherArr + Weather.locationWithJSON(results)
            self.tableView.reloadData()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
    
    func googleSearchWasCompleted(results: NSArray)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        dispatch_async(dispatch_get_main_queue(), {
            let weatherObj = Weather.locationWithJSON(results)
            self.weatherArr = self.weatherArr + weatherObj
//            self.darkskyAPI.search(weatherObj[0].lng, long: weatherObj[0].lat)
            
            self.tableView.reloadData()
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
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
