//
//  SeatAvailabilityChart.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 03/08/22.
//

import Foundation


struct SeatAvailabilityChart{
    
    let train : Train
    let startDate : Date
    let quotaType : QuotaType
    let availableSeatChart : AvailableSeatChart
    let racSeatChart : RACSeatChart?
    let wlSeatChart : WLSeatChart? 
    
    
    init(availableSeatChart : AvailableSeatChart,racSeatChart : RACSeatChart?,wlSeatChart : WLSeatChart?,train : Train,startDate : Date,quotaType:QuotaType){
        self.train = train
        self.startDate = startDate
        self.availableSeatChart = availableSeatChart
        self.racSeatChart = racSeatChart
        self.wlSeatChart = wlSeatChart
        self.quotaType = quotaType
    }
}
