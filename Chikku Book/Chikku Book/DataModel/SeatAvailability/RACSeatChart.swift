//
//  RACSeatChart.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 01/08/22.
//

import Foundation


class RACSeatChart{

    var RACSeatsBookedStatus : [CoachType:[Int:[[SeatBookedWithStation]]]] = [:]
    var initialNumberOfRacSeats : [CoachType : Int] = [:]
    let train :Train
    let dbManager = DBManager.getInstance()
    
    init (train:Train){
        self.train = train
        setRACSeats()
    }
    private func setRACSeats (){
        initialNumberOfRacSeats[.AirConditioned2TierClass] = 0
        initialNumberOfRacSeats[.AirConditioned3TierClass] = 0
        initialNumberOfRacSeats[.SleeperClass] = 0
        
        RACSeatsBookedStatus[.AirConditioned2TierClass] = [:]
        RACSeatsBookedStatus[.AirConditioned3TierClass] = [:]
        RACSeatsBookedStatus[.SleeperClass] = [:]
        
        var coachCount : [CoachType:Int] = [:]
        coachCount[.AirConditioned3TierClass] = 0
        coachCount[.AirConditioned2TierClass] = 0
        coachCount[.SleeperClass] = 0
        
        
        for coachType in train.getCoaches().keys{
            if(coachType == .SleeperClass || coachType == .AirConditioned2TierClass  || coachType == .AirConditioned3TierClass){
                var initialRACCount = 0
                
                for coach in train.getCoaches()[coachType]!{
                    coachCount[coachType]! += 1
                    print("RAC Coach Count\(coachCount[coachType]!)")
                    let seats = coach.seats!
                    RACSeatsBookedStatus[coachType]![coach.coachNumber] = []
                    for seatCount in 0..<seats.count{
                        if seats[seatCount].seatType == .SideLower {
                            var seatStatusDivider : [SeatBookedWithStation] = []
                            seatStatusDivider.append(SeatBookedWithStation(seat: seats[seatCount], RACOrWlNumber: seats[seatCount].seatNumber))
                            dbManager.insertRACSeatChart(trainNumber: train.trainNumber, coachtype: coachType, coachNumber: coachCount[coachType]!, seatNumber: seats[seatCount].seatNumber, seatType: seats[seatCount].seatType)
                            seatStatusDivider.append(SeatBookedWithStation(seat: seats[seatCount], RACOrWlNumber: (seats[seatCount].seatNumber)+1))
                            dbManager.insertRACSeatChart(trainNumber: train.trainNumber, coachtype: coachType, coachNumber: coachCount[coachType]!, seatNumber: (seats[seatCount].seatNumber)+1, seatType: seats[seatCount].seatType)
                            RACSeatsBookedStatus[coachType]![coach.coachNumber]!.append(seatStatusDivider)
                            initialRACCount += 2
                        }
                    }
                }
                
                initialNumberOfRacSeats[coachType] = initialRACCount
            }
        }
        
    }
        
}

