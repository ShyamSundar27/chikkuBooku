//
//  Validator.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 26/08/22.
//

import Foundation

class Validator {
    
    static let shared = Validator()
    
    
    func validateName (text : String) -> Bool{
        print(text)
        let regex = "^[A-Za-z\\s]{3,40}$"
        print((text.range(of: regex,options: .regularExpression) != nil))
        return (text.range(of: regex,options: .regularExpression) != nil)
       // return true
    }
    
    
    func validateAge (text : String) -> Bool{
        print(text)
        let regex = "^(?:1[01][0-9]|120|[0][7-9]|[7-9]|[1-9][0-9])$"
        print((text.range(of: regex,options: .regularExpression) != nil))
        return (text.range(of: regex,options: .regularExpression) != nil)
        
    }
    
    func validateMobileNumber (text : String) -> Bool{
        print(text)
        let regex = "^[6-9]\\d{9}$"
        
        print((text.range(of: regex,options: .regularExpression) != nil))
        return (text.range(of: regex,options: .regularExpression) != nil)
        
    }
    
    func validatePNRNumber (text : String) -> Bool{
        print(text)
        let regex = "^\\d{10}$"
        
        print((text.range(of: regex,options: .regularExpression) != nil))
        return (text.range(of: regex,options: .regularExpression) != nil)
        
    }
    func validateCoachNumber (text : String) -> Bool{
        print(text)
        let regex = "^[A-EHS]([1-9]|(1)[0-5])$"
        print((text.range(of: regex,options: .regularExpression) != nil))
        return (text.range(of: regex,options: .regularExpression) != nil)
        
    }
    
    
    func validateMail (text : String) -> Bool{
        print(text)
        let regex = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"

        print((text.range(of: regex,options: .regularExpression) != nil))
        return (text.range(of: regex,options: .regularExpression) != nil)
        
    }
    
    func validatePassword (text : String) -> Bool{
        print(text)
        let regex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"

        print((text.range(of: regex,options: .regularExpression) != nil))
        return (text.range(of: regex,options: .regularExpression) != nil)
        
    }
}

