//
//  ProfileViewController.swift
//  Contacts
//
//  Created by david on 11/20/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController
{
    var contact: Contact?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let _ = contact
        {
            print(contact)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
