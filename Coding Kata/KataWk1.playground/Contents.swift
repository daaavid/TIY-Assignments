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
var num = 90009
var hello = String(num), helloChar = Array(hello.characters)
//if hello == helloChar.reverse()
//{
//    
//}

var palin1 = 999, palin2 = palin1, palinProd = 0

while palin1 > 0
{
    while palin2 > 0
    {
        
    }
    palinProd = palin1 * palin2
    palin2--
}