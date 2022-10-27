//
//  TicketCounter.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 02/08/22.
//

import Foundation


class TicketCounter {
    
    let dbManager = DBManager.getInstance()
    
    init (){
        
    }
    
    func trainListForUserInput (quotatype : QuotaType,travelDate : Date,fromStation:String,toStation:String,coachType:CoachType) -> [Train]{
        //fromstation != tostation
        // date with in  7 days
        // stationNames correctly
        print(travelDate.toString(format: "dd-MM-yyyy HH:mm"))
        print(travelDate.dayNumberOfWeek()!)
        let travelDay = travelDate.dayNumberOfWeek()!
        
        var  availableTrainsList : [Train] = []
        let stationNames = dbManager.getStationNamesandCodes()
        var fromStationCode : String = ""
        var toStationCode : String = ""
        if let fromStationIndex = stationNames.values.firstIndex(of: fromStation){
            fromStationCode = stationNames.keys[fromStationIndex]
            print(fromStationCode)
        }
        if let toStationIndex = stationNames.values.firstIndex(of: toStation){
            toStationCode = stationNames.keys[toStationIndex]
            print(toStationCode)
        }
        let availabletrains = dbManager.getAvailableTrains(travelDayOfWeek: travelDay, fromStationNameCode: fromStationCode, toStationNameCode: toStationCode)
        
        
        for availabletrain in availabletrains {
            print("train Number \(availabletrain)")
            
            let train = dbManager.getTrainDetails(trainNumber: availabletrain)!
            if train.getStoppingDetails(stationCode: fromStationCode)!.stoppingNumber < train.getStoppingDetails(stationCode: toStationCode)!.stoppingNumber{
                availableTrainsList.append(train)
            }
            
            
        }

        
        return availableTrainsList
    }
    
    
    func bookTickets(quotatype : QuotaType,travelDate :Date,fromStationCode:String ,toStationCode:String ,coachType:CoachType ,trainNumber:Int, ticketNeeded:Int, passengerDetailsInputs:[PassengerDetailsInput],prefferedCoachNumberString : String?,isTravelInsuranceOpt : Bool) -> Ticket?{
        
        var train = dbManager.getTrainDetails(trainNumber: trainNumber)!
        let startDate = travelDate.getDateFor(days: -(train.getStoppingDetails(stationCode: fromStationCode)!.arrivalDayOfTheTrain - 1))!
        
        var passengerDetailsList : [PassengerDetails] = []
        
        var prefferedCoachNumber : Int? = nil
        if let  value = prefferedCoachNumberString{
            
            prefferedCoachNumber = Int(value.substring(fromIndex: 1))
        }
        
        if prefferedCoachNumber ?? 100 > train.getCoaches()[coachType]?.count ?? 0{
            prefferedCoachNumber = nil
        }
        for passenger in passengerDetailsInputs{
            
            let bookingDetailsOfPassenger = bookTicketForAPassenger(trainNumber: trainNumber, quotaType: quotatype, startDate: startDate, coachType: coachType, seatType: passenger.seatTypePreference, prefferedCoachNumber: prefferedCoachNumber, fromStationCode: fromStationCode, toStationCode: toStationCode)
            
            let passengerDetails = PassengerDetails(name: passenger.name, age: passenger.age, gender: passenger.gender, bookingDetails: bookingDetailsOfPassenger!)
            
            passengerDetailsList.append(passengerDetails)
        }

        let startTime = train.getStoppingDetails(stationCode: fromStationCode)!.departureTime
        let endtime = train.getStoppingDetails(stationCode: toStationCode)!.arrivalTime
        
       
        let startTravelDate = travelDate
        let endTravelDate = travelDate.getDateFor(days: (train.getStoppingDetails(stationCode: toStationCode)!.arrivalDayOfTheTrain - train.getStoppingDetails(stationCode: fromStationCode)!.departureDayOfTheTrain))
       
        
        let startTimeString = startTime.toString(format: "HH:mm")//"yyyy-MM-dd'T'HH:mm"
        let startTravelDateString = startTravelDate.toString(format: "yyyy-MM-dd")
        
        let endTimeString = endtime.toString(format: "HH:mm")//"yyyy-MM-dd'T'HH:mm"
        let endTravelDateString = endTravelDate!.toString(format: "yyyy-MM-dd")
        
        let dateFormatter =  DateFormatter()
        let startDateAndTime = dateFormatter.toDate(format: "yyyy-MM-dd'T'HH:mm", string: "\(startTravelDateString)T\(startTimeString)")
        let endDateAndTime = dateFormatter.toDate(format: "yyyy-MM-dd'T'HH:mm", string: "\(endTravelDateString)T\(endTimeString)")
        let pnrNumber = generatePnrNumber()
        
        print("endTravelDate\(endDateAndTime)")

        
        let ticketFare = fareCalculator(fromStationCode: fromStationCode, toStationCode: toStationCode, train: train,coachType: coachType,quotaType: quotatype,numberOfPassengers: passengerDetailsInputs.count, isTravelInsuranceOpt: isTravelInsuranceOpt , isOnlyFareNeeded: false)
        let ticket = Ticket(pnrNumber: pnrNumber, trainNumber: trainNumber, fromStation: fromStationCode, toStation: toStationCode, quotaType: quotatype, coachType: coachType, startTime: startDateAndTime, endTime: endDateAndTime,passengerDetails: passengerDetailsList,ticketFare: ticketFare,isTravelInsuranceOpt: isTravelInsuranceOpt,startDate: startDate)
        
        dbManager.insertTicketDetails(ticket: ticket)
        dbManager.insertToUserticketList(userId:"UserId",pnrNumber:pnrNumber)
        
        return ticket
        

    }
    
    func getSeatAvailabilityInEachBookingType (trainNumber :Int,travelDate :Date,fromStation :String,toStation :String,quotatype :QuotaType,coachType :CoachType) -> SeatAvailableInEachBookingType{
        
        let train = dbManager.getTrainDetails(trainNumber: trainNumber)
        var seatAvailabilityChart:SeatAvailabilityChart? = nil
        let stationNames = dbManager.getStationNamesandCodes()
        var fromStationCode : String = ""
        var toStationCode : String = ""
        if let fromStationIndex = stationNames.values.firstIndex(of: fromStation){
            fromStationCode = stationNames.keys[fromStationIndex]
        }
        if let toStationIndex = stationNames.values.firstIndex(of: toStation){
            toStationCode = stationNames.keys[toStationIndex]
        }

        if(train!.numberOfDaysRunning == 1){
            seatAvailabilityChart = dbManager.getSeatChartForQuotaType(trainNumber: trainNumber, quotaType: quotatype, startDate: travelDate)
        }
        else{
            let today = Date()
//            let dateformatter = DateFormatter()
            
            let dateComparison : ComparisonResult = Calendar.current.compare(today, to: travelDate.getDateFor(days: (train!.getStoppingDetails(stationCode: fromStationCode)!.arrivalDayOfTheTrain - 1))!, toGranularity: .day)
           
            
           
            if dateComparison != .orderedDescending{
                let startDate = travelDate.getDateFor(days: -(train!.getStoppingDetails(stationCode: fromStationCode)!.arrivalDayOfTheTrain - 1))!
                seatAvailabilityChart = dbManager.getSeatChartForQuotaType(trainNumber: trainNumber, quotaType: quotatype, startDate: startDate)
                
                print("inside 2 days\(startDate.toString(format: "yyyy-MM-dd"))travel date \(travelDate)")
            }
        }
        guard let seatAvailabilityChart = seatAvailabilityChart else{
            print("\(trainNumber) caleed")
            return SeatAvailableInEachBookingType(seatsAvailable: 0, racSeatsAvailable: 0, racSeatsBooked: 0, wlSeatsAvailable: 0, wlSeatsBooked: 0)
        }
        let seatManager = SeatManager(seatAvailabilityChart: seatAvailabilityChart)
        return seatManager.numberOfSeatsAvailableInEachBookingType(fromStationCode: fromStationCode, toStationCode: toStationCode, coachType: coachType)
    }
    
    func generatePnrNumber()->UInt64{
        let pnrNumber = UInt64.random(in: 100_000_0000...999_999_9999)
        let pnrNumbers = dbManager.getPnrNumbers()
        
        if pnrNumbers.contains(pnrNumber){
            let _ = generatePnrNumber()
        }
        return pnrNumber
    }
    
    func cancelTicket(pnrNumber:UInt64, userId:String){
        
    }
    
    func fareCalculator (fromStationCode :String, toStationCode:String, train:Train, coachType:CoachType, quotaType:QuotaType, numberOfPassengers:Int,isTravelInsuranceOpt : Bool , isOnlyFareNeeded:Bool) -> Float {
        
        let fromStationDistanceFromOrigin = train.getStationPassByDetails(stationCode: fromStationCode)!.distanceFromOrigin
        let toStationDistanceFromOrigin = train.getStationPassByDetails(stationCode: toStationCode)!.distanceFromOrigin
        let distanceToBeTravelled =  toStationDistanceFromOrigin - fromStationDistanceFromOrigin
        var totalFare :Float = 0.0
        let trainTypeDetails = train.trainTypeDetails
        let farePerKm = trainTypeDetails.farePerKm[coachType]!
        
        let  travelInsurance : Float = isTravelInsuranceOpt ? 0.65 : 0.00
        let  convenienceFee : Float = 17.55
        
        
        
        if quotaType != .Senior_Citizen{
            totalFare = Float((distanceToBeTravelled * farePerKm * Float(numberOfPassengers) )) 
        }
        else{
            totalFare = (distanceToBeTravelled * farePerKm * Float(numberOfPassengers) - distanceToBeTravelled * farePerKm * Float(numberOfPassengers) * 30/100)
        }
        
        
        if isOnlyFareNeeded {
            return totalFare
        }
        return totalFare + travelInsurance + convenienceFee
        
    }
    
    
//    func alterTicket (ticket:Ticket) -> Ticket?{
//
//
//        let travelDateString = ticket.startTime.toString(format: "dd-MM-yyyy")
//
//        let dateFormatter = DateFormatter()
//        let travelDate = dateFormatter.toDate(format: "dd-MM-yyyy", string: travelDateString)
//
//
//        let train = dbManager.getTrainDetails(trainNumber: ticket.trainNumber)!
//        let startDate = travelDate.getDateFor(days: -(train.getStoppingDetails(stationCode: ticket.fromStation)!.arrivalDayOfTheTrain - 1))!
//
//        let passengerDetailsList : [PassengerDetails] = ticket.passengerDetails
//
//
//
//        var finalPassengerList : [PassengerDetails] = []
//
//        for passenger in passengerDetailsList{
//
//            if passenger.bookingDetails.ticketBookingStatus != .Confirmed{
//
//                let seatAvailabilityChart = dbManager.getSeatChartForQuotaType(trainNumber: ticket.trainNumber, quotaType: ticket.quotaType, startDate: startDate)
//                let seatManager = SeatManager(seatAvailabilityChart: seatAvailabilityChart)
//                //normal Seat
//                var bookingDetailsOfPassenger = seatManager.bookSeat(coachType: ticket.coachType, seatType: nil, prefferedCoachNumber: nil, fromStationCode: ticket.fromStation, toStationCode: ticket.toStation)
//                //wlSeat
//                if (bookingDetailsOfPassenger == nil) && (ticket.coachType != .AirConditioned2TierClass && ticket.coachType != .AirConditioned3TierClass && ticket.coachType != .SleeperClass){
//                    bookingDetailsOfPassenger = seatManager.bookWLSeat(coachType: ticket.coachType, fromStationCode: ticket.fromStation, toStationCode: ticket.toStation)
//                }
//                //rac and wl seat
//                else if (bookingDetailsOfPassenger == nil){
//                    bookingDetailsOfPassenger = seatManager.bookRACSeat(coachType: ticket.coachType, fromStationCode: ticket.fromStation, toStationCode: ticket.toStation)
//                    if(bookingDetailsOfPassenger == nil){
//                        bookingDetailsOfPassenger = seatManager.bookWLSeat(coachType: ticket.coachType, fromStationCode: ticket.fromStation, toStationCode: ticket.toStation)
//                    }
//                }
//
//                if bookingDetailsOfPassenger == nil{
//                    return nil
//                }
//                let passengerDetails = PassengerDetails(name: passenger.name, age: passenger.age, gender: passenger.gender, bookingDetails: bookingDetailsOfPassenger!)
//
//                finalPassengerList.append(passengerDetails)
//
//            }
//
//            else{
//                finalPassengerList.append(passenger)
//            }
//
//
//
//        }
//
//
//
//
//
//
//        let ticket = Ticket(pnrNumber: ticket.pnrNumber, trainNumber: ticket.trainNumber, fromStation: ticket.fromStation, toStation: ticket.toStation, quotaType: ticket.quotaType, coachType: ticket.coachType, startTime: ticket.startTime, endTime: ticket.endTime,passengerDetails: finalPassengerList,ticketFare: ticket.ticketFare,isTravelInsuranceOpt: ticket.isTravelInsuranceOpt,startDate: startDate)
//
//        dbManager.insertTicketDetails(ticket: ticket)
//        dbManager.insertToUserticketList(userId:"UserId",pnrNumber:ticket.pnrNumber)
//
//        return ticket
//    }
    
    
    
    func bookTicketForAPassenger (trainNumber : Int, quotaType:QuotaType,  startDate:Date, coachType:CoachType, seatType:SeatType?, prefferedCoachNumber:Int?, fromStationCode:String, toStationCode:String) -> BookingDetails?{
        
        
        
        
        let seatAvailabilityChart = dbManager.getSeatChartForQuotaType(trainNumber: trainNumber, quotaType: quotaType, startDate: startDate)
        let seatManager = SeatManager(seatAvailabilityChart: seatAvailabilityChart)
        //normal Seat
        var bookingDetailsOfPassenger = seatManager.bookSeat(coachType: coachType, seatType: seatType, prefferedCoachNumber: prefferedCoachNumber, fromStationCode: fromStationCode, toStationCode: toStationCode)
        //wlSeat
        if (bookingDetailsOfPassenger == nil) && (coachType != .AirConditioned2TierClass && coachType != .AirConditioned3TierClass && coachType != .SleeperClass){
            print("hi")
            bookingDetailsOfPassenger = seatManager.bookWLSeat(coachType: coachType, fromStationCode: fromStationCode, toStationCode: toStationCode)
        }
        //rac and wl seat
        else if (bookingDetailsOfPassenger == nil){
            bookingDetailsOfPassenger = seatManager.bookRACSeat(coachType: coachType, fromStationCode: fromStationCode, toStationCode: toStationCode)
            if(bookingDetailsOfPassenger == nil){
                bookingDetailsOfPassenger = seatManager.bookWLSeat(coachType: coachType, fromStationCode: fromStationCode, toStationCode: toStationCode)
            }
        }
        if bookingDetailsOfPassenger == nil{
            return nil
        }
        else{
            return bookingDetailsOfPassenger
        }
        
    }
    
    
    
    
    func cancelTicket(ticket:Ticket){
        
        let trainNumber = ticket.trainNumber
        let train = dbManager.getTrainDetails(trainNumber: trainNumber)!
        let travelDateString = ticket.startTime.toString(format: "yyyy-MM-dd")
        let dateFormatter = DateFormatter()
        let fromStationCode = ticket.fromStation
        let toStationCode = ticket.toStation
        let travelDate = dateFormatter.toDate(format: "yyyy-MM-dd", string: travelDateString)
        let startDate = travelDate.getDateFor(days: -(train.getStoppingDetails(stationCode: fromStationCode)!.arrivalDayOfTheTrain - 1))!
        
        let seatAvailabilityChart = dbManager.getSeatChartForQuotaType(trainNumber: trainNumber, quotaType: ticket.quotaType, startDate: startDate)
        let seatManager = SeatManager(seatAvailabilityChart: seatAvailabilityChart)
        let numberOfSeatsAvailableinEachType = seatManager.numberOfSeatsAvailableInEachBookingType(fromStationCode: fromStationCode, toStationCode: toStationCode, coachType: ticket.coachType)
        let coachType = ticket.coachType
        
        if(numberOfSeatsAvailableinEachType.seatsAvailable > 0 || ticket.quotaType != .General){
            print("hi")
            for passengerDetail in ticket.passengerDetails{
                let bookingDetails = passengerDetail.bookingDetails
                seatManager.freeSeat(ticketBookingType: bookingDetails.ticketBookingStatus, coachType:coachType, coachNumber: bookingDetails.coachNumber, seatNumber: bookingDetails.seatNumber, fromStation: fromStationCode, toStation: toStationCode,racOrWlNumber: bookingDetails.RacOrWlRank)
                dbManager.removeStationFromBooked(fromStation: fromStationCode, toStation: toStationCode, coachType: coachType, quotaType: seatAvailabilityChart.quotaType, racOrWlId: bookingDetails.RacOrWlRank, startDate: startDate, trainNumber: trainNumber, coachNumber: bookingDetails.coachNumber, seatType: bookingDetails.seatType, ticketBookingStatus: bookingDetails.ticketBookingStatus, seatNumber: bookingDetails.seatNumber, wlNumber: bookingDetails.wlNumber)
            }
            
        }
        
        
        else if (numberOfSeatsAvailableinEachType.seatsAvailable == 0 && ticket.quotaType == .General && (coachType == .AirConditioned2TierClass || coachType == .AirConditioned3TierClass || coachType == .SleeperClass) ){
            print("hi2")
            
            
            
            for passengerDetail in ticket.passengerDetails{
                let bookingDetails = passengerDetail.bookingDetails
                seatManager.freeSeat(ticketBookingType: bookingDetails.ticketBookingStatus, coachType:coachType, coachNumber: bookingDetails.coachNumber, seatNumber: bookingDetails.seatNumber!, fromStation: fromStationCode, toStation: toStationCode,racOrWlNumber: bookingDetails.RacOrWlRank)
                dbManager.removeStationFromBooked(fromStation: fromStationCode, toStation: toStationCode, coachType: coachType, quotaType: seatAvailabilityChart.quotaType, racOrWlId: bookingDetails.RacOrWlRank, startDate: startDate, trainNumber: trainNumber, coachNumber: bookingDetails.coachNumber, seatType: bookingDetails.seatType, ticketBookingStatus: bookingDetails.ticketBookingStatus, seatNumber: bookingDetails.seatNumber, wlNumber: bookingDetails.wlNumber)
            }
            
            updateRacTickets(startDate: startDate, coachType: coachType, trainNumber: trainNumber, fromStationCode: fromStationCode, toStationCode: toStationCode)
            
            updateWlWithRacTickets(startDate: startDate, coachType: coachType, trainNumber: trainNumber, fromStationCode: fromStationCode, toStationCode: toStationCode)
                
           
            
            
                
        }
        
        
        else {
            print("hi3")
            
            for passengerDetail in ticket.passengerDetails{
                
                let bookingDetails = passengerDetail.bookingDetails
                seatManager.freeSeat(ticketBookingType: bookingDetails.ticketBookingStatus, coachType:coachType, coachNumber: bookingDetails.coachNumber, seatNumber: bookingDetails.seatNumber, fromStation: fromStationCode, toStation: toStationCode,racOrWlNumber: bookingDetails.RacOrWlRank)
                dbManager.removeStationFromBooked(fromStation: fromStationCode, toStation: toStationCode, coachType: coachType, quotaType: seatAvailabilityChart.quotaType, racOrWlId: bookingDetails.RacOrWlRank, startDate: startDate, trainNumber: trainNumber, coachNumber: bookingDetails.coachNumber, seatType: bookingDetails.seatType, ticketBookingStatus: bookingDetails.ticketBookingStatus, seatNumber: bookingDetails.seatNumber, wlNumber: bookingDetails.wlNumber)
            }
            
            
            updateWlWithCnfTickets(startDate: startDate, coachType: coachType, trainNumber: trainNumber, fromStationCode: fromStationCode, toStationCode: toStationCode)
            
           
            
        }
        
        ticket.ticketFare = calculateRefundAmount(ticketfare: ticket.ticketFare)
        dbManager.cancelTicket(pnrNumber: ticket.pnrNumber,ticketFare : ticket.ticketFare)
        
        
        
    }
    func updateRacOrWlRank (fromStationCode:String, toStationCode:String, coachType:CoachType,trainNumber:Int,startDate:Date,racOrWl:TicketBookingStatus){
        
        dbManager.updateRacOrWlRank(fromStationCode: fromStationCode, toStationCode: toStationCode, coachType: coachType, trainNumber: trainNumber, startDate: startDate, racOrWl:racOrWl)
        
    }
    
    
    func updateRacTickets (startDate:Date,coachType:CoachType,trainNumber:Int,fromStationCode:String,toStationCode:String) {
        
        
        let racTickets = dbManager.retrieveRacOrWlTickets(coachType: coachType, trainNumber: trainNumber, ticketStatus: .ReservationAgainstCancellation,startDate:startDate)
        
        var updatedFromAndToStation :[(fromStation:String,toStation:String)] = []
        
        for racTicket in racTickets {
            
            
            let seatAvailabilityChart = dbManager.getSeatChartForQuotaType(trainNumber: racTicket.trainNumber, quotaType: racTicket.quotaType, startDate: racTicket.startDate)
            let seatManager = SeatManager(seatAvailabilityChart:seatAvailabilityChart)
            
            if  seatManager.numberOfSeatsAvailable(fromStationCode: racTicket.fromStation, toStationCode:  racTicket.toStation, coachType: coachType) == 0 {
                continue
            }
            var isTicketUpdated = false
            var passengerCount = 0
            
            for passenger in racTicket.passengerDetails{
                
                if passenger.bookingDetails.ticketBookingStatus != .Confirmed {
                    
                    let prefferedCoachNumber : Int? = nil
                    
                    
                    let tryToBook = seatManager.bookSeat(coachType: racTicket.coachType, seatType: SeatType(rawValue: "qq"), prefferedCoachNumber: prefferedCoachNumber, fromStationCode: racTicket.fromStation, toStationCode: racTicket.toStation)
                    
                    if let tryToBook = tryToBook {
                        seatManager.freeSeat(ticketBookingType: passenger.bookingDetails.ticketBookingStatus, coachType: racTicket.coachType, coachNumber: passenger.bookingDetails.coachNumber, seatNumber: passenger.bookingDetails.seatNumber, fromStation: racTicket.fromStation, toStation: racTicket.toStation, racOrWlNumber: passenger.bookingDetails.RacOrWlRank)
                        
                        dbManager.removeStationFromBooked(fromStation: fromStationCode, toStation: toStationCode, coachType: coachType, quotaType: seatAvailabilityChart.quotaType, racOrWlId: passenger.bookingDetails.RacOrWlRank, startDate: startDate, trainNumber: trainNumber, coachNumber: passenger.bookingDetails.coachNumber, seatType: passenger.bookingDetails.seatType, ticketBookingStatus: passenger.bookingDetails.ticketBookingStatus, seatNumber: passenger.bookingDetails.seatNumber, wlNumber: passenger.bookingDetails.wlNumber)
                        
                        dbManager.updatePassengerDetails(bookingDetails: tryToBook, pnrNumber: racTicket.pnrNumber, oldBookingDetails: passenger.bookingDetails)
                        
                        passenger.setBookingDetails(bookingDetails: tryToBook)
                        isTicketUpdated = true
                    }//let try To book
                }
                if isTicketUpdated{
                    updatedFromAndToStation.append((fromStation: racTicket.fromStation, toStation: racTicket.toStation))
                }
                passengerCount += 1
            }//passenger
            
            if racTicket.updateStatus() {
                dbManager.updateTicketBookingStatus(pnrNumber: racTicket.pnrNumber, ticketBookingStatus: racTicket.ticketStatus)
            }
        }//rac ticket
        
        
        for updatedFromAndToStation in updatedFromAndToStation {
            
            updateRacOrWlRank(fromStationCode: updatedFromAndToStation.fromStation, toStationCode: updatedFromAndToStation.toStation,coachType: coachType,trainNumber: trainNumber,startDate: startDate,racOrWl: .ReservationAgainstCancellation)
            
            
        }
        
    }
    
    
    func updateWlWithRacTickets (startDate:Date, coachType:CoachType, trainNumber:Int, fromStationCode:String, toStationCode:String) {
        let wlTickets =  dbManager.retrieveRacOrWlTickets(coachType: coachType, trainNumber: trainNumber, ticketStatus: .WaitingList,startDate:startDate)
        
        var updatedFromAndToStation :[(fromStation:String,toStation:String)] = []
        
        
        for wlTicket in wlTickets {
            let seatAvailabilityChart = dbManager.getSeatChartForQuotaType(trainNumber: wlTicket.trainNumber, quotaType: wlTicket.quotaType, startDate: wlTicket.startDate)
            let seatManager = SeatManager(seatAvailabilityChart:seatAvailabilityChart)
            
            if  seatManager.numberOfSeatsAvailable(fromStationCode: wlTicket.fromStation, toStationCode:  wlTicket.toStation, coachType: coachType) == 0 {
                continue
            }
            var isTicketUpdated = false
            var passengerCount = 0
            
            for passenger in wlTicket.passengerDetails{
                
                if passenger.bookingDetails.ticketBookingStatus != .Confirmed {
                    
                   
                    let tryToBook = seatManager.bookRACSeat(coachType: wlTicket.coachType, fromStationCode: wlTicket.fromStation, toStationCode: wlTicket.toStation)
                    
                    if let tryToBook = tryToBook {
                        
                        seatManager.freeSeat(ticketBookingType: passenger.bookingDetails.ticketBookingStatus, coachType: wlTicket.coachType, coachNumber: passenger.bookingDetails.coachNumber, seatNumber: passenger.bookingDetails.seatNumber, fromStation: wlTicket.fromStation, toStation: wlTicket.toStation, racOrWlNumber: passenger.bookingDetails.RacOrWlRank)
                        
                        dbManager.removeStationFromBooked(fromStation: fromStationCode, toStation: toStationCode, coachType: coachType, quotaType: seatAvailabilityChart.quotaType, racOrWlId: passenger.bookingDetails.RacOrWlRank, startDate: startDate, trainNumber: trainNumber, coachNumber: passenger.bookingDetails.coachNumber, seatType: passenger.bookingDetails.seatType, ticketBookingStatus: passenger.bookingDetails.ticketBookingStatus, seatNumber: passenger.bookingDetails.seatNumber, wlNumber: passenger.bookingDetails.wlNumber)
                        
                        dbManager.updatePassengerDetails(bookingDetails: tryToBook, pnrNumber: wlTicket.pnrNumber, oldBookingDetails: passenger.bookingDetails)
                        
                        passenger.setBookingDetails(bookingDetails: tryToBook)
                        isTicketUpdated = true
                        
                    }//let try To book
                }
                if isTicketUpdated{
                    updatedFromAndToStation.append((fromStation: wlTicket.fromStation, toStation: wlTicket.toStation))
                }
                passengerCount += 1
            }//passenger
            
            if wlTicket.updateStatus() {
                dbManager.updateTicketBookingStatus(pnrNumber: wlTicket.pnrNumber, ticketBookingStatus: wlTicket.ticketStatus)
            }
        }
        
        for updatedFromAndToStation in updatedFromAndToStation {
           
           updateRacOrWlRank(fromStationCode: updatedFromAndToStation.fromStation, toStationCode: updatedFromAndToStation.toStation,coachType: coachType,trainNumber: trainNumber,startDate: startDate,racOrWl: .WaitingList)
           
           
       }
    }
    
    
    func updateWlWithCnfTickets (startDate:Date, coachType:CoachType, trainNumber:Int, fromStationCode:String, toStationCode:String) {
        
        
        
        
        let wlTickets =  dbManager.retrieveRacOrWlTickets(coachType: coachType, trainNumber: trainNumber, ticketStatus: .WaitingList,startDate:startDate)
        
        var updatedFromAndToStation :[(fromStation:String,toStation:String)] = []
        
        print("wl ticket count \(wlTickets.count)")
        
        for wlTicket in wlTickets {
            let seatAvailabilityChart = dbManager.getSeatChartForQuotaType(trainNumber: wlTicket.trainNumber, quotaType: wlTicket.quotaType, startDate: wlTicket.startDate)
            let seatManager = SeatManager(seatAvailabilityChart:seatAvailabilityChart)
            
            if  seatManager.numberOfSeatsAvailable(fromStationCode: wlTicket.fromStation, toStationCode:  wlTicket.toStation, coachType: coachType) == 0 {
                continue
            }
            var isTicketUpdated = false
            var passengerCount = 0
            
            for passenger in wlTicket.passengerDetails{
                
                if passenger.bookingDetails.ticketBookingStatus != .Confirmed {
                    
                   
                    
                    
                    let tryToBook = seatManager.bookSeat(coachType: coachType, seatType: SeatType(rawValue: "ss"), prefferedCoachNumber: Int("ss"), fromStationCode: fromStationCode, toStationCode: toStationCode)
                    
                    if let tryToBook = tryToBook {
                        
                    
                        
                        
                        seatManager.freeSeat(ticketBookingType: passenger.bookingDetails.ticketBookingStatus, coachType: wlTicket.coachType, coachNumber: passenger.bookingDetails.coachNumber, seatNumber: passenger.bookingDetails.seatNumber, fromStation: wlTicket.fromStation, toStation: wlTicket.toStation, racOrWlNumber: passenger.bookingDetails.RacOrWlRank)
                        
                        dbManager.removeStationFromBooked(fromStation: fromStationCode, toStation: toStationCode, coachType: coachType, quotaType: seatAvailabilityChart.quotaType, racOrWlId: passenger.bookingDetails.RacOrWlRank, startDate: startDate, trainNumber: trainNumber, coachNumber: passenger.bookingDetails.coachNumber, seatType: passenger.bookingDetails.seatType, ticketBookingStatus: passenger.bookingDetails.ticketBookingStatus, seatNumber: passenger.bookingDetails.seatNumber, wlNumber: passenger.bookingDetails.wlNumber)
                        
                        dbManager.updatePassengerDetails(bookingDetails: tryToBook, pnrNumber: wlTicket.pnrNumber, oldBookingDetails: passenger.bookingDetails)
                        
                        passenger.setBookingDetails(bookingDetails: tryToBook)
                        isTicketUpdated = true
                        
                    }//let try To book
                }
                if isTicketUpdated{
                    updatedFromAndToStation.append((fromStation: wlTicket.fromStation, toStation: wlTicket.toStation))
                }
                passengerCount += 1
            }//passenger
            
            if wlTicket.updateStatus() {
                dbManager.updateTicketBookingStatus(pnrNumber: wlTicket.pnrNumber, ticketBookingStatus: wlTicket.ticketStatus)
            }
        }
        
        for updatedFromAndToStation in updatedFromAndToStation {
           
           updateRacOrWlRank(fromStationCode: updatedFromAndToStation.fromStation, toStationCode: updatedFromAndToStation.toStation,coachType: coachType,trainNumber: trainNumber,startDate: startDate,racOrWl: .WaitingList)
           
           
       }
    }
    
    
    func calculateRefundAmount (ticketfare : Float) -> Float {
        let serviceCharge : Float = ticketfare * 30/100
        let netCharge : Float = 5.25
        
        return ticketfare - serviceCharge - netCharge
    }

}



