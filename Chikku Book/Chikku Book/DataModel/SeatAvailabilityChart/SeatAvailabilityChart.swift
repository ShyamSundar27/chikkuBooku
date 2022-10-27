//
//  SeatAvailabilityChart.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 02/08/22.
//

import Foundation




import Foundation



class SeatAvailabilityChart{

    let train : Train
    let startDate : Date
    let availableSeatChart : AvailableSeatChart
    let racSeatChat : RACSeatChart
    let wlSeatChart : WLSeatChart
    
    
    init(availableSeatChart : AvailableSeatChart,racSeatChat : RACSeatChart,wlSeatChart : WLSeatChart,train : Train,startDate : Date){
        self.train = train
        self.startDate = startDate
        self.availableSeatChart = availableSeatChart
        self.racSeatChat = racSeatChat
        self.wlSeatChart = wlSeatChart
    }
    
}
