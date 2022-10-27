//
//  WLSeatChart.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 02/08/22.
//

import Foundation
 

struct WLSeatChart {
    var wLNumberBookedStatus : [CoachType:[SeatBookedWithStation]] = [:]
    var initialNumberOfWLNumber : [CoachType : Int] = [:]

    
    init (wLNumberBookedStatus : [CoachType:[SeatBookedWithStation]],initialNumberOfWLNumber : [CoachType : Int] ){
        self.wLNumberBookedStatus = wLNumberBookedStatus
        self.initialNumberOfWLNumber = initialNumberOfWLNumber
        
    }
    
    
}
