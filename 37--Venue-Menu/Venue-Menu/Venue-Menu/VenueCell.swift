//
//  VenueCell.swift
//  Venue-Menu
//
//  Created by david on 11/26/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class VenueCell: UITableViewCell
{
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
    }
}
