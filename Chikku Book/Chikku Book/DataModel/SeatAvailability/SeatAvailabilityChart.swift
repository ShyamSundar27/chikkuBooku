//
//  SeatAvailabilityChart.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 29/07/22.
//

import Foundation



class SeatAvailabilityChart{

    let train : Train
    let availableSeatChart : AvailableSeatChart
    let racSeatChat : RACSeatChart
    let wlSeatChart : WLSeatChart
    
    
    init(train : Train){
        self.train = train
        self.availableSeatChart = AvailableSeatChart(train:train )
        self.racSeatChat = RACSeatChart(train: train)
        self.wlSeatChart = WLSeatChart(train : train)
    }
    
}
