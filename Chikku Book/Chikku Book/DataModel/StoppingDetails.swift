//
//  StoppingDetails.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 26/07/22.
//

import Foundation

struct StoppingDetails {
    
    let stoppingNumber :Int
    let arrivalTime : Date
    let departureTime : Date
    let arrivalDayOfTheTrain :Int
    let departureDayOfTheTrain :Int
    let trainAvailabilityStatusOfWeek : String//1101111
    let stationCode :String
    
    init(stoppingNumber :Int,arrivalTime : Date,departureTime : Date,arrivalDayOfTheTrain :Int,departureDayOfTheTrain :Int,trainAvailabilityStatusOfWeek : String,stationCode :String){
        self.stationCode = stationCode
        self.departureDayOfTheTrain = departureDayOfTheTrain
        self.arrivalTime = arrivalTime
        self.arrivalDayOfTheTrain = arrivalDayOfTheTrain
        self.departureTime = departureTime
        self.trainAvailabilityStatusOfWeek = trainAvailabilityStatusOfWeek
        self.stoppingNumber = stoppingNumber
    }
}
