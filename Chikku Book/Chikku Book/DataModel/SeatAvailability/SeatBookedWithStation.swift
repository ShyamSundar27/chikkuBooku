//
//  SeatBookedWithStatus.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 01/08/22.
//

import Foundation


class SeatBookedWithStation {
    
    let seat : Seat?
    var RACOrWlNumber : Int? = nil
    var bookedStations : [[String]]  = []
    
    init(seat : Seat){
        self.seat = seat
    }
    init(seat : Seat? , RACOrWlNumber : Int){
        self.seat = seat
        self.RACOrWlNumber = RACOrWlNumber
    }
    
}
