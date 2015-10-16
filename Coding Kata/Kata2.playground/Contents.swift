//: ## Question 1
//: ### Leap Year
//: You are given a year, determine if it’s a leap year. A leap year is a year containing an extra day. It has 366 days instead of the normal 365 days. The extra day is added in February, which has 29 days instead of the normal 28 days. Leap years occur every 4 years. 2012 is a leap year and so is 2016. Except that every 100 years special rules apply. Years that are divisible by 100 are not leap years if they are not divisible by 400. For example 1900 was not a leap year, but 2000 was. __Print Leap year! or Not a leap year! depending on the case.__
func checkLeapYear(year: Int) -> Bool
{
    var rc = false
    if year % 100 == 0 && year % 400 == 0
    {
        rc = true
    }
    return rc
}

checkLeapYear(2000)
checkLeapYear(1900)
//: ## Question 2
//: ### Food Spoilage
//: You are working on a smart-fridge. The smart-fridge knows how old the eggs and bacon in it are. You know that eggs spoils after 3 weeks (21 days) and bacon after one week (7 days). Given ```baconAge``` and ```eggsAge``` (in days) determine if you can cook bacon and eggs or what ingredients you need to throw out.
//:
//: If you can cook bacon and eggs print you can cook bacon and eggs. If you need to throw out any ingredients for each one print a line with the text throw out ingredient (throw out bacon or throw out eggs) in any order.


//: ## Question 3
//: ### Difference of Square of Sums and Sum of Squares
//: The sum of the squares of the first ten natural numbers is,
//: 1^2 + 2^2 + ... + 10^2 = 385
//:
//: The square of the sum of the first ten natural numbers is,
//: (1 + 2 + ... + 10)^2 = 55^2 = 3025
//:
//: Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
//: __Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.__
var num = 0
var sum = 0

var sumOfSq = 0

while num <= 10
{
    var numSq = num * num
    num++
    
    sumOfSq = sumOfSq + numSq
}

sumOfSq

for var x = 0; x <= 10; x++
{
    sum = sum + x
}

var sqOfSum = sum * sum

var difference = sqOfSum - sumOfSq

difference


