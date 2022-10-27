//
//  SeatAvailableInEachBookingType.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 02/08/22.
//

import Foundation


struct SeatAvailableInEachBookingType{
    
    let seatsAvailable : Int
    let racSeatsAvailable :Int
    let racSeatsBooked : Int
    let wlSeatsAvailable : Int
    let wlSeatsBooked : Int
    let seatsNotAvailable : Bool
    
    init (seatsAvailable : Int,racSeatsAvailable :Int,racSeatsBooked : Int,wlSeatsAvailable : Int,wlSeatsBooked : Int){
        self.seatsAvailable = seatsAvailable
        self.racSeatsAvailable = racSeatsAvailable
        self.racSeatsBooked = racSeatsBooked
        self.wlSeatsAvailable = wlSeatsAvailable
        self.wlSeatsBooked = wlSeatsBooked
        self.seatsNotAvailable = (wlSeatsAvailable == 0 && racSeatsAvailable == 0 && seatsAvailable == 0)
    }
}
