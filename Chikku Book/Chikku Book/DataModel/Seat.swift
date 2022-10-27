//
//  Seat.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 26/07/22.
//

import Foundation



struct Seat {
    let seatNumber : Int
    let seatType : SeatType
    
    init(seatNumber : Int,seatType : SeatType){
        self.seatType = seatType
        self.seatNumber = seatNumber
    }
}

enum SeatType : String,CaseIterable{
    case Window
    case Middle
    case Aisle
    case Lower
    case Upper
    case SideUpper = "Side Upper"
    case SideLower = "Side Lower"
    
}
