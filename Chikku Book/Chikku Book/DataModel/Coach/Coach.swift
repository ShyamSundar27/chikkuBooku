//
//  Coach.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 26/07/22.
//

import Foundation
import Metal


protocol Coach{
    var coachNumber : Int { get }
    var coachTypeDetails: CoachTypeDetails { get }
    var seats : [Seat] { mutating get }
    
//    init(coachNumber : Int,coachName : String,coachType : CoachType){
//        self.coachName = coachName
//        self.coachNumber= coachNumber
//        self.coachType = coachType
//        seats = createSeats()
//    }
    
    func createSeats()->[Seat]
    
}

struct CoachTypeDetails{
    let type : CoachType
    let coachCode : String
    let coachName : String
    let numberOfRowsOfSeats : Int
    let numberOfColumnsOfSeats : Int
    
    init(type : CoachType,coachCode : String,coachName : String,numberOfRowsOfSeats : Int,numberOfColumnsOfSeats : Int){
        self.type = type
        self.coachCode = coachCode
        self.coachName = coachName
        self.numberOfRowsOfSeats = numberOfRowsOfSeats
        self.numberOfColumnsOfSeats = numberOfColumnsOfSeats
    }
}



enum CoachType : String, CaseIterable{
    
    case SleeperClass = "Sleeper Class"
    case SecondSeaterClass = "Second Sitting"
    case AirConditioned3TierClass = "AC 3 Tier"
    case AirConditioned2TierClass =  "AC 2 Tier"
    case AirConditioned1TierClass = "AC 1 Tier"
    case AirConditionedChaiCarClass = "AC Chair Car"
    case ExecutiveChairCarClass = "Exec. Chair Car"
}

