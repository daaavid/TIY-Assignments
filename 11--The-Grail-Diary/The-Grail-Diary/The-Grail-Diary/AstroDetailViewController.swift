//
//  AstroDetailViewController.swift
//  The-Grail-Diary
//
//  Created by david on 10/19/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class AstroDetailViewController: UIViewController {

    var astro = SolSystem?()
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var distLabel: UILabel!
    @IBOutlet var orbitLabel: UILabel!
    @IBOutlet var massLabel: UILabel!
    @IBOutlet var picture: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        nameLabel.text = astro!.name
        distLabel.text = astro!.distance
        orbitLabel.text = astro!.orbit
        massLabel.text = astro!.mass
        picture.image = UIImage(named: astro!.picture)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
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
