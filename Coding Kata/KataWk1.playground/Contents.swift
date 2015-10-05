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
//let threeDigitNum = 100...999
//var firstNum = 0, secondNum = 0
////var palindrome = firstNum * secondNum
//var palindrome = 100
//let palinStr = String(palindrome)
//let characters = Array(palinStr.characters)
//var revArray = [""]
//for ch in characters.reverse()
//{
//    var subchar = ch
//    print(ch)
////    revArray.append(ch)
//}

// ^ this code sucks

