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
    
    var color = UIColor.whiteColor()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityLabel.textColor = color
        quickWeatherLabel.textColor = color
        tempLabel.textColor = color
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
