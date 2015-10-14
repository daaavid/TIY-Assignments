//
//  Validator.swift
//  jackpot
//
//  Created by david on 10/14/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class Validator
{
//    var winningTicket = Ticket?()
//    var ticketToTest = Ticket?()
    
    var prizeAmount = 0
    let winningTicketArray = [1, 2, 3, 4, 5, 6,]
    var winningNumbers = Array<Ticket>()
    
    
    
    //    func validateTicket(ticketToTest: Array<Int>) -> Int
//    func validateTicket(ticketToTest: Array<Ticket>) -> Int
//    {
//        //       var rc = false
//        winningNumbers = []
//        
//        for number in ticketToTest
//        {
//            for winningNumber in winningTicketArray
//            {
//                if number == winningNumber
//                {
//                    //                    rc = true
//                    winningNumbers.append(winningNumber)
//                }
//            }
//        }
//        //        return rc
//        return winningAmount(winningNumbers)
//        
//    }
//    
//    func winningAmount(winningNumbers: Array<Int>) -> Int
//    {
//        let matchingNumbers = winningNumbers.count
//        
//        prizeAmount = 0
//        
//        if matchingNumbers == 3
//        {
//            prizeAmount = 1
//        }
//        if matchingNumbers == 4
//        {
//            prizeAmount = 5
//        }
//        if matchingNumbers == 5
//        {
//            prizeAmount = 20
//        }
//        if matchingNumbers == 6
//        {
//            prizeAmount = 100
//        }
//        
//        return prizeAmount
//    }

    func breakTicket(
    
//    func validateTicket(ticketToTest: Array<Int>) -> Int
    func validateTicket(ticketToTest: Array<Ticket>) -> Int
    {
 //       var rc = false
        winningNumbers = []
        
        for number in ticketToTest
        {
            for winningNumber in winningTicketArray
            {
                if number == winningNumber
                {
//                    rc = true
                    winningNumbers.append(winningNumber)
                }
            }
        }
//        return rc
        return winningAmount(winningNumbers)
    
    }
    
    func winningAmount(winningNumbers: Array<Int>) -> Int
    {
        let matchingNumbers = winningNumbers.count
        
        prizeAmount = 0
        
        if matchingNumbers == 3
        {
            prizeAmount = 1
        }
        if matchingNumbers == 4
        {
            prizeAmount = 5
        }
        if matchingNumbers == 5
        {
            prizeAmount = 20
        }
        if matchingNumbers == 6
        {
            prizeAmount = 100
        }
        
        return prizeAmount
    }
    
    func prizeAmountAsString(prize: Int) -> String
    {
        return "hello"
    }
}


