//: Playground - noun: a place where people can play

import UIKit

//Question 1
let multiples = 1..<1000
var totalSum = 0
for num in multiples
{
    if num % 5 == 0 || num % 3 == 0
    {
        totalSum += num
    }
}
print(totalSum)

//Question 2

//let testPalinProd = 906609
//var testPalinProdAfter = Int(String(testPalinProd).characters.count)
//if testPalinProdAfter % 2 == 0
//{
//    print("Success")
//}



func checkPalin(palinProd: Int) -> Bool
{
    var isPalin = false
//    var revArray: Array<Character> = []
//    let charArray = String(Array(String(palinProd).characters).reverse())
    
//    let charArray = Array(String(palinProd).characters)
    let charArrayReversed = Array(String(palinProd).characters.reverse())
//    if charArray[0] == charArrayReversed[0]
//    {
        if String(charArrayReversed) == String(palinProd)
        {
           isPalin = true
        }
//    }
    
    return isPalin
}

checkPalin(900009)

//func checkIfOdd(palinProdStrSav: String) -> Bool
//{
//    if palinProdStrSav
//    
//    return true
//}

//checkPalin(palinProd)

var palinProd = 0
var lgCurrPalin = 0

for var palinMul1 = 999; palinMul1 >= 100; palinMul1--
{
    for var palinMul2 = 999; palinMul2 >= 100; palinMul2--
    {
        palinProd = palinMul1 * palinMul2
//        var checkEvenOdd = Int(String(palinProd).characters.count)
//        if checkEvenOdd % 2 == 0
//        {
            if checkPalin(palinProd) == true
            {
                if palinProd > lgCurrPalin
                {
                    lgCurrPalin = palinProd
                }
                else
                {
                    break
                }
//            }
        }
    }
}
print(lgCurrPalin)




//var palin1 = 99
////var palin2 = 91
////let palinProd = palin1 * palin2
//
////func checkPalin(prod) -> Int
////{
//    var revArray: Array<Character> = []
//    let palinProdStr = String(palinProd)
//    let characters = Array(palinProdStr.characters)
//    for ch in characters.reverse()
//    {
//        revArray.append(ch)
//    }
////    return(revArray)
////}
//String(revArray)
//
//if String(revArray) == String(palinProd)
//{
//    print("is equal")
//}
//else
//{
//    print("not equal")
//}
//
//class PalinCheck
//{
//    
//    init()
//    {
//        
//    }
//
//}
