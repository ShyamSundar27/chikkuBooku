//
//  SeatManager.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 02/08/22.
//

import Foundation


struct SeatManager {
    private let seatAvailabilityChart :SeatAvailabilityChart
    private let dbManager : DBManager = DBManager.getInstance()
    
    init(seatAvailabilityChart :SeatAvailabilityChart){
        self.seatAvailabilityChart = seatAvailabilityChart
    }
    
    
    func numberOfSeatsAvailableInEachBookingType(fromStationCode :String,toStationCode :String,coachType :CoachType) ->SeatAvailableInEachBookingType{
        let numberOfAvailableSeats = numberOfSeatsAvailable(fromStationCode: fromStationCode, toStationCode: toStationCode, coachType: coachType)
        if(seatAvailabilityChart.quotaType != .General ||  numberOfAvailableSeats > 0){
            return SeatAvailableInEachBookingType(seatsAvailable: numberOfAvailableSeats, racSeatsAvailable: 0, racSeatsBooked: 0, wlSeatsAvailable: 0, wlSeatsBooked: 0)
        }
        
        else{
            var racSeatsAvailable = 0
            var racSeatsBooked = 0
            if(coachType != .AirConditioned2TierClass && coachType != .AirConditioned3TierClass && coachType != .SleeperClass){
                racSeatsAvailable = 0
                racSeatsAvailable = 0
            }
            else{
                racSeatsAvailable = numberOfRACSeatsAvailable(coachType: coachType, fromStationCode: fromStationCode, toStationCode: toStationCode)
                racSeatsBooked = numberOfRACSeatsBooked(coachType: coachType, racSeatsAvailable: racSeatsAvailable)
                if racSeatsAvailable !=  0 {
                    return SeatAvailableInEachBookingType(seatsAvailable: numberOfAvailableSeats, racSeatsAvailable: racSeatsAvailable, racSeatsBooked: racSeatsBooked, wlSeatsAvailable: 0, wlSeatsBooked: 0)
                }
            }
            let wlSeatsAvailable = numberOfWLSeatsAvailable(coachType: coachType, fromStationCode: fromStationCode, toStationCode: toStationCode)
            let wlSeatsBooked = numberOfWlSeatsBooked(coachType: coachType, wlSeatsAvailable: wlSeatsAvailable)
            
            return SeatAvailableInEachBookingType(seatsAvailable: numberOfAvailableSeats, racSeatsAvailable: racSeatsAvailable, racSeatsBooked: racSeatsBooked, wlSeatsAvailable: wlSeatsAvailable, wlSeatsBooked: wlSeatsBooked)
        }
        
         
    }
    
    func numberOfRACSeatsBooked (coachType:CoachType,racSeatsAvailable:Int) -> Int{
        return seatAvailabilityChart.racSeatChart!.initialNumberOfRacSeats[coachType]! - racSeatsAvailable
    }
    
    func numberOfWlSeatsBooked (coachType:CoachType,wlSeatsAvailable:Int) -> Int{
        print("before")
        print(wlSeatsAvailable)
        print(seatAvailabilityChart.wlSeatChart!.initialNumberOfWLNumber[coachType]!)
        print("after")
        return seatAvailabilityChart.wlSeatChart!.initialNumberOfWLNumber[coachType]! - wlSeatsAvailable
    }
    
    func numberOfSeatsAvailable(fromStationCode : String,toStationCode :String,coachType :CoachType) ->Int{
        
        if (coachType == .AirConditioned1TierClass) && (seatAvailabilityChart.quotaType == .Ladies || seatAvailabilityChart.quotaType == .Senior_Citizen){
            return 0
        }
        
        if (coachType == .SecondSeaterClass || coachType == .AirConditionedChaiCarClass || coachType == .ExecutiveChairCarClass) && ( seatAvailabilityChart.quotaType == .Senior_Citizen){
            return 0
        }
        let train = seatAvailabilityChart.train
        
        let fromStationNumber = train.getStoppingDetails(stationCode: fromStationCode)!.stoppingNumber
        let toStationNumber = train.getStoppingDetails(stationCode: toStationCode)!.stoppingNumber
        var seatCount = 0
        let availableSeatsWithQuotas = seatAvailabilityChart.availableSeatChart.availableSeatsWithQuotas
        print(coachType.rawValue,train.trainName)
        for coachNumber in availableSeatsWithQuotas[coachType]!.keys{
            for seatBookedWithStations in availableSeatsWithQuotas[coachType]! [coachNumber]!{
                let isStaionAvailable = checkStationsAvailable(fromStationNumber: fromStationNumber, toStationNumber: toStationNumber, bookedStations: seatBookedWithStations.bookedStations)
                
                if isStaionAvailable {
                    seatCount += 1
                    
                }
            }
        }
        
        
        return seatCount
    }
    
    func numberOfRACSeatsAvailable (coachType:CoachType,fromStationCode : String,toStationCode :String) -> Int{
        let train = seatAvailabilityChart.train
        
        let fromStationNumber = train.getStoppingDetails(stationCode: fromStationCode)!.stoppingNumber
        let toStationNumber = train.getStoppingDetails(stationCode: toStationCode)!.stoppingNumber
        var seatCount = 0
        let racSeatBookedStatus = seatAvailabilityChart.racSeatChart!.RACSeatsBookedStatus
        
        for coachNumber in racSeatBookedStatus[coachType]!.keys{
            for seatBookedWithStations in racSeatBookedStatus[coachType]![coachNumber]!{
                let isStaionAvailable = checkStationsAvailable(fromStationNumber: fromStationNumber, toStationNumber: toStationNumber, bookedStations: seatBookedWithStations.bookedStations)
                
                if isStaionAvailable {
                    seatCount += 1
//                    return seatBookedWithStations.RACOrWlNumber! - (seatAvailabilityChart.racSeatChart!.initialNumberOfRacSeats[coachType]!) + 1
                }
            }
        }
       return seatCount
    }
    
    func numberOfWLSeatsAvailable (coachType:CoachType,fromStationCode : String,toStationCode :String) -> Int{
        let train = seatAvailabilityChart.train
        
        let fromStationNumber = train.getStoppingDetails(stationCode: fromStationCode)!.stoppingNumber
        let toStationNumber = train.getStoppingDetails(stationCode: toStationCode)!.stoppingNumber
        var wlCount = 0
        let wLNumberBookedStatus = seatAvailabilityChart.wlSeatChart!.wLNumberBookedStatus
        for seatBookedWithStations in wLNumberBookedStatus[coachType]!{
            let isStaionAvailable = checkStationsAvailable(fromStationNumber: fromStationNumber, toStationNumber: toStationNumber, bookedStations: seatBookedWithStations.bookedStations)
            
            if isStaionAvailable {
                wlCount += 1
//                return seatBookedWithStations.RACOrWlNumber! - (seatAvailabilityChart.wlSeatChart!.initialNumberOfWLNumber[coachType]!) + 1
            }
        }
        print(wlCount)
        print("wlcount")
        return wlCount
    }
    
    func bookSeat (coachType:CoachType, seatType:SeatType?, prefferedCoachNumber:Int?, fromStationCode:String, toStationCode:String) -> BookingDetails?{
    
        
        if(seatAvailabilityChart.quotaType == .Senior_Citizen){
            return bookSeatInPrefferedSeatType(coachType: coachType, preferredSeatType: .Lower, fromStationCode: fromStationCode, toStationCode: toStationCode)
        }
        else{
            var bookingDetails : BookingDetails? = nil
            
            if (prefferedCoachNumber != nil && seatType != nil){
            
                bookingDetails = bookSeatInPrefferedCoachAndSeatType(coachType: coachType, preferredCoachNumber: prefferedCoachNumber!, preferredSeatType: seatType!, fromStationCode: fromStationCode, toStationCode: toStationCode)
                
                if(bookingDetails != nil){
                    return bookingDetails
                }
                
            }
            if(seatType != nil ){
                bookingDetails = bookSeatInPrefferedSeatType(coachType: coachType, preferredSeatType: seatType!, fromStationCode: fromStationCode, toStationCode: toStationCode)
                if(bookingDetails != nil){
                    return bookingDetails
                }
            }
            if (prefferedCoachNumber != nil) {
                bookingDetails = bookSeatInPrefferedCoachNumberType(coachType: coachType, fromStationCode: fromStationCode, toStationCode: toStationCode, preferredCoachNumber: prefferedCoachNumber!)
                if(bookingDetails != nil){
                    return bookingDetails
                }
            }
            
            bookingDetails = bookAnySeat(coachType: coachType, fromStationCode: fromStationCode, toStationCode: toStationCode)
            if(bookingDetails != nil){
                return bookingDetails
            }
        }
        return nil
        
    }
    
    private func checkStationsAvailable ( fromStationNumber: Int,toStationNumber:Int,bookedStations: [(fromStation:String,toStation:String)]) -> Bool {
        var flag:Bool = true
        let train = seatAvailabilityChart.train
        for bookedStation in bookedStations {
            let fromStationBookedNumber = train.getStoppingDetails(stationCode:bookedStation.fromStation)!.stoppingNumber
            let toStationBookedNumber = train.getStoppingDetails(stationCode:bookedStation.toStation)!.stoppingNumber
            
            if(!((fromStationNumber < toStationNumber) && (((fromStationNumber >= toStationBookedNumber) || (fromStationNumber < fromStationBookedNumber)) && ((toStationNumber <= fromStationBookedNumber) || (toStationNumber > toStationBookedNumber))))){
                flag = false
                return flag
            }

        }
        return true
    }
    
    private func bookSeatInPrefferedCoachAndSeatType (coachType :CoachType ,preferredCoachNumber :Int ,preferredSeatType: SeatType,fromStationCode : String, toStationCode : String)->BookingDetails?{
        let train = seatAvailabilityChart.train
        
        let fromStationNumber = train.getStoppingDetails(stationCode: fromStationCode)!.stoppingNumber
        let toStationNumber = train.getStoppingDetails(stationCode: toStationCode)!.stoppingNumber
        let availableSeatsWithQuotas = seatAvailabilityChart.availableSeatChart.availableSeatsWithQuotas
        
        let numberOfCoaches = train.numberOfCoachInEachType[coachType]!
        
        if numberOfCoaches < preferredCoachNumber {
            return nil
        }
        
        for seatBookedWithStation in availableSeatsWithQuotas[coachType]![preferredCoachNumber]!{
            if seatBookedWithStation.seat!.seatType == preferredSeatType{
                let isStaionAvailable = checkStationsAvailable(fromStationNumber: fromStationNumber, toStationNumber: toStationNumber, bookedStations: seatBookedWithStation.bookedStations)
                
                if isStaionAvailable{
                    seatBookedWithStation.setBookedStation(bookedStation: (fromStation: fromStationCode, toStation: toStationCode))
                    
                    dbManager.setBookedStationsInDb(quotaType: seatAvailabilityChart.quotaType, coachType: coachType, coachNumber: preferredCoachNumber, seatType: seatBookedWithStation.seat!.seatType, seatNumber: seatBookedWithStation.seat!.seatNumber, trainNumber: train.trainNumber, fromStation: fromStationCode, toStation: toStationCode, startDate: seatAvailabilityChart.startDate, ticketBookingStatus: .Confirmed,racOrWlId: nil,wlNumber: nil)
                    
                    return BookingDetails(coachNumber: preferredCoachNumber, seatType: seatBookedWithStation.seat!.seatType, seatNumber: seatBookedWithStation.seat!.seatNumber, ticketBookingStatus: .Confirmed, RacOrWlNumber: nil,wlNumber: nil)
                }
            }
        }
        return nil
    }
    
    private func bookSeatInPrefferedSeatType (coachType :CoachType ,preferredSeatType: SeatType,fromStationCode : String, toStationCode : String)->BookingDetails?{
        let train = seatAvailabilityChart.train
        
        let fromStationNumber = train.getStoppingDetails(stationCode: fromStationCode)!.stoppingNumber
        let toStationNumber = train.getStoppingDetails(stationCode: toStationCode)!.stoppingNumber
        let availableSeatsWithQuotas = seatAvailabilityChart.availableSeatChart.availableSeatsWithQuotas
        
        for coachNumber in availableSeatsWithQuotas[coachType]!.keys{
            for seatBookedWithStation in availableSeatsWithQuotas[coachType]![coachNumber]!{
                if seatBookedWithStation.seat!.seatType == preferredSeatType{
                    let isStaionAvailable = checkStationsAvailable(fromStationNumber: fromStationNumber, toStationNumber:     toStationNumber, bookedStations: seatBookedWithStation.bookedStations)
                
                    if isStaionAvailable{
                        seatBookedWithStation.setBookedStation(bookedStation: (fromStation: fromStationCode, toStation: toStationCode))
                        dbManager.setBookedStationsInDb(quotaType: seatAvailabilityChart.quotaType, coachType: coachType,coachNumber:coachNumber, seatType: seatBookedWithStation.seat!.seatType,seatNumber:     seatBookedWithStation.seat!.seatNumber, trainNumber: train.trainNumber, fromStation: fromStationCode, toStation: toStationCode, startDate: seatAvailabilityChart.startDate, ticketBookingStatus: .Confirmed,racOrWlId: 0,wlNumber: seatBookedWithStation.WlNumber)
                    
                        return BookingDetails( coachNumber: coachNumber, seatType: seatBookedWithStation.seat!.seatType, seatNumber: seatBookedWithStation.seat!.seatNumber, ticketBookingStatus: .Confirmed, RacOrWlNumber: nil,wlNumber: nil)
                    }
                }
            }
        }
        return nil
    }
    
    private func bookSeatInPrefferedCoachNumberType (coachType :CoachType ,fromStationCode : String, toStationCode : String,preferredCoachNumber:Int)->BookingDetails?{
        let train = seatAvailabilityChart.train
        
        let fromStationNumber = train.getStoppingDetails(stationCode: fromStationCode)!.stoppingNumber
        let toStationNumber = train.getStoppingDetails(stationCode: toStationCode)!.stoppingNumber
        let availableSeatsWithQuotas = seatAvailabilityChart.availableSeatChart.availableSeatsWithQuotas
        
        
        for seatBookedWithStation in availableSeatsWithQuotas[coachType]![preferredCoachNumber]!{
            let isStaionAvailable = checkStationsAvailable(fromStationNumber: fromStationNumber, toStationNumber:     toStationNumber, bookedStations: seatBookedWithStation.bookedStations)
                
            if isStaionAvailable{
                seatBookedWithStation.setBookedStation(bookedStation: (fromStation: fromStationCode, toStation: toStationCode))
                dbManager.setBookedStationsInDb(quotaType: seatAvailabilityChart.quotaType, coachType: coachType, coachNumber:preferredCoachNumber, seatType: seatBookedWithStation.seat!.seatType, seatNumber:     seatBookedWithStation.seat!.seatNumber, trainNumber: train.trainNumber, fromStation: fromStationCode,     toStation: toStationCode, startDate: seatAvailabilityChart.startDate, ticketBookingStatus: .Confirmed,racOrWlId: nil,wlNumber: nil)
                    
                return BookingDetails(coachNumber: preferredCoachNumber, seatType: seatBookedWithStation.seat!.seatType, seatNumber: seatBookedWithStation.seat!.seatNumber, ticketBookingStatus: .Confirmed, RacOrWlNumber: nil,wlNumber: nil)
            }
        }
        
        return nil
    }
    private func bookAnySeat(coachType :CoachType ,fromStationCode : String, toStationCode : String)->BookingDetails?{
        let train = seatAvailabilityChart.train
        
        let fromStationNumber = train.getStoppingDetails(stationCode: fromStationCode)!.stoppingNumber
        let toStationNumber = train.getStoppingDetails(stationCode: toStationCode)!.stoppingNumber
        let availableSeatsWithQuotas = seatAvailabilityChart.availableSeatChart.availableSeatsWithQuotas
        
        for coachNumber in availableSeatsWithQuotas[coachType]!.keys{
            for seatBookedWithStation in availableSeatsWithQuotas[coachType]![coachNumber]!{
                let isStaionAvailable = checkStationsAvailable(fromStationNumber: fromStationNumber, toStationNumber:     toStationNumber, bookedStations: seatBookedWithStation.bookedStations)
                
                if isStaionAvailable{
                    seatBookedWithStation.setBookedStation(bookedStation: (fromStation: fromStationCode, toStation: toStationCode))
                    dbManager.setBookedStationsInDb(quotaType: seatAvailabilityChart.quotaType, coachType: coachType, coachNumber: coachNumber, seatType: seatBookedWithStation.seat!.seatType, seatNumber:     seatBookedWithStation.seat!.seatNumber, trainNumber: train.trainNumber, fromStation: fromStationCode,toStation: toStationCode, startDate: seatAvailabilityChart.startDate, ticketBookingStatus: .Confirmed,racOrWlId: nil,wlNumber: nil)
                    
                    return BookingDetails(coachNumber: coachNumber, seatType: seatBookedWithStation.seat!.seatType, seatNumber:     seatBookedWithStation.seat!.seatNumber, ticketBookingStatus: .Confirmed, RacOrWlNumber: nil,wlNumber: nil)
                }
            }
        }
        return nil
    }
    
    func  bookRACSeat (coachType :CoachType ,fromStationCode : String, toStationCode : String)->BookingDetails?{
        let train = seatAvailabilityChart.train
        
        let fromStationNumber = train.getStoppingDetails(stationCode: fromStationCode)!.stoppingNumber
        let toStationNumber = train.getStoppingDetails(stationCode: toStationCode)!.stoppingNumber
        let racSeatsBookedStatus = seatAvailabilityChart.racSeatChart!.RACSeatsBookedStatus
        
        for coachNumber in racSeatsBookedStatus[coachType]!.keys{
            for seatBookedWithStation in racSeatsBookedStatus[coachType]![coachNumber]!{
                let isStaionAvailable = checkStationsAvailable(fromStationNumber: fromStationNumber, toStationNumber:     toStationNumber, bookedStations: seatBookedWithStation.bookedStations)
                
                if isStaionAvailable{
                    let racNumber = seatAvailabilityChart.racSeatChart!.initialNumberOfRacSeats[coachType]! - numberOfRACSeatsAvailable(coachType: coachType, fromStationCode: fromStationCode, toStationCode: toStationCode) + 1
                    seatBookedWithStation.setBookedStation(bookedStation: (fromStation: fromStationCode, toStation: toStationCode))
                    dbManager.setBookedStationsInDb(quotaType: nil, coachType: coachType, coachNumber: coachNumber, seatType: seatBookedWithStation.seat!.seatType, seatNumber: seatBookedWithStation.seat!.seatNumber, trainNumber: train.trainNumber, fromStation: fromStationCode, toStation: toStationCode, startDate: seatAvailabilityChart.startDate, ticketBookingStatus: .ReservationAgainstCancellation,racOrWlId: nil,wlNumber: nil)
                    
                    return BookingDetails(coachNumber: coachNumber, seatType: seatBookedWithStation.seat!.seatType, seatNumber: seatBookedWithStation.seat!.seatNumber, ticketBookingStatus: .ReservationAgainstCancellation, RacOrWlNumber: racNumber,wlNumber: nil)
                }
            }
        }
       return nil
    }
    
    func bookWLSeat (coachType :CoachType ,fromStationCode : String, toStationCode : String) -> BookingDetails?{
        let train = seatAvailabilityChart.train
        
        let fromStationNumber = train.getStoppingDetails(stationCode: fromStationCode)!.stoppingNumber
        let toStationNumber = train.getStoppingDetails(stationCode: toStationCode)!.stoppingNumber
        let wlNumberBookedStatus = seatAvailabilityChart.wlSeatChart!.wLNumberBookedStatus
        
        for seatBookedWithStation in wlNumberBookedStatus[coachType]!{
            let isStaionAvailable = checkStationsAvailable(fromStationNumber: fromStationNumber, toStationNumber:     toStationNumber, bookedStations: seatBookedWithStation.bookedStations)
            
            if isStaionAvailable{
                
                let wlRank = seatAvailabilityChart.wlSeatChart!.initialNumberOfWLNumber[coachType]! - numberOfWLSeatsAvailable(coachType: coachType, fromStationCode: fromStationCode, toStationCode: toStationCode) + 1
                
                seatBookedWithStation.setBookedStation(bookedStation: (fromStation: fromStationCode, toStation: toStationCode))
                dbManager.setBookedStationsInDb(quotaType: nil, coachType: coachType, coachNumber:nil, seatType: nil, seatNumber:nil, trainNumber: train.trainNumber, fromStation: fromStationCode, toStation: toStationCode, startDate: seatAvailabilityChart.startDate, ticketBookingStatus: .WaitingList,racOrWlId:wlRank,wlNumber: seatBookedWithStation.WlNumber)
                print("Wl rank\(wlRank)")
                
                print(seatAvailabilityChart.wlSeatChart!.initialNumberOfWLNumber[coachType]!)
                print(numberOfWLSeatsAvailable(coachType: coachType, fromStationCode: fromStationCode, toStationCode: toStationCode) + 1)
                
                
                return BookingDetails(coachNumber: nil, seatType: nil, seatNumber:nil, ticketBookingStatus: .WaitingList, RacOrWlNumber: wlRank,wlNumber: seatBookedWithStation.WlNumber!)
            }
        }
      return nil
    }
    
    func freeSeat(ticketBookingType: TicketBookingStatus,coachType: CoachType,coachNumber:Int?, seatNumber:Int?, fromStation:String, toStation:String,racOrWlNumber : Int?){
        
        
        
        
        var seatBookedWithStations : [SeatBookedWithStation]? = nil
        switch(ticketBookingType){
            case .Confirmed :
            
                seatBookedWithStations = seatAvailabilityChart.availableSeatChart.availableSeatsWithQuotas[coachType]![coachNumber!]!
        
            case .ReservationAgainstCancellation :
                seatBookedWithStations = seatAvailabilityChart.racSeatChart!.RACSeatsBookedStatus[coachType]![coachNumber!]!
                
         
            case .WaitingList :
                seatBookedWithStations = seatAvailabilityChart.wlSeatChart!.wLNumberBookedStatus[coachType]!
            
            
            case .Cancelled:
                return
        }
        for seatBookedWithStation in seatBookedWithStations!{
            
            if let seat =  seatBookedWithStation.seat{
                if seat.seatNumber ==  seatNumber{
                    seatBookedWithStation.removeBookedStation(removeStation: (fromStation: fromStation,toStation: toStation))
                    
                }
            }
            
            else if seatBookedWithStation.WlNumber == racOrWlNumber {
                seatBookedWithStation.removeBookedStation(removeStation: (fromStation: fromStation,toStation: toStation))
            }
            
        }
        
    }
        
}


enum TicketBookingStatus: String,CaseIterable{
    case Confirmed = "CNF"
    case ReservationAgainstCancellation = "RAC"
    case WaitingList = "WL"
    case Cancelled = "CANCELLED"
    
}
    
