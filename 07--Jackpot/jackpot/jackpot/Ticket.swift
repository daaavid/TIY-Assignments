
//
//  Ticket.swift
//  jackpot
//
//  Created by david on 10/13/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class Ticket
{
    var ticket: String
    var lottoArray = Array<Int>()
    
    init()
    {
        for var x = 6; x > 0; x--
        {
            lottoArray.append(Int(arc4random() % 53))
        }
        ticket = String(lottoArray)
        lottoArray = []
    }
}