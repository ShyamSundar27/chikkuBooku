//
//  AvailableSeatChart.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 03/08/22.
//

import Foundation



struct AvailableSeatChart{
    var availableSeatsWithQuotas : [CoachType:[Int:[SeatBookedWithStation]]] = [:]
    
    
    init(availableSeatsWithQuotas : [CoachType:[Int:[SeatBookedWithStation]]]){
        self.availableSeatsWithQuotas = availableSeatsWithQuotas
    }
}
