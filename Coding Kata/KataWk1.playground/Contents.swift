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
var palin1 = 100
var palin2 = 100
let palinProd = palin1 * palin2
var revArray: Array<Character> = []


    let palinProdStr = String(palinProd)
    let characters = Array(palinProdStr.characters)
    for ch in characters.reverse()
    {
        revArray.append(ch)
    }


print(String(revArray))
let revCompar = "00001"

if String(revArray) == revCompar
{
    print("is equal")
}

//var num = 90009
//var hello = String(num), helloChar = Array(hello.characters)
////if hello == helloChar.reverse()
////{
////    
////}
//
//let palindrome = 100
//let palinStr = String(palindrome)
//let palinStrArr = palinStr.characters.reverse()
//print(palinStrArr)
//
//var palin1 = 999, palin2 = palin1, palinProd = 0
//
//while palin1 > 0
//{
//    while palin2 > 0
//    {
//        
//    }
//    palinProd = palin1 * palin2
//    palin2--
//}
