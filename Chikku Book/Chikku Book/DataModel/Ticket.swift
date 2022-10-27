//
//  Ticket.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 26/07/22.
//

import Foundation

class Ticket{
    
    let pnrNumber : UInt64//int
    let trainNumber : Int
    let fromStation : String
    let toStation : String
    let quotaType : QuotaType
    let coachType : CoachType
    let startTime : Date
    let endTime : Date
    private(set) public var ticketStatus : TicketBookingStatus
    let passengerDetails : [PassengerDetails]
    var ticketFare : Float
    let isTravelInsuranceOpt : Bool
    let startDate : Date
    
    init( pnrNumber : UInt64, trainNumber : Int, fromStation : String, toStation : String, quotaType : QuotaType, coachType : CoachType, startTime : Date, endTime: Date, passengerDetails : [PassengerDetails], ticketFare : Float, isTravelInsuranceOpt:Bool, startDate : Date ){
        self.pnrNumber = pnrNumber
        self.trainNumber = trainNumber
        self.fromStation = fromStation
        self.toStation = toStation
        self.quotaType = quotaType
        self.coachType = coachType
        self.startTime = startTime
        self.endTime = endTime
        self.passengerDetails = passengerDetails
        self.ticketStatus = passengerDetails[passengerDetails.count - 1].bookingDetails.ticketBookingStatus
        
        
        
        self.ticketFare = ticketFare
        self.isTravelInsuranceOpt = isTravelInsuranceOpt
        self.startDate = startDate
    }
    
    func updateStatus () -> Bool{
        
        if ticketStatus == passengerDetails[passengerDetails.count - 1].bookingDetails.ticketBookingStatus{
            return false
        }
        
        self.ticketStatus = passengerDetails[passengerDetails.count - 1].bookingDetails.ticketBookingStatus
        return true
    }
}

enum QuotaType : String,CaseIterable{
    case General = "General"
    case Ladies = "Ladies"
    case Senior_Citizen = "Senior Citizen"
    case Duty_Pass = "Duty Pass"
}
