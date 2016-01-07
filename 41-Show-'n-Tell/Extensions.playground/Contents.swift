//: Playground - noun: a place where people can learn to do rad flips

import UIKit

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

    /*
    mutating func pigLatin()
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
    
    mutating func decodePigLatin()
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
    */

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
    
    func isEmail() -> Bool
    {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluateWithObject(self)
    }
    
    func validate(var regex: String) -> Bool
    {
        switch regex
        {
        case "uppercase": regex = "[A-Z]+"
        case "lowercase": regex = "[a-z]+"
        case "phone": regex = "^\\(\\d{3}\\) \\d{3}-\\d{4}$"
        case "email": regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        default: regex = ""
        }
        
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluateWithObject(self)
    }
}

var reference = "There is always money in the banana stand"
var banana = "banana"
banana.checkCase("lowercase")
/*:
Fancy Comment
*/

extension UIImageView
{
    func downloadImgFrom(imageURL: String, contentMode: UIViewContentMode)
    {
        if let url = NSURL(string: imageURL)
        {
            var task: NSURLSessionDataTask!
            task = NSURLSession.sharedSession().dataTaskWithURL(url,
                completionHandler: { (data, response, error) -> Void in
                    if data != nil
                    {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let image = UIImage(data: data!)
                            self.image = image
                            self.contentMode = contentMode
                            task.cancel()
                        })
                    }
            })
            
            task.resume()
        }
        else
        {
            print("url \(imageURL) was invalid")
        }
    }
}

extension UIView
{
    func appearWithFade(duration: Double)
    {
        self.alpha = 0
        UIView.animateWithDuration(duration) { () -> Void in
            self.alpha = 1
        }
    }
    
    func hideWithFade(duration: Double)
    {
        self.alpha = 1
        UIView.animateWithDuration(duration) { () -> Void in
            self.alpha = 0
        }
    }
    
    func slideHorizontally(duration: Double, fromPointX: CGFloat)
    {
        let originalX = self.frame.origin.x
        self.frame.origin.x += fromPointX
        UIView.animateWithDuration(duration) { () -> Void in
            self.frame.origin.x = originalX
        }
    }
    
    func slideVertically(duration: Double, fromPointY: CGFloat)
    {
        let originalY = self.frame.origin.y
        self.frame.origin.y += fromPointY
        UIView.animateWithDuration(duration) { () -> Void in
            self.frame.origin.y = originalY
        }
    }
}

