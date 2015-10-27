//
//  FriendDetailViewController.swift
//  Github-Friends
//
//  Created by david on 10/27/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController
{
    let usernameLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 500, height: 40))
    let nameLabel = UILabel(frame: CGRect(x: 0, y: 80, width: 500, height: 40))
    let emailLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 500, height: 40))
    let reposLabel = UILabel(frame: CGRect(x: 0, y: 120, width: 500, height: 40))
    
    var friend = Friend?()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        showLabels()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLabels()
    {
        view.backgroundColor = UIColor.whiteColor()
        usernameLabel.center.x = view.center.x + 50
        nameLabel.center.x = usernameLabel.center.x
        emailLabel.center.x = usernameLabel.center.x
        reposLabel.center.x = usernameLabel.center.x
        
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(reposLabel)

    }
    
    func populateLabels()
    {
        usernameLabel.text = "Username: " + String(friend!.username)
        nameLabel.text = "Real Name: " + String(friend!.name)
        emailLabel.text = "Email: " + String(friend!.email)
        reposLabel.text = "Repos: " + String(friend!.repos)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
