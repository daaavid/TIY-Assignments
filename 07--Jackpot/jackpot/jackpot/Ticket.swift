
//
//  Ticket.swift
//  jackpot
//
//  Created by david on 10/13/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//


import Foundation

//protocol PickerDelegate
//{
//    func numberWasChosen(winningTicketNum: Array<Int>)
//    //    func numberWasChosen(number: Int)
//}

class Ticket//: PickerDelegate
{
    var ticketString = ""
    var ticketArray = Array<Int>()
    var winningTicket = Array<Int>()

    
    init()
    {
        ticketArray = makeTicket()
        ticketString = formatTicket(ticketArray)
//        winningTicket = [1, 2, 3, 4, 5, 6,]
////        checkWinningTicket()
    }
    
    init(arrayFromPicker: Array<Int>)
    {
        winningTicket = arrayFromPicker
    }
    
//    func setWinningTicket()
//    {
//        
//    }
    
    func makeTicket() -> Array<Int>
    {
        var willLoop = true
        while willLoop == true
        {
            ticketArray = []
            
//            for var x = 6; x > 0; x--
            while ticketArray.count < 6
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
    
//    func numberWasChosen(winningTicketNum: Array<Int>)
//    {
//        checkWinningTicket(winningTicket)
//    }
    
    func checkWinningTicket(winningTicketNum: Array<Int>) -> String
    {
        var matchingNumbers = 0
        var prizeAmount = 0
        for x in winningTicketNum
        {
            if ticketArray.contains(x)
            {
                matchingNumbers += 1
            }
        }
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
        
        return "$ " + String(prizeAmount)
        
    }
    
    
    
//    func checkWinningTicket(winningTicketNum: Array<Int>, testTicket: Array<Int>) -> String
//    {
//        var matchingNumbers = 0
//        var prizeAmount = 0
//        for x in winningTicketNum
//        {
//            if testTicket.contains(x)
//            {
//                matchingNumbers += 1
//            }
//        }
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
//        return "$ " + String(prizeAmount)
//        
//    }
    
    
//    func checkWinningTicket() -> String
//    {
//        let winningNumber = [1, 2, 3, 4, 5, 6]
//        var matchingNumbers = 0
//        var prizeAmount = 0
//        for x in winningNumber
//        {
//            if ticketArray.contains(x)
//            {
//                matchingNumbers += 1
//            }
//        }
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
//        return "$ " + String(prizeAmount)
//
//    }
    
}
