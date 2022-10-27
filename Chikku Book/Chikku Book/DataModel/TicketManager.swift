//
//  TicketManager.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 02/08/22.
//

import Foundation

struct TicketManager{
    
    private let dbManager = DBManager.getInstance()
    
    private let ticketCounter = TicketCounter()
    
    
    

//    func cancelTicket(ticket:Ticket){
//        let trainNumber = ticket.trainNumber
//        let train = dbManager.getTrainDetails(trainNumber: trainNumber)!
//        let travelDateString = ticket.startTime.toString(format: "yyyy-MM-dd")
//        let dateFormatter = DateFormatter()
//        let fromStationCode = ticket.fromStation
//        let toStationCode = ticket.toStation
//        let travelDate = dateFormatter.toDate(format: "yyyy-MM-dd", string: travelDateString)
//        let startDate = travelDate.getDateFor(days: -(train.getStoppingDetails(stationCode: fromStationCode)!.arrivalDayOfTheTrain - 1))!
//        
//        let seatAvailabilityChart = dbManager.getSeatChartForQuotaType(trainNumber: trainNumber, quotaType: ticket.quotaType, startDate: startDate)
//        let seatManager = SeatManager(seatAvailabilityChart: seatAvailabilityChart)
//        let numberOfSeatsAvailableinEachType = seatManager.numberOfSeatsAvailableInEachBookingType(fromStationCode: fromStationCode, toStationCode: toStationCode, coachType: ticket.coachType)
//        let coachType = ticket.coachType
//        
//        if(numberOfSeatsAvailableinEachType.seatsAvailable > 0 || ticket.quotaType != .General){
//            for passengerDetail in ticket.passengerDetails{
//                let bookingDetails = passengerDetail.bookingDetails
//                seatManager.freeSeat(ticketBookingType: bookingDetails.ticketBookingStatus, coachType:coachType, coachNumber: bookingDetails.coachNumber!, seatType: bookingDetails.seatType!, seatNumber: bookingDetails.seatNumber!, fromStation: fromStationCode, toStation: toStationCode)
//                dbManager.removeStationFromBooked(seatBookedStatusId: bookingDetails.seatBookedStatusId)
//            }
//            dbManager.deleteTicket(pnrNumber: ticket.pnrNumber)
//        }
//        
//        
//        else if (numberOfSeatsAvailableinEachType.seatsAvailable == 0 && ticket.quotaType == .General && (coachType == .AirConditioned2TierClass || coachType == .AirConditioned3TierClass || coachType == .SleeperClass) ){
//            
//            
//            if (numberOfSeatsAvailableinEachType.racSeatsAvailable == 0){
//                if ticket.ticketStatus == .Confirmed{
//                    for passengerDetail in ticket.passengerDetails{
//                        let bookingDetails = passengerDetail.bookingDetails
//                        seatManager.freeSeat(ticketBookingType: bookingDetails.ticketBookingStatus, coachType:coachType, coachNumber: bookingDetails.coachNumber!, seatType: bookingDetails.seatType!, seatNumber: bookingDetails.seatNumber!, fromStation: fromStationCode, toStation: toStationCode)
//                        dbManager.removeStationFromBooked(seatBookedStatusId: bookingDetails.seatBookedStatusId)
//                    }
//                    
//                    let racTickets = dbManager.retrieveRacOrWlTickets(quotaType: ticket.quotaType, coachType: ticket.coachType, trainNumber: ticket.trainNumber, ticketStatus: .ReservationAgainstCancellation)
//                    
//                    for racTicket in racTickets {
//                        
//                        for passenger in racTicket.passengerDetails{
//                            
//                            if passenger.bookingDetails.ticketBookingStatus != .Confirmed {
//                                //seatManager.f
//                            }
//                        }
//                        
//                        let ticket = ticketCounter.alterTicket(ticket: ticket)
//                    }
//                    
//                   
//                }
//                
//                
//            }
//            
//        }
//        
//    }
    
    
    
    
    
}
