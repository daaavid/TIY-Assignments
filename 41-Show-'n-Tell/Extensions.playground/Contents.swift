//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

extension String
{
    mutating func pigLatin()
    {
        var characters = self.characters
        if characters.count > 0
        {
            let firstChar = String(characters.first!)
            characters.removeFirst()
            
            if self.checkCase("lowercase")
            {
                self = String(characters) + firstChar + "ay"
            }
            else
            {
                self = String(characters) + firstChar + "AY"
            }
        }
    }
    
    mutating func decodePigLatin()
    {
        var characters = self.characters
        if characters.count > 0
        {
            characters.removeLast()
            characters.removeLast()
            
            let firstChar = String(characters.first!)
            characters.removeFirst()
            let secondChar = String(characters.last!)
            characters.removeLast()
            
            self = secondChar + firstChar + String(characters)
        }
    }
    
    mutating func pigLatinSentence()
    {
        let components = self.componentsSeparatedByString(" ")
        self = ""
        for var component in components
        {
            var characters = component.characters
            if characters.count > 0
            {
                let firstChar = String(characters.first!).lowercaseString
                characters.removeFirst()
                var newFirstChar = String(characters.first!)
                characters.removeFirst()
                
                if components.indexOf(component) == 0
                {
                    newFirstChar = newFirstChar.uppercaseString
                }
                
                component = newFirstChar + String(characters) + firstChar + "ay"
            }
            
            self = self + component + " "
        }
    }
    
    mutating func decodePigLatinSentence()
    {
        let components = self.componentsSeparatedByString(" ")
        self = ""
        for var component in components
        {
            if component.characters.count > 0
            {
                var characters = component.characters
                characters.removeLast()
                characters.removeLast()
                
                let secondChar = String(characters.first!).lowercaseString
                characters.removeFirst()
                var firstChar = String(characters.last!)
                characters.removeLast()
                
                if components.indexOf(component) == 0
                {
                    firstChar = firstChar.uppercaseString
                }
                
                component = firstChar + secondChar + String(characters)
            }
            
            self = self + component + " "
        }
    }
    
    mutating func alternatingCaps()
    {
        let characters = self.characters
        self = ""
        var count = 1
        
        for character in characters
        {
            if count % 2 == 0
            {
                self = self + String(character).uppercaseString
            }
            else
            {
                self = self + String(character).lowercaseString
            }
            
            count++
        }
    }
    
    func checkCase(var regex: String) -> Bool
    {
        switch regex
        {
        case "uppercase": regex = "[A-Z]+"
        case "lowercase": regex = "[a-z]+"
        default: regex = ""
        }
        
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluateWithObject(self)
    }

    func isPhoneNumber() -> Bool
    {
        let regex = "^\\(\\d{3}\\) \\d{3}-\\d{4}$"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluateWithObject(self)
    }
}

var string = "There is always money in the banana stand"
string.pigLatinSentence()
string.decodePigLatinSentence()
string.alternatingCaps()

var capString = "BANANA"
capString.checkCase("uppercase")
capString.pigLatin()
capString.decodePigLatin()
capString.lowercaseString.checkCase("lowercase")




let number = "(920) 285-6700"
number.isPhoneNumber()




