//
//  HeroDetailViewController.swift
//  SHIELD-Tracker
//
//  Created by david on 10/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

//@objc protocol HeroTableDelegate
//{
//    func didSelectHero()
//}

class HeroDetailViewController: UIViewController//, HeroTableDelegate
{

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var homeworldLabel: UILabel!
    @IBOutlet var powerLabel: UILabel!
    @IBOutlet var heroPortrait: UIImageView!
    
    var hero = Hero?()
    
//    func didSelectHero()
//    {
//        nameLabel.text = Hero.name
//        homeworldLabel.text = Hero.homeworld
//        powerLabel.text = Hero.powers
//    }

//    let aHero = heroes[indexPath.row]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        nameLabel.text = hero!.name
        homeworldLabel.text = hero!.homeworld
        powerLabel.text = hero!.powers
//        heroPortrait.image = UIImage(named: "cap")
        heroPortrait.image = UIImage(named: hero!.portrait)
    }


//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "showDetailSegue"
//        {
//            
//        }
//    }

}
