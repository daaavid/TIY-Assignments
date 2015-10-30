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
    func darkSkySearchWasCompleted(results: NSDictionary, location: Location)
    //    func darkSkySearchWasCompleted(results: NSDictionary)
}

protocol GoogleZipAPIControllerProtocol
{
    func googleSearchWasCompleted(results: NSArray)
}

class WeatherTableViewController: UITableViewController, ZipPopViewControllerDelegate, UIPopoverPresentationControllerDelegate, DarkSkyAPIControllerProtocol, GoogleZipAPIControllerProtocol
{
    var locationArr = [Location]()
    var googleAPI: GoogleZipAPIController!
    
//    var darkskyAPI: DarkSkyAPIController!
//    var weatherDetailVC: WeatherDetailViewController!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        let colors = bgColorBasedOnTime()
        view.backgroundColor = UIColor(red: colors[0], green: colors[1], blue: 1, alpha: 0.8)
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
        return locationArr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell", forIndexPath: indexPath) as! WeatherCell
        
        let location = locationArr[indexPath.row]
        
        if location.city == ""
        {
            cell.cityLabel.text = "Not Found!" ; cell.quickWeatherLabel.text = "Not Found!" ; cell.quickWeatherLabel.text = ""
            locationArr.removeAtIndex(indexPath.row)
        }
        
        if location.city != ""
        {
            cell.cityLabel.text = location.city
            cell.quickWeatherLabel.text = location.weather?.summary
            if location.weather?.temp != nil
            {
                cell.tempLabel.text = String(location.weather!.temp).componentsSeparatedByString(".")[0] + "°"
            }
        }

        let colors = bgColorBasedOnTime()
        cell.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
        
        if colors[0] + colors[1] + colors[2] < 1.2
        {
            cell.color = UIColor.whiteColor()
        }
        
        return cell
    }
    
    func bgColorBasedOnTime() -> [CGFloat]
    {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let time = formatter.stringFromDate(NSDate())
        let ampm = time.componentsSeparatedByString(" ")[1]
        var hour = Int(time.componentsSeparatedByString(":")[0])!
        
        if ampm == "PM"
        {
            hour += 12
        }
        
        var colors = [CGFloat]()
        
        switch hour
        {
        case 1...6:
            colors = colorAdd(0.2)
        case 6...12:
            colors = colorAdd(0.3)
        case 12...18:
            colors = colorAdd(0.4)
        case 18...24:
            colors = colorAdd(0.3)
        default: break
        }
        
//        let color = UIColor(red: colors[0], green: colors[1], blue: colors[2], alpha: alpha)
        print(colors)
        return colors
    }
    
    
    
    //popover as table view, add a bunch of locations
    //once it reaches 5, stop
    
    
    
    
    
    
    func colorAdd(num: CGFloat) -> [CGFloat]
    {
        var colors = [CGFloat]()
        for _ in 1...3
        {
            colors.append(num)
        }
        return colors
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let chosenLocation = locationArr[indexPath.row]
        
        let weatherDetailVC = storyboard?.instantiateViewControllerWithIdentifier("WeatherDetail") as! WeatherDetailViewController
        
        weatherDetailVC.location = chosenLocation
        
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
            popVC.preferredContentSize = CGSizeMake(140, 70)
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return .None
    }

    //MARK: - Private
    
    func zipWasChosen(zip: String)
    {
        googleAPI = GoogleZipAPIController(delegate: self)
        googleAPI.search(zip)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    // MARK: - Search
    
    func googleSearchWasCompleted(results: NSArray)
    {
        dispatch_async(dispatch_get_main_queue(),
        {
            self.dismissViewControllerAnimated(true, completion: nil)

            let userLocation = Location.locationWithJSON(results)
            self.locationArr.append(userLocation)
            
            /*{
//            print("dispatch \(weatherObj[0].lng) \(weatherObj[0].lat)")

//            for x in weatherObj
//            {
//                let lat = x.lat
//                let lng = x.lng
//                
//                print("dispatch" + x.lat); print("dispatch" + x.lng)
//                
//                self.darkskyAPI.search(lat, long: lng)
//            }
                }*/
                
            let darkSkyAPI = DarkSkyAPIController(delegate: self)
            darkSkyAPI.search(userLocation)
            self.tableView.reloadData()
        })
    }
    
    func darkSkySearchWasCompleted(results: NSDictionary, location: Location)
    {
        dispatch_async(dispatch_get_main_queue(),
        {
            let weather = Weather.weatherWithJSON(results)
            
            for city in self.locationArr
            {
                if city.city == location.city
                {
                    city.weather = weather
                }
            }
            
            /*{
            
//            self.tableView.visibleCells.indexOf(location.city)
//            for cell in visibleCells.indexOf(location.city)
//            {
//                if cell.cityLabel.text! == location.city
//                {
//                    
//                }
//            }
            
//            let weatherObj = Weather.weatherWithJSON(results)
            //fetch particular weather object 
        //city and weather objcts
        //city with weather object in it
        //update city weather 
            }*/
            
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
