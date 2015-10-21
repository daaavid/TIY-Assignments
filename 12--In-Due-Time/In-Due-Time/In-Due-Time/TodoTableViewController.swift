//
//  TodoTableViewController.swift
//  In-Due-Time
//
//  Created by david on 10/20/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import CoreData

class TodoTableViewController: UITableViewController, UITextFieldDelegate//, DatePickerDelegate
{
    
    var todoArray = Array<Todo>()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let checkImg = UIImage(named: "checked.png")
    let uncheckImg = UIImage(named: "unchecked.png")

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "To do"
        
        let fetchRequest = NSFetchRequest(entityName: "Todo")
        do {
            let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Todo]
            todoArray = fetchResults!
        }
        catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
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
        return todoArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoCell", forIndexPath: indexPath) as! TodoCell

        let todoItem = todoArray[indexPath.row]
        
        if todoItem.title == nil
        {
            cell.titleTextField.becomeFirstResponder()
            cell.checkbox.setImage(uncheckImg, forState: UIControlState.Normal)
        }
        else
        {
            cell.titleTextField.text = todoItem.title
        }
        
        if todoItem.isDone
        {
            cell.checkbox.setImage(checkImg, forState: UIControlState.Normal)
            cell.backgroundColor = UIColor(red: 0.28, green: 0.20, blue: 0.52, alpha: 1)
            cell.titleTextField.textColor = UIColor.whiteColor()
        }
        else
        {
            cell.checkbox.setImage(uncheckImg, forState: UIControlState.Normal)
            cell.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
            cell.titleTextField.textColor = UIColor.blackColor()
        }
    
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let todoItem = todoArray[indexPath.row]

        if todoItem.isDone
        {
            let todoItem = todoArray[indexPath.row]
            
            if editingStyle == .Delete
            {
                todoArray.removeAtIndex(indexPath.row)
                managedObjectContext.deleteObject(todoItem)
            }
            
            saveSlot1()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    //MARK: - ACTION HANDLERS 3: REVENGE OF THE HANDLERS
    @IBAction func addTodo(sender: UIBarButtonItem)
    {
        let todoItem = NSEntityDescription.insertNewObjectForEntityForName("Todo", inManagedObjectContext: managedObjectContext) as! Todo
        todoArray.append(todoItem)
        tableView.reloadData()
    }
    
    @IBAction func checkboxPressed(sender: UIButton)
    {
        let contentView = sender.superview
        let cell = contentView?.superview as! TodoCell
        let indexPath = tableView.indexPathForCell(cell)
        let todoItem = todoArray[indexPath!.row]

        if sender.currentImage == uncheckImg
        {
            cell.checkbox.setImage(checkImg, forState: UIControlState.Normal)
            todoItem.isDone = true
//            cell.backgroundColor = UIColor.lightTextColor()
            cell.backgroundColor = UIColor(red:0.38, green:0.00, blue:0.02, alpha:1.0)
            cell.titleTextField.textColor = UIColor.whiteColor()
        }
        else
        {
            cell.checkbox.setImage(uncheckImg, forState: UIControlState.Normal)
            todoItem.isDone = false
            cell.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
            cell.titleTextField.textColor = UIColor.blackColor()
        }

        tableView.reloadData()
        saveSlot1()
    }
    
    //MARK: - Delegates
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        var rc = false
        
        if textField.text != ""
        {
            rc = true
            let contentView = textField.superview
            let cell = contentView?.superview as! TodoCell
            let indexPath = tableView.indexPathForCell(cell)
            let todoItem = todoArray[indexPath!.row]
            todoItem.title = textField.text
            textField.resignFirstResponder()
            saveSlot1()
        }
        
        return rc
    }
    
    //MARK: - Private
    
    func saveSlot1()
    {
        do
        {
            try managedObjectContext.save()
            //save all managed objects
        }
        catch
        {
            let nserror = error as NSError
            NSLog("WHOOPS SOMETHING WENT WRONG AHAHA \(nserror), \(nserror.userInfo)")
            abort() //<<<<<
        }
    }
}
