//
//  BookingDetails.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 03/08/22.
//

import Foundation


class BookingDetails{
    
    let coachNumber : Int?
    let seatType : SeatType?
    let seatNumber : Int?
    private(set) public var ticketBookingStatus : TicketBookingStatus
    let RacOrWlRank : Int?
    let wlNumber : Int?
    
    init (coachNumber : Int?,seatType : SeatType?,seatNumber : Int?,ticketBookingStatus : TicketBookingStatus,RacOrWlNumber : Int?,wlNumber : Int?){
        self.ticketBookingStatus = ticketBookingStatus
        self.seatNumber = seatNumber
        self.seatType = seatType
        self.coachNumber = coachNumber
        self.RacOrWlRank = RacOrWlNumber
        self.wlNumber = wlNumber
        
    }
    
    func changeStatusToCancel () {
        ticketBookingStatus = .Cancelled
    }
    
}
