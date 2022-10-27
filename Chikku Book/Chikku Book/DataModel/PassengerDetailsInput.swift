//
//  PassengerDetailsInput.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 02/08/22.
//

import Foundation


struct PassengerDetailsInput{
    let name : String
    let age : Int
    let gender :Gender
    let seatTypePreference : SeatType?
    
    
    
    init(name : String,age : Int, gender :Gender,seatTypePreference : SeatType?){
        self.name = name
        self.age = age
        self.gender = gender
        self.seatTypePreference = seatTypePreference
        
    }
}

