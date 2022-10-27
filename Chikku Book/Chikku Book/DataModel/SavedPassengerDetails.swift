//
//  SavedPassengerDetails.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 26/07/22.
//

import Foundation


struct SavedPassengerDetails{
    
    var name : String
    var age : Int
    var gender : Gender
    
    
    init(name : String, age : Int, gender : Gender){
        self.name = name
        self.gender = gender
        self.age = age
    }
    
}

enum Gender:String{
    case Male
    case Female
    case Trangender = "Trans"
}
