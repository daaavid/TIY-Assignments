//: Playground - noun: a place where people can play

import UIKit

//Question 1
let multiples = 1..<1000
var totalSum = 0
for num in multiples
{
    if num % 5 == 0 && num % 3 == 0
    {
        totalSum += num
    }
    else if num % 5 == 0
    {
        totalSum += num
    }
    else if num % 3 == 0
    {
        totalSum += num
    }
}
print(totalSum)

//Question 2
