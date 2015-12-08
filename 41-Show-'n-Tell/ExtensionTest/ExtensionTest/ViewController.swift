//
//  ViewController.swift
//  ExtensionTest
//
//  Created by david on 11/30/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testview: UIImageView!
    let imageURL = "http://ia.media-imdb.com/images/M/MV5BMTgzODgyNTQwOV5BMl5BanBnXkFtZTcwNzc0NTc0Mg@@._V1_SX300.jpg"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        testview.slideHorizontally(2.0, fromPointX: 600)
    }

    @IBAction func buttonPressed(sender: UIButton)
    {
        testview.backgroundColor = UIColor.clearColor()
        testview.downloadImgFrom(imageURL: imageURL, contentMode: .ScaleToFill)
        
        testview.slideHorizontally(0.2, fromPointX: 100)
        testview.slideHorizontally(0.2, fromPointX: -100)
    }
}

