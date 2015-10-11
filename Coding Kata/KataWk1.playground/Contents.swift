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
print("The answer is \(totalSum)")

//Question 2

func checkPalin(palinProd: Int) -> Bool
{
    var isPalin = false
    let charArrayReversed = Array(String(palinProd).characters.reverse())

    if String(charArrayReversed) == String(palinProd)
    {
       isPalin = true
    }
    
    return isPalin
}

var palinProd = 0
var lgCurrPalin = 0

for var palinMul1 = 999; palinMul1 >= 100; palinMul1--
{
    for var palinMul2 = 999; palinMul2 >= 100; palinMul2--
    {
        palinProd = palinMul1 * palinMul2
        
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
            }
    }
}
print("The answer is \(lgCurrPalin)")
