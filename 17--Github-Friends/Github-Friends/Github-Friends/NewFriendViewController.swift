//
//  ViewController.swift
//  Github-Friends
//
//  Created by david on 10/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class NewFriendViewController: UIViewController
{
    let searchTextField = UITextField(frame: CGRect(x: 0, y: 200, width: 100, height: 40))
    let searchButton = UIButton(frame: CGRect(x: 0, y: 240, width: 100, height: 40))
    let cancelButton = UIButton(frame: CGRect(x: 0, y: 240, width: 100, height: 40))
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showViews()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showViews()
    {
        view.backgroundColor = UIColor.whiteColor()
        
        searchTextField.placeholder = "Name"
        searchTextField.center.x = view.center.x
        searchTextField.textAlignment = .Center
        
        searchButton.setTitle("Search", forState: UIControlState.Normal)
        searchButton.center.x = searchTextField.center.x - 50
        
        cancelButton.setTitle("Search", forState: UIControlState.Normal)
        cancelButton.center.x = searchTextField.center.x + 50
        
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(cancelButton)
    }
}

