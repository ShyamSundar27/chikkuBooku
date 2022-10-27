//
//  AirConditioned2TierClass.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 28/07/22.
//

import Foundation


struct AirConditioned2TierClass:Coach{
    let coachNumber: Int
    let coachTypeDetails: CoachTypeDetails
    lazy private(set) public var seats: [Seat] = createSeats()
    private let seatTypes : [SeatType] = [.Lower,.Upper,.SideLower,.SideUpper]

    
    init(coachNumber: Int){
        self.coachNumber = coachNumber
        self.coachTypeDetails = DBManager.getInstance().getCoachTypeDetails(coachType: .AirConditioned2TierClass)!
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
                if(rowCount%2==0) {
                    if(columnCount == totalColumns-1) {
                        seats.append(Seat(seatNumber: totalColumns*(rowCount+2)-1,
                                          seatType:seatTypes[columnCount]));
                    }
                    else{
                        seats.append(Seat(seatNumber: seatNumberCount,
                                          seatType:seatTypes[columnCount]));
                    }
                }
                else{
                    if(columnCount == totalColumns-1) {
                        seats.append(Seat(seatNumber:totalColumns*(rowCount+1),
                                          seatType:seatTypes[columnCount+1]));
                    }
                    else{
                        seats.append(Seat(seatNumber: seatNumberCount-1,
                                          seatType: seatTypes[columnCount]));
                    }
                }
            }
        }
        return seats
    }
    
    
}
