//
//  SeatAvailabilityChartCreator.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 02/08/22.
//

import Foundation


struct seatAvailabilityChartCreator{
    
   
//    private(set) public var availableSeatsWithQuotas : [QuotaType:[CoachType:[Int:[SeatBookedWithStation]]]] = [:]
//    private(set) public var WLNumberBookedStatus : [CoachType:[SeatBookedWithStation]] = [:]
//    private(set) public var initialNumberOfWLNumber : [CoachType : Int] = [:]
//    private(set) public var RACSeatsBookedStatus : [CoachType:[Int:[[SeatBookedWithStation]]]] = [:]
//    private(set) public var initialNumberOfRacSeats : [CoachType : Int] = [:]
    let dbManager = DBManager.getInstance()
    var train : Train
    
    
    init(train:Train){
        self.train = train

        createSeatsWithQuotas()
        setRACSeats()
        setWlNumber()
    }
    
    private mutating func createSeatsWithQuotas (){

        let coachTypes = train.getCoachTypes()
        for coachType in coachTypes{
            let coaches : [Coach] = train.getCoaches()[coachType]!
            for coachCount in 0..<coaches.count {
                allocateQuotasForSeats(coachType: coachType, coach: coaches[coachCount],coachCount: coachCount+1)

            }
            
        }
               
    }
    //-> [QuotaType:[SeatBookedWithStation]]
    private func allocateQuotasForSeats(coachType:CoachType,coach:Coach,coachCount : Int) {
        
        
        var coachSeatsToBeAllocated = coach
        let seats = coachSeatsToBeAllocated.seats
        var seatsallocated : [QuotaType:[SeatBookedWithStation]] = [:]
        for quotaType in QuotaType.allCases{
            seatsallocated[quotaType] = []
        }
        switch(coachType){
        case .SleeperClass,.AirConditioned3TierClass :
            for seat in seats {
                if((seat.seatType == .Lower) && (seatsallocated[.Senior_Citizen]!.count < 2)){
                    seatsallocated[.Senior_Citizen]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Senior_Citizen, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if ((seatsallocated[.Ladies]!.count < 2) && (seat.seatType != .SideLower)){
                    seatsallocated[.Ladies]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Ladies, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if ((seatsallocated[.Duty_Pass]!.count < 2) && (seat.seatType != .SideLower)){
                    seatsallocated[.Duty_Pass]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Duty_Pass, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if (seat.seatType != .SideLower){
                    if coachType == .AirConditioned3TierClass && coachCount == 1 &&  train.trainNumber == 12345{
                        print("seatNumber = \(seat.seatNumber),\(seat.seatType)")
                    }
                    seatsallocated[.General]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .General, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
            }
        
        case .SecondSeaterClass,.AirConditionedChaiCarClass,.ExecutiveChairCarClass :
            for seat in seats {
                if((seatsallocated[.Ladies]!.count < 3)){
                    seatsallocated[.Ladies]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Ladies, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if ((seatsallocated[.Duty_Pass]!.count < 3) ){
                    seatsallocated[.Duty_Pass]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Duty_Pass, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else{
                    seatsallocated[.General]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .General, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
            }
            
        
        case .AirConditioned2TierClass :
            for seat in seats {
                if((seat.seatType == .Lower) && (seatsallocated[.Senior_Citizen]!.count < 2)){
                    seatsallocated[.Senior_Citizen]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Senior_Citizen, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if ((seatsallocated[.Ladies]!.count < 1) && (seat.seatType != .SideLower)){
                    seatsallocated[.Ladies]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Ladies, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if ((seatsallocated[.Duty_Pass]!.count < 1) && (seat.seatType != .SideLower)){
                    seatsallocated[.Duty_Pass]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Duty_Pass, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if (seat.seatType != .SideLower){
                    seatsallocated[.General]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .General, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
            }
        
        case .AirConditioned1TierClass :
            for seat in seats {
                if((seatsallocated[.Duty_Pass]!.count < 1)){
                    seatsallocated[.Duty_Pass]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Duty_Pass, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else{
                    seatsallocated[.General]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .General, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
            }
            
        }

    }
    
    
    private mutating func setRACSeats (){
//        initialNumberOfRacSeats[.AirConditioned2TierClass] = 0
//        initialNumberOfRacSeats[.AirConditioned3TierClass] = 0
//        initialNumberOfRacSeats[.SleeperClass] = 0
//
//        RACSeatsBookedStatus[.AirConditioned2TierClass] = [:]
//        RACSeatsBookedStatus[.AirConditioned3TierClass] = [:]
//        RACSeatsBookedStatus[.SleeperClass] = [:]
        
        var coachCount : [CoachType:Int] = [:]
        coachCount[.AirConditioned3TierClass] = 0
        coachCount[.AirConditioned2TierClass] = 0
        coachCount[.SleeperClass] = 0
        
        var racNumberCount : [CoachType:Int] = [:]
        racNumberCount[.AirConditioned3TierClass] = 0
        racNumberCount[.AirConditioned2TierClass] = 0
        racNumberCount[.SleeperClass] = 0
        
        
        for coachType in train.getCoaches().keys{
            if(coachType == .SleeperClass || coachType == .AirConditioned2TierClass  || coachType == .AirConditioned3TierClass){
                var initialRACCount = 0
                
                for coach in train.getCoaches()[coachType]!{
                    coachCount[coachType]! += 1
                    var coachValue = coach
                    //print("RAC Coach Count\(coachCount[coachType]!)")
                    let seats = coachValue.seats
                    for seatCount in 0..<seats.count{
                        if seats[seatCount].seatType == .SideLower {
                            racNumberCount[coachType]! += 1
                            dbManager.insertRACSeatChart(trainNumber: train.trainNumber, coachtype: coachType, coachNumber: coachCount[coachType]!, seatNumber: seats[seatCount].seatNumber, seatType: seats[seatCount].seatType)
                            racNumberCount[coachType]! += 1
                            dbManager.insertRACSeatChart(trainNumber: train.trainNumber, coachtype: coachType, coachNumber: coachCount[coachType]!, seatNumber: (seats[seatCount].seatNumber)+1, seatType: seats[seatCount].seatType)
                            initialRACCount += 2
                        }
                    }
                }
                
//                initialNumberOfRacSeats[coachType] = initialRACCount
            }
        }
        
    }
    
    private mutating func setWlNumber(){
        for coachType in train.getCoaches().keys{
            switch (coachType){
            case .SleeperClass :
//                WLNumberBookedStatus[.SleeperClass] = []
//                initialNumberOfWLNumber[.SleeperClass] = 30
                for wlCount in 1...15{
//                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                   
                    dbManager.insertWLSeatChart(trainNumber: train.trainNumber, coachtype: coachType, wlNumber: wlCount)
                }
            
            case .SecondSeaterClass :
//                WLNumberBookedStatus[.SecondSeaterClass] = []
//                initialNumberOfWLNumber[.SecondSeaterClass] = 35
                for wlCount in 1...17{
//                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.insertWLSeatChart(trainNumber: train.trainNumber, coachtype: coachType, wlNumber: wlCount)
                }
                
            case .AirConditioned3TierClass :
//                WLNumberBookedStatus[.AirConditioned3TierClass] = []
//                initialNumberOfWLNumber[.AirConditioned3TierClass] = 20
                for wlCount in 1...10{
//                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.insertWLSeatChart(trainNumber: train.trainNumber, coachtype: coachType, wlNumber: wlCount)
                }
            
            case .AirConditioned2TierClass :
//                WLNumberBookedStatus[.AirConditioned2TierClass] = []
//                initialNumberOfWLNumber[.AirConditioned2TierClass] = 15
                for wlCount in 1...7{
//                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.insertWLSeatChart(trainNumber: train.trainNumber, coachtype: coachType, wlNumber: wlCount)
                }
                
            case .AirConditioned1TierClass :
//                WLNumberBookedStatus[.AirConditioned1TierClass] = []
//                initialNumberOfWLNumber[.AirConditioned1TierClass] = 5
                for wlCount in 1...3{
//                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.insertWLSeatChart(trainNumber: train.trainNumber, coachtype: coachType, wlNumber: wlCount)
                }
                
            case .AirConditionedChaiCarClass :
//                WLNumberBookedStatus[.AirConditionedChaiCarClass] = []
//                initialNumberOfWLNumber[.AirConditionedChaiCarClass] = 25
                for wlCount in 1...12{
//                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.insertWLSeatChart(trainNumber: train.trainNumber, coachtype: coachType, wlNumber: wlCount)
                }
                
            case .ExecutiveChairCarClass :
//                WLNumberBookedStatus[.ExecutiveChairCarClass] = []
//                initialNumberOfWLNumber[.ExecutiveChairCarClass] = 5
                for wlCount in 1...3{
//                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.insertWLSeatChart(trainNumber: train.trainNumber, coachtype: coachType,wlNumber: wlCount)
                }
                
            }
        }
    }
}
