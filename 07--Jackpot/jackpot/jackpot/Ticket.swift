
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
    var ticketString = ""
    var ticketArray = Array<Int>()
    var winningTicket = Array<Int>()

    
    init()
    {
        ticketArray = makeTicket()
        ticketString = formatTicket(ticketArray)
        winningTicket = [1, 2, 3, 4, 5, 6,]
        checkWinningTicket()
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
            
            if checkDuplicateNumbers(ticketArray) == true
            {
                willLoop = false
                return ticketArray
            }
        }
    }
    

    func checkDuplicateNumbers(arrayToTest: Array<Int>) -> Bool
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

    func checkWinningTicket() -> Int
    {
        let winningNumber = [1, 2, 3, 4, 5, 6]
        var hits = 0
        for x in winningNumber
        {
            if ticketArray.contains(x)
            {
                hits += 1
            }
        }
        return hits
    }
    
}
