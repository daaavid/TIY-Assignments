//: # Question 1
//: ## Seconds
//: Determine the number of seconds in a year and store the number in a variable named ```secondsInAYear```.
var secondsInAYear = 365.25 * 24 * 60 * 60


//: # Question 2
//: ## Coin Toss
//: If you use ```arc4random()``` it will give you a random number. Generate a random number and use it to simulate a coin toss. Print "heads" or "tails".
import Foundation

func headsOrTails() -> String
{
    let randomNumber = (arc4random() % 2)
    var output = ""

    switch randomNumber
    {
    case 0:
        output = ("heads")
    default:
        output = ("tails")
    }
    
    return output
}

headsOrTails()
headsOrTails()
headsOrTails()
headsOrTails()
headsOrTails()

for var x = 0; x < 10; x++
{
    print(headsOrTails())
}
//: # Question 3
//: ## Testing
//: Test if ```number``` is divisible by 3, 5 and 7. For example 105 is divisible by 3,5 and 7, but 120 is divisible only by 3 and 5 and not by 7. If ```number``` is divisible by 3, 5, 7 print "number is divisible by 3, 5 and 7" otherwise print "number is not divisible by 3, 5 and 7".
func numberTest(number: Int) -> String
{
    var output = " number is not divisible by 3, 5, and 7"
    
    if number % 3 == 0 && number % 5 == 0 && number % 7 == 0
    {
        output = " number is divisible by 3, 5, and 7"
    }
    
    return ("(\(number)) \(output)")
}

numberTest(105)
numberTest(120)

for var x = 0; x < 10; x++
{
    print(numberTest(Int(arc4random() % 1000)))
}


