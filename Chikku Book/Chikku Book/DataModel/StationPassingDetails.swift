//
//  StationPassingDetails.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 16/08/22.
//

import Foundation


struct StationPassingDetails {
    
    let stationCode  : String
    let isTrainStops : Bool
    let distanceFromOrigin : Float
    
    init(stationCode : String,isTrainStops : Bool,distanceFromOrigin : Float){
        self.stationCode = stationCode
        self.isTrainStops = isTrainStops
        self.distanceFromOrigin = distanceFromOrigin
    }
    
    
}
