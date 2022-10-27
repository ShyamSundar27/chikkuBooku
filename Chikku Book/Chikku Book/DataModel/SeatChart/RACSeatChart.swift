//
//  RACSeatChart.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 02/08/22.
//

import Foundation
 


struct RACSeatChart{
    
    var RACSeatsBookedStatus : [CoachType:[Int:[SeatBookedWithStation]]] = [:]
    var initialNumberOfRacSeats : [CoachType : Int] = [:]
    
    
    init (RACSeatsBookedStatus : [CoachType:[Int:[SeatBookedWithStation]]],initialNumberOfRacSeats : [CoachType : Int]){
        self.RACSeatsBookedStatus = RACSeatsBookedStatus
        self.initialNumberOfRacSeats = initialNumberOfRacSeats
    }
    
}
