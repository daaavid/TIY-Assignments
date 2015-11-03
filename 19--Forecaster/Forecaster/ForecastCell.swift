//
//  ForecastCell.swift
//  Forecaster
//
//  Created by david on 10/31/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var daySummaryLabel: UILabel!
    
    @IBOutlet var tempMinLabel: UILabel!
    @IBOutlet var tempMaxLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    
    var hasBeenAnimated = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}