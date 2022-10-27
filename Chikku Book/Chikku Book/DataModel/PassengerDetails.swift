//
//  PassengerDetails.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 03/08/22.
//

import Foundation


class PassengerDetails {
    
    let name : String
    let age : Int
    let gender : Gender
    private(set) public var bookingDetails : BookingDetails
    
    init(name : String,age : Int,gender : Gender,bookingDetails : BookingDetails){
        self.bookingDetails = bookingDetails
        self.name = name
        self.age = age
        self.gender = gender
    }
    
    func setBookingDetails (bookingDetails : BookingDetails){
        self.bookingDetails = bookingDetails
    }
}
