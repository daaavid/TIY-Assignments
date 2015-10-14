
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
    var ticket = ""
    var ticketArray = Array<Int>()
    
    init()
    {
//        for var x = 6; x > 0;
//        {
//            let number = Int(arc4random() % 53)
//            if self.checkDuplicate(number) == false
//            {
//                ticketArray.append(number)
//                dupNumber = number
//                x--
//                
//            }
//        }
//        
//        ticket = String(ticketArray)
//        ticketArray = []
        
        ticket = formatTicket(makeTicket())
        ticketArray = makeTicket()
    }
    
    func makeTicket() -> Array<Int>
    {
        var willLoop = true
        while willLoop == true
        {
            ticketArray = []
            
            for var x = 6; x > 0; x--
            {
                let number = Int(1 + arc4random() % 52)
                ticketArray.append(number)
                
            }
            
            if checkDuplicate(ticketArray) == true
            {
                willLoop = false
                return ticketArray
            }
        }
    }
    

    func checkDuplicate(arrayToTest: Array<Int>) -> Bool
    {
        let arrayFromSet = Set<Int>(arrayToTest)
        if arrayToTest.count == arrayFromSet.count
        {
            return true
        }
        else
        {
            return false
        }
    }

    func formatTicket(ticketArray: Array<Int>) -> String
    {
        var ticketAsString = ""
        for number in ticketArray
        {
            ticketAsString = ticketAsString + "\(number)" + " "
        }
        return ticketAsString
    }

    
}
