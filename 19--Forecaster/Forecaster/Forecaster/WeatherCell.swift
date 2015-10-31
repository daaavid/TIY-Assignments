//
//  WeatherCell.swift
//  Forecaster
//
//  Created by david on 10/29/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var quickWeatherLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var img: UIImageView!
    var hasBeenAnimated = false
        
    override func awakeFromNib()
    {
        super.awakeFromNib()
//        cityLabel.textColor = UIColor(red: bgColor()[0], green: bgColor()[0], blue: bgColor()[0], alpha: 1)
//        quickWeatherLabel.textColor = UIColor(red: bgColor()[0], green: bgColor()[0], blue: bgColor()[0], alpha: 1)
//        tempLabel.textColor = UIColor(red: bgColor()[0], green: bgColor()[0], blue: bgColor()[0], alpha: 1)
        
//        UIView.animateWithDuration(0.5, animations: {
//            var img = self.img.frame
//            img.origin.x += img.size.width
//            
//            self.img.frame = img
//        })
        
//        UIView.animateWithDuration(0.5, delay: 3.5, options: .CurveEaseOut, animations: {
//            var img = self.img.frame
//            img.origin.x += img.size.width
//            
//            self.img.frame = img
//            
//            
//            }, completion: { finished in
//        })
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bgColor() -> [CGFloat]
    {
        let color = colorBasedOnTime()
        let colorsArr = color.bgColorBasedOnTime(-0.2)
        var colors = [CGFloat]()
        for x in colorsArr
        {
            colors.append(CGFloat(x))
        }
        
        return colors
    }


}
