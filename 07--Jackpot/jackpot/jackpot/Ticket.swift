
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
    var lottoArray = Array<Int>()
    var dupNumber = 0
    
    init()
    {
//        for var x = 6; x > 0;
//        {
//            let number = Int(arc4random() % 53)
//            if self.checkDuplicate(number) == false
//            {
//                lottoArray.append(number)
//                dupNumber = number
//                x--
//                
//            }
//        }
//        
//        ticket = String(lottoArray)
//        lottoArray = []
        
        ticket = String(makeTicket())
        lottoArray = []
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

    func makeTicket() -> Array<Int>
    {
        var willLoop = true
        while willLoop == true
        {
            lottoArray = []
            
            for var x = 6; x > 0; x--
            {
                let number = Int(1 + arc4random() % 52)
                lottoArray.append(number)
                
            }
            
            if checkDuplicate(lottoArray) == true
            {
                willLoop = false
                return lottoArray
            }
        }
    }

    
}
