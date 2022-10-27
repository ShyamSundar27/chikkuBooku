//
//  User.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 26/07/22.
//

import Foundation


struct User : Codable{
   
    
    public private(set) var name : String
    //public private(set) var password : String
    let userName : String
    let mail : String
    let mobileNumber : UInt64
    
    
    
    
    init (name : String,userName : String,mail : String,mobileNumber : UInt64){
        self.name = name
        self.userName = userName
        self.mail = mail
        //self.password = password
        self.mobileNumber = mobileNumber
    }
  

}



