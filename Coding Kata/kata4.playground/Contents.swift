//: ## Question 1
//: ### Prime Numbers
//: Implement the following functions. The divides function returns ```true``` if ```a``` is divisible by ```b``` and ```false``` otherwise. The ```countDivisors``` function should use the ```divides``` function to return the number of ```divisors``` of ```number```. The ```isPrimefunction``` should use the ```countDivisors``` function to determine if ```number``` is prime.

func divides(a: Int, b: Int) -> Bool
{
    var rc = false
    if a % b == 0
    {
        rc = true
    }
    return rc
}

//divides(10, b: 2)

func countDivisors(number: Int) -> Int
{
    var divisors = 0
    
    for num in 1...999
    {
        if divides(number, b: num)
        {
            divisors += 1
        }
    }
    
    
    return divisors
}

//countDivisors(10)

func isPrime(number: Int) -> Bool
{
    var rc = false
    if countDivisors(number) == 2
    {
        rc = true
    }
    return rc
}

isPrime(191)
//isPrime(193)
//isPrime(194)

//: ## Question 2
//: ### First Primes
//: Using ```isPrime``` from the previous question, write a function named ```printFirstPrimes``` that takes a parameter named ```count``` of type ```Int``` that prints the first ```count``` prime numbers. For example, if ```count``` were set to 5, it would print "2, 3, 5, 7, 11"
func printFirstPrimes(var count: Int) -> [Int]
{
    var firstPrimes = [Int]()
    for x in 1...9999
    {
        if isPrime(x)
        {
            firstPrimes.append(x)
            count -= 1
            if count == 0
            {
                break
            }
        }
    }
    return firstPrimes
}

printFirstPrimes(5)
//: ## Question 3
//: ### Reverse
//: Write a function named ```reverse``` that takes an array of integers named ```numbers``` as a parameter. The function should return an array with the numbers from ```numbers``` in reverse order.
func reverse(intArray: [Int]) -> [Int]
{
    var reversed = [Int]()
    
    for x in intArray.reverse()
    {
        reversed.append(x)
    }
    
    return reversed
}

let intArray = [1,2,3,4,5]
reverse(intArray)


//: ## Question 4
//: ### Time Difference
//: Write a function named ```timeDifference```. It takes as input four numbers that represent two times in a day and returns the difference in minutes between them. The first two parameters ```firstHour``` and ```firstMinute``` represent the hour and minute of the first time. The last two ```secondHour``` and ```secondMinute``` represent the hour and minute of the second time. All parameters should have external parameter names with the same name as the local ones.

func timeDifference(firstHour: Int, firstMinute: Int, secondHour: Int, secondMinute: Int) -> Int
{
    let firstNum = (firstHour * 60) + firstMinute
    let secondNum = (secondHour * 60) + secondMinute
    
    var difference = firstNum - secondNum
    if difference < 0
    {
        difference *= -1
    }
    
    return difference
}

timeDifference(2, firstMinute: 40, secondHour: 2, secondMinute: 30)
