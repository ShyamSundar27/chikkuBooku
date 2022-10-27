//
//  ExecutiveChairCarClass.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 28/07/22.
//

import Foundation



struct ExecutiveChairCarClass:Coach{
    let coachNumber: Int
    let coachTypeDetails: CoachTypeDetails
    lazy private(set) public var seats: [Seat] = createSeats()
    private let seatTypes : [SeatType] = [.Window,.Aisle,.Aisle,.Window]
    
    init(coachNumber: Int){
        self.coachNumber = coachNumber
        self.coachTypeDetails = DBManager.getInstance().getCoachTypeDetails(coachType: .ExecutiveChairCarClass)!
        self.seats = createSeats()
    }
    
    func createSeats() -> [Seat] {
        var seats = [Seat]()
        let totalRows : Int = coachTypeDetails.numberOfRowsOfSeats
        let totalColumns : Int = coachTypeDetails.numberOfColumnsOfSeats
        var seatNumberCount = 0
        for  rowCount in 0..<totalRows{
            for  columnCount in 0..<totalColumns{
                seatNumberCount+=1;
                seats.append(Seat(seatNumber: seatNumberCount, seatType: seatTypes[columnCount]))
            }
        }
        return seats
    }
    
    
}
