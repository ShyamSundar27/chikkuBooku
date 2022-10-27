//
//  AvailableSeatChat.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 01/08/22.
//

import Foundation



class AvailableSeatChart{
    
    var availableSeatsWithQuotas : [QuotaType:[CoachType:[Int:[SeatBookedWithStation]]]] = [:]
    let dbManager = DBManager.getInstance()
    let train : Train
    
    init(train:Train){
        self.train = train
        for quotatype in QuotaType.allCases{
            availableSeatsWithQuotas[quotatype] = [:]
            for coachType in train.getCoachTypes(){
                availableSeatsWithQuotas[quotatype]![coachType] = [:]
            }
        }
        createSeatsWithQuotas()
    }
    
    func createSeatsWithQuotas (){

        let coachTypes = train.getCoachTypes()
        for coachType in coachTypes{
            let coaches : [Coach] = train.getCoaches()[coachType]!
            for coachCount in 0..<coaches.count {
                let seatsallocated = allocateQuotasForSeats(coachType: coachType, coach: coaches[coachCount],coachCount: coachCount+1)
                for quotaType in seatsallocated.keys{
                    availableSeatsWithQuotas[quotaType]![coachType]![coachCount+1] = []
                    for seatBookedWithStation in seatsallocated[quotaType]!{
                        availableSeatsWithQuotas[quotaType]![coachType]![coachCount+1]!.append(seatBookedWithStation)
                    }
                }
            }
            
        }
               
    }
    
    func allocateQuotasForSeats(coachType:CoachType,coach:Coach,coachCount : Int) -> [QuotaType:[SeatBookedWithStation]] {
        
        let seats = coach.seats!
        var seatsallocated : [QuotaType:[SeatBookedWithStation]] = [:]
        for quotaType in QuotaType.allCases{
            seatsallocated[quotaType] = []
        }
        switch(coachType){
        case .SleeperClass,.AirConditioned3TierClass :
            for seat in seats {
                if((seat.seatType == .Lower) && (seatsallocated[.Senior_Citizen]!.count <= 4)){
                    seatsallocated[.Senior_Citizen]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Senior_Citizen, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if ((seatsallocated[.Ladies]!.count <= 4) && (seat.seatType != .SideLower)){
                    seatsallocated[.Ladies]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Ladies, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if ((seatsallocated[.Duty_Pass]!.count <= 4) && (seat.seatType != .SideLower)){
                    seatsallocated[.Duty_Pass]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Duty_Pass, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if (seat.seatType != .SideLower){
                    seatsallocated[.General]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .General, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
            }
            return seatsallocated
        
        case .SecondSeaterClass,.AirConditionedChaiCarClass,.ExecutiveChairCarClass :
            for seat in seats {
                if((seatsallocated[.Ladies]!.count <= 6)){
                    seatsallocated[.Ladies]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Ladies, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if ((seatsallocated[.Duty_Pass]!.count <= 6) ){
                    seatsallocated[.Duty_Pass]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Duty_Pass, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else{
                    seatsallocated[.General]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .General, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
            }
            return seatsallocated
        
        case .AirConditioned2TierClass :
            for seat in seats {
                if((seat.seatType == .Lower) && (seatsallocated[.Senior_Citizen]!.count <= 3)){
                    seatsallocated[.Senior_Citizen]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Senior_Citizen, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if ((seatsallocated[.Ladies]!.count <= 2) && (seat.seatType != .SideLower)){
                    seatsallocated[.Ladies]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Ladies, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if ((seatsallocated[.Duty_Pass]!.count <= 2) && (seat.seatType != .SideLower)){
                    seatsallocated[.Duty_Pass]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Duty_Pass, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else if (seat.seatType != .SideLower){
                    seatsallocated[.General]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .General, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
            }
            return seatsallocated
        
        case .AirConditioned1TierClass :
            for seat in seats {
                if((seatsallocated[.Duty_Pass]!.count <= 2)){
                    seatsallocated[.Duty_Pass]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .Duty_Pass, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
                else{
                    seatsallocated[.General]!.append(SeatBookedWithStation(seat: seat))
                    dbManager.insertAvailableSeatChart(trainNumber: train.trainNumber, quotaType: .General, coachtype: coachType, coachNumber: coachCount, seatNumber: seat.seatNumber, seatType: seat.seatType)
                }
            }
            return seatsallocated
            
        }

    }
}
