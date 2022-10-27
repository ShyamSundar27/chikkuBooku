//
//  AvailableSeatChart.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 02/08/22.
//

import Foundation


class AvailableSeatChart {
    
    var availableSeatsWithQuotas : [QuotaType:[CoachType:[Int:[SeatBookedWithStation]]]] = [:]
    
    
    init(availableSeatsWithQuotas : [QuotaType:[CoachType:[Int:[SeatBookedWithStation]]]]){
        self.availableSeatsWithQuotas = availableSeatsWithQuotas
    }
}
