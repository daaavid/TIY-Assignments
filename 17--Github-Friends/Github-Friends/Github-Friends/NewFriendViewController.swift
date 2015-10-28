//
//  ViewController.swift
//  Github-Friends
//
//  Created by david on 10/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

protocol APIControllerProtocol
{
    func didReceiveAPIResults(results: NSDictionary)
}

class NewFriendViewController: UIViewController, UITextFieldDelegate , APIControllerProtocol
{
    var friends = [Friend]()
    var api: APIController!
    var flvc = FriendListTableViewController()
    var delegate: NewFriendViewControllerProtocol?
    
    let searchTextField = UITextField(frame: CGRect(x: 0, y: 90, width: 140, height: 30))
    let searchButton = UIButton(frame: CGRect(x: 0, y: 120, width: 100, height: 30))
    let cancelButton = UIButton(frame: CGRect(x: 0, y: 150, width: 100, height: 30))
    
    override func viewDidLoad()
    {
        api = APIController(delegate: self)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showViews()
        
        if searchTextField.text == ""
        {
            searchTextField.becomeFirstResponder()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
    }
    // MARK: - View
    
    func showViews()
    {
        view.backgroundColor = UIColor.grayColor()
        
        searchTextField.placeholder = "Name"
        searchTextField.center.x = view.center.x
        searchTextField.textAlignment = .Center
        
        searchButton.setTitle("Search", forState: UIControlState.Normal)
        searchButton.center.x = searchTextField.center.x
        
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.center.x = searchTextField.center.x
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(cancelButton)
        
        searchButton.addTarget(self, action: "searchButton:", forControlEvents: UIControlEvents.TouchUpInside)
        cancelButton.addTarget(self, action: "cancel:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    // MARK: - Action Handlers
    
    func searchButton(sender: UIButton)
    {
        search()
    }
    
    func cancel(sender: UIButton)
    {
        api.cancelSearch()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Misc
    
    func search()
    {        
        if searchTextField.text != ""
        {
            let username = searchTextField.text!
            api = APIController(delegate: self)
            api.searchGithubFor(username)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        var rc = false
        if textField.text != ""
        {
            textField.resignFirstResponder()
            rc = true
            search()
        }
        return rc
    }

    func didReceiveAPIResults(results: NSDictionary)
    {
        dispatch_async(dispatch_get_main_queue(), {
            
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
            self.delegate?.searchWasCompleted(results)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            print("didReceiveAPIResults")
        })
    }

}

