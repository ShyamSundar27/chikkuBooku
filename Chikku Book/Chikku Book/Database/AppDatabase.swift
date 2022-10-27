//
//  AppDatabase.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 26/07/22.
//

import Foundation
import SQLite3
import UIKit


class AppDatabase{
    
    
    var dbPointer : OpaquePointer?
    var path = "RailwayReservationSystem.sqlite"
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    
    init(){
        dbPointer = createDataBase()
        createTables()
    }
    
    func createDataBase() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
        print(filePath)
        var tempDb : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &tempDb) != SQLITE_OK {
            print("Not Created")
            return nil
        }
        else{
            print("Created File \(path)")
            return tempDb
        }
    
    }
    
    func createTables (){
        
        let createUserTableQuery = "CREATE TABLE IF NOT EXISTS User(userName TEXT PRIMARY KEY ,name TEXT,mail TEXT,mobileNumber INTEGER);"
        
        let createTrainTableQuery = "CREATE TABLE IF NOT EXISTS Train(trainNumber INTEGER PRIMARY KEY ,trainName TEXT , trainType TEXT,numberOfDaysRunning INTEGER,numberOf2SCoaches INTEGER  , numberOfSLCoaches INTEGER ,numberOf1ACCoaches INTEGER , numberOf2ACCoaches INTEGER ,numberOf3ACCoaches INTEGER,numberOfCCCoaches INTEGER,numberOfECCoaches INTEGER);"
        
        let createTicketTableQuery = "CREATE TABLE IF NOT EXISTS Ticket(pnrNumber INTEGER PRIMARY KEY ,trainNumber INTEGER  , fromStation TEXT ,toStation TEXT , quotaType TEXT ,coachType TEXT, startTime TEXT,endTime TEXT,trainStartDate  TEXT, ticketStatus TEXT,ticketFare REAL,isTravelInsuranceOpt TEXT);"
        
        let createCancelledTicketTableQuery = "CREATE TABLE IF NOT EXISTS CancelledTicket(pnrNumber INTEGER PRIMARY KEY ,trainNumber INTEGER  , fromStation TEXT ,toStation TEXT , quotaType TEXT ,coachType TEXT, startTime TEXT,endTime TEXT,trainStartDate  TEXT, ticketStatus TEXT,ticketFare REAL,isTravelInsuranceOpt TEXT);"
        
        let createTrainTypeTableQuery = "CREATE TABLE IF NOT EXISTS TrainType(trainType TEXT PRIMARY KEY ,farePerKm2SCoach REAL,farePerKmSLCCoach REAL,farePerKm1ACCoach REAL,farePerKm2ACCoach REAL,farePerKm3ACoach REAL,farePerKmCCCoach REAL,farePerKmECCoach REAL );"
        
        let createStationDetailsTableQuery = "CREATE TABLE IF NOT EXISTS Station(stationCode TEXT PRIMARY KEY ,stationName TEXT)"
        
        let createSavedPassengerTableQuery = "CREATE TABLE IF NOT EXISTS SavedPassenger(passengerNumber  INTEGER,name TEXT ,age INTEGER , gender TEXT ,userName TEXT,berthPreference TEXT,PRIMARY KEY (passengerNumber,userName));"
        
        let createPassengerDetailsTableQuery = "CREATE TABLE IF NOT EXISTS PassengerDetails(name TEXT , age INTEGER  , gender TEXT ,coachNumber INTEGER, seatNumber INTEGER ,seatType TEXT, ticketBookingStatus TEXT,RACorWLRank INTEGER, pnrNumber INTEGER,WlNumber INTEGER,PRIMARY KEY (coachNumber,seatNumber,seatType,pnrNumber,ticketBookingStatus,RACorWLRank));"
        
        let createStoppingDetailsTableQuery = "CREATE TABLE IF NOT EXISTS StoppingDetails(stoppingNumber INTEGER,arrivalTime TEXT ,departureTime TEXT,arrivalDayOfTheTrain INTEGER, departureDayOfTheTrain INTEGER ,trainAvailabilityStatusOfWeek TEXT,  trainNumber INTEGER , stationCode TEXT,PRIMARY KEY (trainNumber,stationCode));"
        
        let createStationPassingDetailsTableQuery = "CREATE TABLE IF NOT EXISTS StationPassingDetails(stationCode TEXT ,trainNumber INTEGER,isTrainStops INTEGER,distanceFromOrigin REAL,PRIMARY KEY (trainNumber,stationCode))"

        let createAdjacentStationDetailsTableQuery = "CREATE TABLE IF NOT EXISTS AdjacentStationDetails(station1Code TEXT ,station2Code TEXT , distanceBetweenThem REAL,PRIMARY KEY(station1Code,station2Code));"
        
        let createAvailableSeatChartTableQuery = "CREATE TABLE IF NOT EXISTS AvailableSeatChart(trainNumber INTEGER ,seatNumber INTEGER, coachNumber INTEGER ,seatType TEXT, coachType TEXT,quotaType TEXT, seatId TEXT PRIMARY KEY  );"
        
        let createRACSeatChartTableQuery = "CREATE TABLE IF NOT EXISTS RACSeatChart(trainNumber INTEGER,seatNumber INTEGER, coachNumber INTEGER ,seatType TEXT, coachType TEXT, RACSeatId TEXT PRIMARY KEY );"
        
        let createWLSeatChartTableQuery = "CREATE TABLE IF NOT EXISTS WLSeatChart(trainNumber INTEGER, coachType TEXT,WLNumber INTEGER,WLId TEXT PRIMARY KEY );"
        
        let createSeatBookedStatusTableQuery = "CREATE TABLE IF NOT EXISTS seatBookedStatus(fromStation TEXT,toStation TEXT,startDate TEXT , seatId TEXT,racOrwlId INTEGER,PRIMARY KEY(fromStation,toStation,startDate,seatId,racOrwlId));"
        
        let createCoachTypeTableQuery = "CREATE TABLE IF NOT EXISTS CoachType(coachType TEXT PRIMARY KEY ,typeName TEXT,coachCode TEXT, numberOfRows INTEGER ,numberOfColumns INTEGER);"
        
        let createUsersTicketIdTableQuery = "CREATE TABLE IF NOT EXISTS UsersTickets(userId TEXT  ,pnrNumber TEXT,PRIMARY KEY(userId,pnrNumber))"
        
        let createUsersPasswordTableQuery = "CREATE TABLE IF NOT EXISTS UsersPassword(userId TEXT  ,password TEXT)"
        
        let createInitialNumberWlTableQuery = "CREATE TABLE IF NOT EXISTS WlInitialNumbers(coachType TEXT  ,initialNumber INTEGER,PRIMARY KEY(coachType,initialNumber))"
        
        let createInitialNumberRACTableQuery = "CREATE TABLE IF NOT EXISTS RACInitialNumbers(coachType TEXT  ,initialNumber INTEGER,PRIMARY KEY(coachType,initialNumber))"
        
        let createRecentJourneySearchesTableQuery = "CREATE TABLE IF NOT EXISTS RecentSearchesTable(fromStation TEXT,toStation TEXT,date TEXT,quotaType TEXT,coachType TEXT,userId TEXT,searchTime TEXT,PRIMARY KEY(fromStation,toStation,date,quotaType,coachType,userId))"
        
        
        
        

//        var statement : OpaquePointer?
        
        if sqlite3_exec(self.dbPointer, createUserTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating User Table")
        }
        else{
            print("Success in creating User Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createTrainTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating Train Table")
        }
        else{
            print("Success in creating Train Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createTicketTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating Ticket Table")
        }
        else{
            print("Success in creating Ticket Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createCancelledTicketTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating CancelledTicket Table")
        }
        else{
            print("Success in creating CancelledTicket Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createTrainTypeTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating TrainType Table")
        }
        else{
            print("Success in creating TrainType Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createStationDetailsTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating StationDetails Table")
        }
        else{
            print("Success in creating StationDetails Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createSavedPassengerTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating SavedPassenger Table")
        }
        else{
            print("Success in creating SavedPassenger Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createPassengerDetailsTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating PassengerDetails Table")
        }
        else{
            print("Success in creating PassengerDetails Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createStoppingDetailsTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating StoppingDetails Table")
        }
        else{
            print("Success in creating StoppingDetails Table")
        }
        
        if sqlite3_exec(self.dbPointer, createStationPassingDetailsTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating StationPassingDetails Table")
        }
        else{
            print("Success in creating StationPassingDetails Table")
        }
        
        if sqlite3_exec(self.dbPointer, createAdjacentStationDetailsTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating AdjacentStationDetails Table")
        }
        else{
            print("Success in creating AdjacentStationDetails Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createAvailableSeatChartTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating AvailableSeatChart Table")
        }
        else{
            print("Success in creating AvailableSeatChart Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createRACSeatChartTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating RACSeatChart Table")
        }
        else{
            print("Success in creating RACSeatChart Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createWLSeatChartTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating WLSeatChart Table")
        }
        else{
            print("Success in creating WLSeatChart Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createSeatBookedStatusTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating SeatBookedStatus Table")
        }
        else{
            print("Success in creating SeatBookedStatus Table")
        }
        
        
        if sqlite3_exec(self.dbPointer, createCoachTypeTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating CoachType Table")
        }
        else{
            print("Success in creating CoachType Table")
        }
        
        if sqlite3_exec(self.dbPointer, createUsersTicketIdTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating UsersTicketId Table")
        }
        else{
            print("Success in creating UsersTicketId Table")
        }
        
        if sqlite3_exec(self.dbPointer, createUsersPasswordTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating UsersPassword Table")
        }
        else{
            print("Success in creating UsersPassword Table")
        }

        if sqlite3_exec(self.dbPointer, createInitialNumberWlTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating InitialNumberWl Table")
        }
        else{
            print("Success in creating InitialNumberWl Table")
        }
        
        if sqlite3_exec(self.dbPointer, createInitialNumberRACTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating InitialNumberRAC Table")
        }
        else{
            print("Success in creating InitialNumberRAC Table")
        }
        
        if sqlite3_exec(self.dbPointer, createRecentJourneySearchesTableQuery, nil, nil, nil) != SQLITE_OK{
            print("Error in creating RecentJourneySearches Table")
        }
        else{
            print("Success in creating RecentJourneySearches Table")
        }
        
        
        
    }
    // MARK: - INSERTION
    
    func insertUserDetails (user:User  ,password:String){
        
        
        
        let insertDataQuery = "INSERT INTO User(userName ,name ,mail  ,mobileNumber  ) VALUES ('\(user.userName)', '\(user.name)','\(user.mail)', \(user.mobileNumber))"
        
        let insertPasswordDataQuery = "INSERT INTO UsersPassword(userId ,password) VALUES ('\(user.userName)', '\(password)')"
        
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in User Table")
            }
            
        }
        else{
            print("Insertion Failed in User Table")
        }
        
       
        
        if sqlite3_prepare_v2(self.dbPointer, insertPasswordDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in Password Table")
            }
            
        }
        else{
            print("Insertion Failed in password Table")
        }
        
    }
    
    
    func insertSavedPassengerDetails (name:String ,age:Int ,gender:Gender ,userName:String ,berthPreference:SeatType?, passengerNumber :Int) {
        
        
        
        let insertDataQuery = "INSERT OR REPLACE INTO  SavedPassenger(name,age,gender,userName,berthPreference,passengerNumber) VALUES('\(name)',\(age),'\(gender.rawValue)','\(userName)','\(berthPreference?.rawValue ?? "No Preference")',\(passengerNumber))"
        
        var insertStatement : OpaquePointer?
      
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                 print("Insertion Done in SavedPassengerDetails  Table")
            }
            
        }
        else{
            print("Insertion Failed in SavedPassengerDetails  Table")
        }
    }

    func insertTrainTypeDetails (trainTypeDetails : TrainTypeDetails){
        let insertDataQuery = "INSERT INTO TrainType(trainType,farePerKm2SCoach ,farePerKmSLCCoach ,farePerKm1ACCoach ,farePerKm2ACCoach ,farePerKm3ACoach ,farePerKmCCCoach ,farePerKmECCoach ) VALUES('\(trainTypeDetails.type.rawValue)','\(trainTypeDetails.farePerKm[.SecondSeaterClass]!)','\(trainTypeDetails.farePerKm[.SleeperClass]!)','\(trainTypeDetails.farePerKm[.AirConditioned1TierClass]!)','\(trainTypeDetails.farePerKm[.AirConditioned2TierClass]!)','\(trainTypeDetails.farePerKm[.AirConditioned3TierClass]!)','\(trainTypeDetails.farePerKm[.AirConditionedChaiCarClass]!)','\(trainTypeDetails.farePerKm[.ExecutiveChairCarClass]!)')"
        
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in TrainType Table")
            }
            
        }
        else{
            print("Insertion Failed in TrainType Table")
        }
        
    }
    
    
    func insertCoachTypeDetails (coachTypeDetails : CoachTypeDetails){
        
        let insertDataQuery = "INSERT INTO CoachType(coachType ,typeName ,coachCode , numberOfRows  ,numberOfColumns ) VALUES('\(coachTypeDetails.type.rawValue)','\(coachTypeDetails.coachName)','\(coachTypeDetails.coachCode)','\(coachTypeDetails.numberOfRowsOfSeats)','\(coachTypeDetails.numberOfColumnsOfSeats)')"
        
        var insertStatement : OpaquePointer?
      
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                 print("Insertion Done in CoachType Table")
            }
            
        }
        else{
            print("Insertion Failed in CoachType Table")
        }
    }
    
    func insertTrainDetails (trainNumber : Int, trainName : String,trainType:TrainType,numberOfDaysRunning:Int,numberOf2SCoaches : Int,numberOfSLCoaches : Int,numberOf3ACoaches : Int,numberOf2ACoaches : Int,numberOf1ACoaches : Int,numberOfCCCoaches : Int,numberOfECCoaches : Int){
        
        let insertDataQuery = "INSERT INTO Train(trainNumber ,trainName ,trainType , numberOfDaysRunning,numberOf2SCoaches   , numberOfSLCoaches  ,numberOf1ACCoaches  , numberOf2ACCoaches  ,numberOf3ACCoaches ,numberOfCCCoaches ,numberOfECCoaches) VALUES('\(trainNumber)','\(trainName)','\(trainType.rawValue)','\(numberOfDaysRunning)','\(numberOf2SCoaches)','\(numberOfSLCoaches)','\(numberOf1ACoaches)','\(numberOf2ACoaches)','\(numberOf3ACoaches)','\(numberOfCCCoaches)','\(numberOfECCoaches)')"
        
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in Train Table")
            }
            
        }
        else{
            print("Insertion Failed in Train Table")
        }
        
    }
    
    func insertStoppingDetails(stoppingNumber :Int,arrivalTime : Date,departureTime:Date,arrivalDayOfTheTrain :Int,departureDayOfTheTrain :Int,trainAvailabilityStatusOfWeek : String,trainNumber :Int,stationCode :String ){

        print(arrivalTime,departureTime)
        let outFormatter = DateFormatter()
        outFormatter.timeZone = TimeZone(abbreviation: "UTC")
        outFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        outFormatter.dateFormat = "HH:mm"
        
     
        let arrivalTimeString = outFormatter.string(from: arrivalTime)
        let departureTimeString = outFormatter.string(from: departureTime)
        
        let insertDataQuery = "INSERT INTO StoppingDetails(stoppingNumber,arrivalTime,departureTime ,arrivalDayOfTheTrain,departureDayOfTheTrain,trainAvailabilityStatusOfWeek,trainNumber, stationCode ) VALUES('\(stoppingNumber)','\(arrivalTimeString)','\(departureTimeString)','\(arrivalDayOfTheTrain)','\(departureDayOfTheTrain)','\(trainAvailabilityStatusOfWeek)','\(trainNumber)','\(stationCode)')"
        
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in StoppingDetail Table")
            }
            
        }
        else{
            print("Insertion Failed in StoppingDetail Table")
        }
        
        
    }
    
    func insertStationDetails (stationCode:String,stationName:String){
        let insertDataQuery = "INSERT INTO Station(stationCode  ,stationName ) VALUES('\(stationCode)','\(stationName)')"
        
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in Station Table")
            }
            
        }
        else{
            print("Insertion Failed in Station Table ")
        }
    }
    
    func insertStationPassingDetails (trainNumber : Int ,stationCode:String,isTrainStops:Bool,distanceFromTheOrigin:Float){
        var isTrainStopsValue = 0
        if isTrainStops {
            isTrainStopsValue = 1
        }
        let insertDataQuery = "INSERT INTO StationPassingDetails(stationCode,trainNumber,isTrainStops,distanceFromOrigin) VALUES('\(stationCode)','\(trainNumber)','\(isTrainStopsValue)','\(distanceFromTheOrigin)')"
        
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in StationPassingDetails")
            }
            
        }
        else{
            print("Insertion Failed in StationPassingDetails ")
        }
    }
    func insertAdjacentStoppingDetails (station1Code:String, station2Code:String , distanceBetweenThem:Float){
        let insertDataQuery = "INSERT INTO AdjacentStationDetails(station1Code ,station2Code  , distanceBetweenThem  ) VALUES('\(station1Code)','\(station2Code)','\(distanceBetweenThem)')"
        
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in AdjacentStation Table")
            }
            
        }
        else{
            print("Insertion Failed in AdjacentStation Table ")
        }
    }
    
    
    func insertRecentSearchesDetails (fromStationCode : String,toStationCode: String,date:Date,coachType : CoachType,quotaType : QuotaType,userID : String,searchTime:Date){
        let dateString = date.toString(format: "yyyy-MM-dd")
        let searchTimeString = searchTime.toString(format: "yyyy-MM-dd'T'HH:mm:ss")
        
        let insertDataQuery = "INSERT OR REPLACE INTO RecentSearchesTable(fromStation ,toStation,date ,quotaType ,coachType,userId,searchTime) VALUES('\(fromStationCode)','\(toStationCode)','\(dateString)','\(quotaType.rawValue)','\(coachType.rawValue)','\(userID)','\(searchTimeString)')"
        
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in RecentSearchesTable Table")
            }
            
        }
        else{
            print("Insertion Failed in RecentSearchesTable Table ")
        }
        
    }
//    func insertseatChartCreatedDateTable(date:Date,chartCreatedStatus:Int) {
//
//        let timeFormatter = DateFormatter()
//        timeFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        timeFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
//        timeFormatter.dateFormat = "yyyy-MM-dd"
//        let insertDataQuery = "INSERT INTO seatChartCraetedDates(date ,chartCreatedStatus) VALUES('\(timeFormatter.string(from: date))','\(chartCreatedStatus)')"
//
//        //"CREATE TABLE IF NOT EXISTS seatChartCraetedDates(date TEXT PRIMARY KEY,chartCreatedStatus INTEGER);"
//        var insertStatement : OpaquePointer?
//
//        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
//            if sqlite3_step(insertStatement) == SQLITE_DONE{
//                print("Insertion Done in seatChartCreatedDate Table")
//            }
//
//        }
//        else{
//            print("Insertion Failed in seatChartCreatedDate Table ")
//        }
//    }
    
    func insertAvailableSeatsChartTable (trainNumber :Int,quotaType: QuotaType,coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType){
        let seatId = "avl\(trainNumber)\(quotaType.rawValue)\(coachtype.rawValue)\(coachNumber)\(seatNumber)\(seatType.rawValue)"
        //print(seatNumber,quotaType.rawValue)
        let insertDataQuery = "INSERT INTO AvailableSeatChart(trainNumber ,seatNumber , coachNumber  ,seatType , coachType ,quotaType, seatId) VALUES('\(trainNumber)','\(seatNumber)','\(coachNumber)','\(seatType.rawValue)','\(coachtype.rawValue)','\(quotaType.rawValue)','\(seatId)')"
        
        //"CREATE TABLE IF NOT EXISTS seatChartCraetedDates(date TEXT PRIMARY KEY,chartCreatedStatus INTEGER);"
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in AvailableSeatChart Table")
            }
            
        }
        else{
            print("Insertion Failed in AvailableSeatChart Table ")
        }
        
    }
    
    func insertRACSeatsChartTable (trainNumber :Int,coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType){
        let seatId = "rac\(trainNumber)\(coachtype.rawValue)\(coachNumber)\(seatNumber)\(seatType.rawValue)"
        //print(seatNumber)
        let insertDataQuery = "INSERT INTO RACSeatChart(trainNumber,seatNumber,coachNumber,seatType,coachType,RACSeatId) VALUES('\(trainNumber)','\(seatNumber)','\(coachNumber)','\(seatType.rawValue)','\(coachtype.rawValue)','\(seatId)')"
        
        //"CREATE TABLE IF NOT EXISTS seatChartCraetedDates(date TEXT PRIMARY KEY,chartCreatedStatus INTEGER);"
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in RACSeatChart Table")
            }
            
        }
        else{
            print("Insertion Failed in RACSeatChart Table ")
        }
        
    }
    func insertWLSeatChartTable (trainNumber :Int,coachtype :CoachType,wlNumber:Int){
    
        let seatId = "wl\(trainNumber)\(coachtype.rawValue)\(wlNumber)"
        
        let insertDataQuery = "INSERT INTO WLSeatChart(trainNumber,coachType,WLNumber,WLId) VALUES('\(trainNumber)','\(coachtype.rawValue)','\(wlNumber)','\(seatId)')"
        
        //"CREATE TABLE IF NOT EXISTS seatChartCraetedDates(date TEXT PRIMARY KEY,chartCreatedStatus INTEGER);"
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in WLSeatChart Table")
            }
            
        }
        else{
            print("Insertion Failed in WLSeatChart Table ")
        }
        
    }
    
    func insertAvailableSeatBookedWithStationsTable (fromStation :String,toStation:String,startDate:Date,seatId:String){
        
        let startDateString = startDate.toString(format: "yyyy-MM-dd")
        
       
        let insertDataQuery = "INSERT INTO seatBookedStatus(fromStation,toStation,startDate,seatId,racOrwlId) VALUES('\(fromStation)','\(toStation)','\(startDateString)','\(seatId)',\(0))"
        
        //"CREATE TABLE IF NOT EXISTS seatChartCraetedDates(date TEXT PRIMARY KEY,chartCreatedStatus INTEGER);"
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in seatBookedStatus Table")
            }
            
        }
        else{
            print("Insertion Failed in seatBookedStatus Table ")
        }
        
        
    }
    
    func insertRACSeatBookedWithStationTable(fromStation :String,toStation:String,startDate:Date,racOrwlId : Int,seatId:String){
        let startDateString = startDate.toString(format: "yyyy-MM-dd")
        
        
        let insertDataQuery = "INSERT INTO seatBookedStatus(fromStation,toStation,startDate,seatId,racOrwlId) VALUES('\(fromStation)','\(toStation)','\(startDateString)','\(seatId)','\(racOrwlId)')"
        
        //"CREATE TABLE IF NOT EXISTS seatChartCraetedDates(date TEXT PRIMARY KEY,chartCreatedStatus INTEGER);"
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in RACSeatBookedWithStations Table")
            }
            
        }
        else{
            print("Insertion Failed in RACSeatBookedWithStations Table ")
        }
        
    }
    
    func insertWLSeatBookedWithStationTable (fromStation :String,toStation:String,startDate:Date,racOrwlId : Int,seatId:String){
        let startDateString = startDate.toString(format: "yyyy-MM-dd")
        
      

        var insertStatement : OpaquePointer?
        
        let insertDataQuery = "INSERT INTO seatBookedStatus(fromStation,toStation,startDate,seatId,racOrwlId) VALUES('\(fromStation)','\(toStation)','\(startDateString)','\(seatId)','\(racOrwlId)')"
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in WLSeatBookedWithStations Table")
            }
            
        }
        else{
            print("Insertion Failed in WLSeatBookedWithStations Table ")
        }
        
        
    }
    
    func insertTicketDetails(pnrNumber:UInt64, trainNumber:Int, fromStationCode:String, toStationCode:String, quotoType:QuotaType, coachtype:CoachType, startTime:Date, endTime:Date, ticketStatus:TicketBookingStatus,ticketFare:Float,isTravelInsuranceOpt :Bool,startDate:Date){
        
        let startTimeString = startTime.toString(format: "yyyy-MM-dd'T'HH:mm")
        let endTimeString = endTime.toString(format: "yyyy-MM-dd'T'HH:mm")
        let startDateString = startDate.toString(format: "yyyy-MM-dd")
        
        let travelInsurance = isTravelInsuranceOpt ? "Yes" : "No"
        
        var insertStatement : OpaquePointer?
        
        let insertDataQuery = "INSERT OR REPLACE INTO Ticket (pnrNumber, trainNumber, fromStation, toStation,quotaType,coachType, startTime,endTime,trainStartDate,ticketStatus,ticketFare,isTravelInsuranceOpt)  VALUES('\(pnrNumber)' ,'\(trainNumber)'  ,'\(fromStationCode)', '\(toStationCode)','\(quotoType.rawValue)' , '\(coachtype.rawValue)', '\(startTimeString)', '\(endTimeString)','\(startDateString)', '\(ticketStatus.rawValue)', '\(ticketFare)','\(travelInsurance)')"
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in Ticket Table")
            }
            
        }
        else{
            print("Insertion Failed in Ticket Table ")
        }
        
    }
    
    func insertPassengerDetails(passengerName:String, passengerAge:Int, passengerGender:Gender, coachNumber:Int?, seatnumber:Int?, seatType:SeatType?,ticketBookingStatus:TicketBookingStatus,pnrNumber:UInt64,rACorWLRank:Int?,wlNumber : Int?){
        
        var rACorWLRankFinal:Int = 0
        var coachNumberFinal:Int = 0
        var seatTypeString = ""
        var seatNumberFinal = 0
        var wlNumberFinal = 0
        if ticketBookingStatus == .Confirmed{
            rACorWLRankFinal = 0
            coachNumberFinal = coachNumber!
            seatTypeString = seatType!.rawValue
            seatNumberFinal = seatnumber!
        }
        if ticketBookingStatus == .WaitingList{
            rACorWLRankFinal = rACorWLRank!
            wlNumberFinal = wlNumber!

        }
        if ticketBookingStatus == .ReservationAgainstCancellation{
            seatTypeString = seatType!.rawValue
            coachNumberFinal = coachNumber!
            rACorWLRankFinal = rACorWLRank!
            seatNumberFinal = seatnumber!
        }
        
        
        var insertStatement : OpaquePointer?
        
        
        let insertDataQuery = "INSERT OR REPLACE INTO PassengerDetails(name, age, gender  ,coachNumber , seatNumber  ,seatType , ticketBookingStatus ,RACorWLRank , pnrNumber ,wlNumber ) VALUES('\(passengerName)','\(passengerAge)','\(passengerGender.rawValue)','\(coachNumberFinal)','\(seatNumberFinal)','\(seatTypeString)','\(ticketBookingStatus.rawValue)','\(rACorWLRankFinal)','\(pnrNumber)','\(wlNumberFinal)')"
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in PassengerDetail Table")
            }
            
        }
        else{
            print("Insertion Failed in PassengerDetail Table ")
        }
    }
    
    func insertToUsersTicketTable (userId:String,pnrNumber:UInt64){
        
        var insertStatement : OpaquePointer?
        
        let insertDataQuery = "INSERT INTO UsersTickets(userId,pnrNumber) VALUES('\(userId)','\(pnrNumber)')"
        
        if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Insertion Done in UsersTickets Table")
            }
            
        }
        else{
            print("Insertion Failed in UsersTickets Table ")
        }
    }
    
    func insertInitialNumberOfRACSeats (initialNumberOfRAC : [CoachType:Int] ) {
        var insertStatement : OpaquePointer?
        
        for initialNumberOfRACCode in initialNumberOfRAC.keys{
            let insertDataQuery = "INSERT INTO RACInitialNumbers(coachType,initialNumber) VALUES('\(initialNumberOfRACCode.rawValue)','\(initialNumberOfRAC[initialNumberOfRACCode]!)')"
            
            if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
                if sqlite3_step(insertStatement) == SQLITE_DONE{
                    print("Insertion Done in RACInitialNumbers Table")
                }
                
            }
            else{
                print("Insertion Failed in RACInitialNumbers Table ")
            }
        }
        
    }
    
    func insertInitialNumberOfWLSeats (initialNumberOfWL : [CoachType:Int] ) {
        var insertStatement : OpaquePointer?
        
        for initialNumberOfWlCode in initialNumberOfWL.keys{
            let insertDataQuery = "INSERT INTO WlInitialNumbers(coachType,initialNumber) VALUES('\(initialNumberOfWlCode.rawValue)','\(initialNumberOfWL[initialNumberOfWlCode]!)')"
            
            if sqlite3_prepare_v2(self.dbPointer, insertDataQuery, -1, &insertStatement, nil) == SQLITE_OK{
                if sqlite3_step(insertStatement) == SQLITE_DONE{
                    print("Insertion Done in WlInitialNumbers Table")
                }
                
            }
            else{
                print("Insertion Failed in WlInitialNumbers Table ")
            }
        }
        
    }
    
    // MARK: - RETRIEVE
    
    func retrieveUserData (userName:String) -> User? {
        let readQuery = "SELECT * FROM User WHERE userName = '\(userName)';"
        var readStatement : OpaquePointer?
        let user : User? = nil
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveRACSeatChart not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            //print("inside While")
            
            let userName = userName
            let name =  String(cString: sqlite3_column_text(readStatement, 1))
            let mail = String(cString: sqlite3_column_text(readStatement, 2))
            let mobileNumber = UInt64(sqlite3_column_int64(readStatement, 3))
           
            
            
            return User(name: name, userName: userName, mail: mail, mobileNumber: mobileNumber)
            
            
                
           
            
        }
        
        return user
    }
    
    func getUserName (userMail : String) -> String {
        
        let readQuery = "SELECT userName FROM User WHERE mail = '\(userMail)';"
        var readStatement : OpaquePointer?
       
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveRACSeatChart not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            //print("inside While")
            
            let userName = String(cString: sqlite3_column_text(readStatement, 0))
            
            return userName
            
        }
        
        return ""
    }
    
    
    func retrieveUserPassword (userName : String) -> String {
        let readQuery = "SELECT password FROM UsersPassword WHERE userId = '\(userName)';"
        var readStatement : OpaquePointer?
       
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveRACSeatChart not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            //print("inside While")
            
            let password = String(cString: sqlite3_column_text(readStatement, 0))
            
            return password
            
        }
        
        return ""
    }
    func retrieveTrainData(travelDayOfWeek : Int , fromStationNameCode : String , toStationNameCode : String) -> [Int]{
        
        let readQuery = "SELECT trainNumber FROM Train ;"
        var readStatement : OpaquePointer?
        var trainNumbers :[Int] = []
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveTrainData not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
            
            let trainNumber = sqlite3_column_int(readStatement, 0)
            trainNumbers.append(Int(trainNumber))
        }
        var filteredTrains : [Int] = []
        //let joinQuery = "SELECT stationCode, trainAvailabilityStatusOfWeek, DEPT FROM COMPANY INNER JOIN DEPARTMENT ON COMPANY.ID = DEPARTMENT.EMP_ID;"
        for trainNumber in trainNumbers {
            
            let retrieveFromStationQuery = "SELECT  trainNumber FROM StoppingDetails WHERE trainNumber = \(trainNumber) AND stationCode = '\(fromStationNameCode)'"
            
            if sqlite3_prepare_v2(self.dbPointer, retrieveFromStationQuery, -1, &readStatement, nil) != SQLITE_OK{
                print("retrieveFromStationQuery not Working")
            }
            while sqlite3_step(readStatement) == SQLITE_ROW {
                filteredTrains.append(Int(trainNumber))
            }
            

        }
        var avaialableTrains :[Int] = []
        for filteredTrain in filteredTrains {
            

            let retrieveToStationQuery = "SELECT  trainAvailabilityStatusOfWeek FROM StoppingDetails WHERE trainNumber = \(filteredTrain) AND stationCode = '\(toStationNameCode)'"

            if sqlite3_prepare_v2(self.dbPointer, retrieveToStationQuery, -1, &readStatement, nil) != SQLITE_OK{
                print("retrieveToStationQuery not Working")
            }


            while sqlite3_step(readStatement) == SQLITE_ROW {



                let trainAvailabilityStatusOfWeek = String(cString: sqlite3_column_text(readStatement, 0))

                if trainAvailabilityStatusOfWeek[travelDayOfWeek - 1] == "1"{
                    avaialableTrains.append(filteredTrain)
                }
            }
        }
//        filteredTrains =  avaialableTrains
//        avaialableTrains.removeAll()
//        
//        for filteredTrain in filteredTrains {
//            print(" \(filteredTrain) filteredTrain \(toStationNameCode)")
//            
//            let retrieveToStationQuery = "SELECT  stoppingNumber,stationCode FROM StoppingDetails WHERE trainNumber = \(filteredTrain) AND (stationCode = '\(toStationNameCode)' OR stationCode = '\(fromStationNameCode)')"
//            
//            if sqlite3_prepare_v2(self.dbPointer, retrieveToStationQuery, -1, &readStatement, nil) != SQLITE_OK{
//                print("retrieveToStationQuery not Working")
//            }
//            
//            var fromStationNumber = 100
//            var toStationNumber = 0
//            while sqlite3_step(readStatement) == SQLITE_ROW {
//                
//                let stationName = String(cString: sqlite3_column_text(readStatement, 1))
//                
//                if stationName == fromStationNameCode{
//                    fromStationNumber = Int(sqlite3_column_int(readStatement, 0))
//                }
//                else if stationName == toStationNameCode{
//                    toStationNumber = Int(sqlite3_column_int(readStatement, 0))
//                }
//               
//            }
//            
//            if fromStationNumber < toStationNumber{
//                avaialableTrains.append(filteredTrain)
//            }
//        }
        
        
        return avaialableTrains
        
    }
    
    func retrievePNRNumbers () -> [UInt64]{
        let readQuery = "SELECT pnrNumber FROM Ticket ;"
        var readStatement : OpaquePointer?
        var pnrNumbers :[UInt64] = []
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrivePnrNumber not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
//            print(sqlite3_column_int64(readStatement, 0))
            let pnrNumber = UInt64(sqlite3_column_int64(readStatement, 0))
            pnrNumbers.append(pnrNumber)
        }
        
        return pnrNumbers
    }
    func retrieveAvailableSeatChart (trainNumber:Int)->[(quotaType: QuotaType,coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType,seatId:String)]{
        
        let readQuery = "SELECT * FROM AvailableSeatChart WHERE trainNumber = \(trainNumber);"
        var readStatement : OpaquePointer?
        var availableSeatChart :[(quotaType: QuotaType,coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType,seatId:String)] = []
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveAvailableSeatChart not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
//            print(trainNumber)
            
            let seatNumberValue = Int(sqlite3_column_int(readStatement, 1))
            let coachNumberValue =  Int(sqlite3_column_int(readStatement, 2))
            let seatTypeValue = String(cString: sqlite3_column_text(readStatement, 3))
            let coachTypeValue = String(cString: sqlite3_column_text(readStatement, 4))
            let quotaTypeValue = String(cString: sqlite3_column_text(readStatement, 5))
            let seatIdValue = String(cString: sqlite3_column_text(readStatement, 6))
            
            
                
            availableSeatChart.append((quotaType:QuotaType(rawValue: quotaTypeValue)!, coachtype: CoachType(rawValue: coachTypeValue)!, coachNumber: coachNumberValue, seatNumber: seatNumberValue, seatType: SeatType(rawValue: seatTypeValue)!,seatId:seatIdValue))
            }
        
        return availableSeatChart
        
        
    }
    
    func retrieveRACSeatChart (trainNumber:Int)->[(coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType,seatId:String)]{
        
        let readQuery = "SELECT * FROM RACSeatChart WHERE trainNumber = \(trainNumber);"
        var readStatement : OpaquePointer?
        var RACSeatChart :[(coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType,seatId:String)] = []
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveRACSeatChart not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            //print("inside While")
            
            let seatNumberValue = Int(sqlite3_column_int(readStatement, 1))
            let coachNumberValue =  Int(sqlite3_column_int(readStatement, 2))
            let seatTypeValue = SeatType(rawValue:String(cString: sqlite3_column_text(readStatement, 3)))!
            let coachTypeValue = CoachType(rawValue:String(cString: sqlite3_column_text(readStatement, 4)))!
            let seatIdValue = String(cString: sqlite3_column_text(readStatement, 5))
            
            
                
            RACSeatChart.append((coachtype :coachTypeValue,coachNumber :coachNumberValue,seatNumber :seatNumberValue,seatType :seatTypeValue,seatId:seatIdValue))
            
            }
        
        return RACSeatChart
        
        
    }
    
    func retrieveWLSeatChart (trainNumber:Int)->[(coachtype :CoachType,wlNumber:Int,seatId:String)]{
        
        let readQuery = "SELECT * FROM WLSeatChart WHERE trainNumber = \(trainNumber);"
        var readStatement : OpaquePointer?
        var WLSeatChart :[(coachtype :CoachType,wlNumber:Int,seatId:String)] = []
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveWLSeatChart not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            //print("inside While")
            
            let coachTypeValue = CoachType(rawValue:String(cString: sqlite3_column_text(readStatement, 1)))!
            let wlNumberValue =  Int(sqlite3_column_int(readStatement, 2))
            let seatIdValue = String(cString: sqlite3_column_text(readStatement, 3))
        
            WLSeatChart.append((coachtype:coachTypeValue,wlNumber:wlNumberValue,seatId:seatIdValue))
            
        }
        
        return WLSeatChart
        
        
    }
    
    func retrieveSeatBookedWithStations (seatId:String,startDate:Date)->[(fromStation :String,toStation:String)]{
        let startDateString = startDate.toString(format: "yyyy-MM-dd")
         
//        print("\(seatId)\(startDateString)")
        let readQuery = "SELECT * FROM seatBookedStatus WHERE seatId = '\(seatId)' AND startDate = '\(startDateString)';"
        var readStatement : OpaquePointer?
        var SeatBookedWithStations :[(fromStation :String,toStation:String)] = []
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("SeatBookedWithStations  not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
            let fromStation = String(cString: sqlite3_column_text(readStatement, 0))
            let toStation = String(cString: sqlite3_column_text(readStatement, 1))
        
            SeatBookedWithStations.append((fromStation :fromStation,toStation:toStation))
            }
        
        return SeatBookedWithStations
    }
    
    func retrieveAvailableSeatChartWithQuotaType (trainNumber:Int,quotaType:QuotaType)->[(coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType,seatId:String)]{
        
        let readQuery = "SELECT * FROM AvailableSeatChart WHERE trainNumber = \(trainNumber) AND quotaType = '\((quotaType.rawValue))';"
        var readStatement : OpaquePointer?
        var availableSeatChart :[(coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType,seatId:String)] = []
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveAvailableSeatChart not Working")
        }
        
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
            let seatNumberValue = Int(sqlite3_column_int(readStatement, 1))
            let coachNumberValue =  Int(sqlite3_column_int(readStatement, 2))
            let seatTypeValue = String(cString: sqlite3_column_text(readStatement, 3))
            let coachTypeValue = String(cString: sqlite3_column_text(readStatement, 4))
            let seatIdValue = String(cString: sqlite3_column_text(readStatement, 6))
            
            
            availableSeatChart.append((coachtype: CoachType(rawValue: coachTypeValue)!, coachNumber: coachNumberValue, seatNumber: seatNumberValue, seatType: SeatType(rawValue: seatTypeValue)!,seatId:seatIdValue))
            }
        
        return availableSeatChart
        
        
    }

    func retrieveTrainDetails()->[Train]{
        
        let readQuery = "SELECT * FROM Train ;"
        var readStatement : OpaquePointer?
        var trains :[Train] = []
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveTrainDetails not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            //print("inside While")
            let trainNumber = Int(sqlite3_column_int(readStatement, 0))
            let trainName = String(cString: sqlite3_column_text(readStatement, 1))
            let trainType = String(cString: sqlite3_column_text(readStatement, 2))
            let numberOfDaysRunning =  Int(sqlite3_column_int(readStatement, 3))
            let numberOf2SCoaches = Int(sqlite3_column_int(readStatement, 4))
            let numberOfSLCoaches = Int(sqlite3_column_int(readStatement, 5))
            let numberOf1ACoaches = Int(sqlite3_column_int(readStatement, 6))
            let numberOf2ACoaches = Int(sqlite3_column_int(readStatement, 7))
            let numberOf3ACoaches = Int(sqlite3_column_int(readStatement, 8))
            let numberOfCCCoaches = Int(sqlite3_column_int(readStatement, 9))
            let numberOfECCoaches = Int(sqlite3_column_int(readStatement, 10))
            let stoppingDetails = retrieveStationDetails(trainNumber: Int(trainNumber))
            let stationPassingDetails = retrieveStaionPassingDetails(trainNumber: trainNumber)
            
                
            trains.append(Train(trainNumber: trainNumber,
                                trainName: trainName,
                                trainType: TrainType(rawValue: trainType)! ,
                                numberOfDaysRunning: numberOfDaysRunning,
                                stoppingList: stoppingDetails,
                                stationPassByList: stationPassingDetails,
                                numberOf2SCoaches: numberOf2SCoaches,
                                numberOfSLCoaches: numberOfSLCoaches,
                                numberOf3ACoaches: numberOf3ACoaches,
                                numberOf2ACoaches: numberOf2ACoaches,
                                numberOf1ACoaches: numberOf1ACoaches,
                                numberOfCCCoaches: numberOfCCCoaches,
                                numberOfECCoaches: numberOfECCoaches))
            }
        
        return trains
        
        
    }
    
    func retrieveSeparateTrainDetails(trainNumber:Int)->Train?{
        
        let readQuery = "SELECT * FROM Train WHERE trainNumber = \(trainNumber);"
        var readStatement : OpaquePointer?
        
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveTrainDetails not Working")
            
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            //print("inside While")
            let trainNumber = Int(sqlite3_column_int(readStatement, 0))
            let trainName = String(cString: sqlite3_column_text(readStatement, 1))
            let trainType = String(cString: sqlite3_column_text(readStatement, 2))
            let numberOfDaysRunning =  Int(sqlite3_column_int(readStatement, 3))
            let numberOf2SCoaches = Int(sqlite3_column_int(readStatement, 4))
            let numberOfSLCoaches = Int(sqlite3_column_int(readStatement, 5))
            let numberOf1ACoaches = Int(sqlite3_column_int(readStatement, 6))
            let numberOf2ACoaches = Int(sqlite3_column_int(readStatement, 7))
            let numberOf3ACoaches = Int(sqlite3_column_int(readStatement, 8))
            let numberOfCCCoaches = Int(sqlite3_column_int(readStatement, 9))
            let numberOfECCoaches = Int(sqlite3_column_int(readStatement, 10))
            let stoppingDetails = retrieveStationDetails(trainNumber: Int(trainNumber))
            let stationPassingDetails = retrieveStaionPassingDetails(trainNumber: trainNumber)
            
                
            return Train(trainNumber: trainNumber,
                                trainName: trainName,
                                trainType: TrainType(rawValue: trainType)! ,
                                numberOfDaysRunning: numberOfDaysRunning,
                                stoppingList: stoppingDetails,
                                stationPassByList: stationPassingDetails,
                                numberOf2SCoaches: numberOf2SCoaches,
                                numberOfSLCoaches: numberOfSLCoaches,
                                numberOf3ACoaches: numberOf3ACoaches,
                                numberOf2ACoaches: numberOf2ACoaches,
                                numberOf1ACoaches: numberOf1ACoaches,
                                numberOfCCCoaches: numberOfCCCoaches,
                                numberOfECCoaches: numberOfECCoaches)
            }
       return nil
        
        
    }
    
    
    private func retrieveStationDetails(trainNumber :Int)->[StoppingDetails]{
        
        let readQuery = "SELECT * FROM StoppingDetails WHERE trainNumber = \(trainNumber);"
        var stoppingDetails = [StoppingDetails]()
        var readStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveStationDetails not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
                let stoppingNumber = sqlite3_column_int(readStatement, 0)
                let arrivalTimeString = String(cString: sqlite3_column_text(readStatement, 1))
                let departureTimeString = String(cString: sqlite3_column_text(readStatement, 2))
                let arrivalDayOfTheTrain =  sqlite3_column_int(readStatement, 3)
                let departureDayOfTheTrain =  sqlite3_column_int(readStatement, 4)
                let trainAvailabilityStatusOfWeek =  String(cString: sqlite3_column_text(readStatement, 5))
                let stationCode =  String(cString: sqlite3_column_text(readStatement, 7))
    
            let timeFormat = DateFormatter()
            timeFormat.timeZone = TimeZone(abbreviation: "UTC")
            timeFormat.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
            timeFormat.dateFormat = "HH:mm"
                
            stoppingDetails.append(StoppingDetails(stoppingNumber: Int(stoppingNumber),
                                                   arrivalTime: timeFormat.date(from: arrivalTimeString)!,
                                                   departureTime: timeFormat.date(from: departureTimeString)!,
                                                   arrivalDayOfTheTrain: Int(arrivalDayOfTheTrain),
                                                   departureDayOfTheTrain: Int(departureDayOfTheTrain),
                                                   trainAvailabilityStatusOfWeek: trainAvailabilityStatusOfWeek,
                                                   stationCode: stationCode))
        }
        return stoppingDetails
    }
    
    func retrieveStaionPassingDetails (trainNumber :Int) -> [StationPassingDetails]{
        let readQuery = "SELECT * FROM StationPassingDetails WHERE trainNumber = \(trainNumber);"
        var stationPassingDetails = [StationPassingDetails]()
        var readStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveStaionPassingDetails not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
                
            let isTrainStops = sqlite3_column_int(readStatement, 2) == 1 ? true : false
            let distanceBetweenThem = Float(sqlite3_column_double(readStatement, 3))
            let stationCode =  String(cString: sqlite3_column_text(readStatement, 0))
    
            
                
            stationPassingDetails.append(StationPassingDetails(stationCode: stationCode, isTrainStops: isTrainStops, distanceFromOrigin: distanceBetweenThem))
        }
        return stationPassingDetails
    }
    
    func retrieveSeatChartCreatedDateData(date : Date)->SeatChartCreatedStatus?{
        
        
        let readQuery = "SELECT chartCreatedStatus FROM seatChartCraetedDates WHERE date = '\(date.toString(format: "yyyy-MM-dd"))';"
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveSeatChartCraetedDates not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            return SeatChartCreatedStatus(rawValue: Int(sqlite3_column_int(readStatement, 0)))
        }
        
        return nil
    }
    
    func retrieveStationNames () -> [String:String]{
        let readQuery = "SELECT * FROM Station;"
        var stationNames :[String:String] = [:]
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveStationNames not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            let stationCode = String(cString: sqlite3_column_text(readStatement, 0))
            let stationName = String(cString: sqlite3_column_text(readStatement, 1))
            
            stationNames[stationCode] = stationName
        }
        return stationNames
    }
    
    func retrieveTrainTypeDetails ()-> [TrainTypeDetails]{
        let readQuery = "SELECT * FROM TrainType;"
        var trainTypes :[TrainTypeDetails] = []
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveTrainType not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            let typeName = String(cString: sqlite3_column_text(readStatement, 0))
            let farePerKm2S = Float(sqlite3_column_double(readStatement, 1))
            let farePerKmSL = Float(sqlite3_column_double(readStatement, 2))
            let farePerKm1A = Float(sqlite3_column_double(readStatement, 3))
            let farePerKm2A = Float(sqlite3_column_double(readStatement, 4))
            let farePerKm3A = Float(sqlite3_column_double(readStatement, 5))
            let farePerKmCC = Float(sqlite3_column_double(readStatement, 6))
            let farePerKmEC = Float(sqlite3_column_double(readStatement, 7))
            //print("\(typeName)")
            trainTypes.append(TrainTypeDetails(type: TrainType(rawValue: typeName)!, farePerKm2S: farePerKm2S, farePerKmSL: farePerKmSL, farePerKm3A: farePerKm3A, farePerKm2A: farePerKm2A, farePerKm1A: farePerKm1A, farePerKmEC: farePerKmEC, farePerKmCC: farePerKmCC))
        }
        return trainTypes

    }
    func retrieveCoachTypeDetails ()-> [CoachTypeDetails]{
        let readQuery = "SELECT * FROM CoachType;"
        var coachTypes :[CoachTypeDetails] = []
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveCoachType not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            let typeName = String(cString: sqlite3_column_text(readStatement, 0))
            let coachName = String(cString: sqlite3_column_text(readStatement, 1))
            let coachCode = String(cString: sqlite3_column_text(readStatement, 2))
            let numberOfRowsOfSeats =  Int(sqlite3_column_int(readStatement, 3))
            let numberOfColumnsOfSeats =  Int(sqlite3_column_int(readStatement, 4))

            //print("\(typeName)")
            coachTypes.append(CoachTypeDetails(type: CoachType(rawValue: typeName)!, coachCode: coachCode, coachName: coachName, numberOfRowsOfSeats: numberOfRowsOfSeats, numberOfColumnsOfSeats: numberOfColumnsOfSeats))
        }
        return coachTypes

    }
    
    func retrieveInitialNumberOfWlSeats() -> [CoachType:Int] {
        let readQuery = "SELECT * FROM WlInitialNumbers;"
        var initialNumberOfWlSeats :[CoachType:Int] = [:]
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveInitialNumberOfWlSeats not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            let coachType = String(cString: sqlite3_column_text(readStatement, 0))
            let initialNumber =  Int(sqlite3_column_int(readStatement, 1))

            //print("\(typeName)")
            
            initialNumberOfWlSeats[CoachType(rawValue: coachType)!] = initialNumber
            
        }
        return initialNumberOfWlSeats

    }
    
//    func retrieveSeatDetails (seatId:String) ->[String]{
//        
//    }
    
    func retrieveInitialNumberOfRacSeats() -> [CoachType:Int] {
        let readQuery = "SELECT * FROM RACInitialNumbers;"
        var initialNumberOfRACSeats :[CoachType:Int] = [:]
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveInitialNumberOfRacSeats not Working")
        }
        
        while sqlite3_step(readStatement) == SQLITE_ROW {
            let coachType = String(cString: sqlite3_column_text(readStatement, 0))
            let initialNumber =  Int(sqlite3_column_int(readStatement, 1))

            
            initialNumberOfRACSeats[CoachType(rawValue: coachType)!] = initialNumber
            
        }
        return initialNumberOfRACSeats

    }
    
    
    func retrieveTicketDetails(pnrNumber:UInt64)->Ticket?{
        
        let readQuery = "SELECT * FROM Ticket WHERE pnrNumber = \(pnrNumber);"
        
        print("pnrNumber \(pnrNumber)")
        
        
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveTicket not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            let trainNumber = Int(sqlite3_column_int(readStatement, 1))
            let fromStation = String(cString: sqlite3_column_text(readStatement, 2))
            let toStation = String(cString: sqlite3_column_text(readStatement, 3))
            
            
            let quotaType =  QuotaType(rawValue:String(cString: sqlite3_column_text(readStatement, 4)))!
            let coachType =  CoachType(rawValue:String(cString: sqlite3_column_text(readStatement, 5)))!
            let startTimeString = String(cString: sqlite3_column_text(readStatement, 6))
            let endTimeString = String(cString: sqlite3_column_text(readStatement, 7))
            let startDateString = String(cString: sqlite3_column_text(readStatement, 8))
            let trainFare = Float(sqlite3_column_double(readStatement, 10))
            let istravelInsuranceOpt = ( String(cString: sqlite3_column_text(readStatement, 11)) == "Yes" ? true : false)
            
            
            let dateFormatter = DateFormatter()
            let startTime = dateFormatter.toDate(format: "yyyy-MM-dd'T'HH:mm", string: startTimeString)
            let endTime = dateFormatter.toDate(format: "yyyy-MM-dd'T'HH:mm", string: endTimeString)
            let startDate = dateFormatter.toDate(format: "yyyy-MM-dd", string: startDateString)
            
            
            let passengerDetails = retrievePassengerDetailsList(pnrNumber: pnrNumber)
            
            return Ticket(pnrNumber: pnrNumber, trainNumber: trainNumber, fromStation: fromStation, toStation: toStation, quotaType: quotaType, coachType: coachType, startTime: startTime, endTime: endTime, passengerDetails: passengerDetails,ticketFare: trainFare,isTravelInsuranceOpt: istravelInsuranceOpt,startDate: startDate)
        }
        return nil
    }
    
    func retrieveUserPnrs (userId:String) -> [UInt64]{
        
        let readQuery = "SELECT pnrnumber FROM UsersTickets WHERE userId = '\(userId)';"
        var pnrNumbers :[UInt64] = []
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveUserPnrs not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
            
            
            let pnrNumber = UInt64(sqlite3_column_int64(readStatement, 0))
            
            pnrNumbers.append(pnrNumber)
            
        }
        return pnrNumbers
        
        
    }
    
    func retrievePassengerDetailsList(pnrNumber:UInt64)->[PassengerDetails]{
        
        
        let readQuery = "SELECT * FROM PassengerDetails WHERE pnrNumber = \(pnrNumber);"
        var passengerDetails :[PassengerDetails] = []
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrivePassengerDetailsList not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
            let name = String(cString: sqlite3_column_text(readStatement, 0))
            let age = Int(sqlite3_column_int(readStatement, 1))
            
            
            let gender = Gender(rawValue:String(cString: sqlite3_column_text(readStatement, 2)))!
            let coachNumber =  Int(sqlite3_column_int(readStatement, 3))
            let seatNumber =  Int(sqlite3_column_int(readStatement, 4))
            let seatType = SeatType(rawValue:String(cString: sqlite3_column_text(readStatement, 5)))
            print(String(cString: sqlite3_column_text(readStatement, 6)))
            let ticketBookingStatus = TicketBookingStatus(rawValue:String(cString: sqlite3_column_text(readStatement, 6)))!
            let racOrWlRank =  Int(sqlite3_column_int(readStatement, 7))
            
            let wlNumber =  Int(sqlite3_column_int(readStatement, 9))
            
            
            
            passengerDetails.append(PassengerDetails(name: name, age: age, gender: gender, bookingDetails: BookingDetails(coachNumber: coachNumber == 0 ? nil : coachNumber, seatType: seatType, seatNumber: seatNumber == 0 ? nil : seatNumber, ticketBookingStatus: ticketBookingStatus, RacOrWlNumber: racOrWlRank == 0 ? nil : racOrWlRank,wlNumber: wlNumber == 0 ? nil : wlNumber)))
            
        }
        return passengerDetails
    }
    
    func retrieveAdjacentStoppingDetails(stationCode:String)->[String:Float]{
        let readQuery = "SELECT * FROM AdjacentStationDetails WHERE station1Code = '\(stationCode)' OR station2Code = '\(stationCode)';"
        var adjacentStationWithDistances : [String:Float] = [:]
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveAdjacentStoppingDetails not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            let station1Code = String(cString: sqlite3_column_text(readStatement, 0))
            let station2Code = String(cString: sqlite3_column_text(readStatement, 1))
            let distanceBetweenThem = Float(sqlite3_column_double(readStatement, 2))
            print(station1Code,station2Code,distanceBetweenThem)
            
            if station1Code != stationCode {
                adjacentStationWithDistances[station1Code] = distanceBetweenThem
            }
            else{
                adjacentStationWithDistances[station2Code] = distanceBetweenThem
            }
            
        }
        return adjacentStationWithDistances
    }
    
    func retrieveRecentSearches (userId: String)->[( fromStationCode : String,  toStationCode : String, coachType:CoachType ,quotaType:QuotaType,searchDate :Date,searchTime:Date)]{
        let readQuery = "SELECT * FROM RecentSearchesTable;"
        
        
        var recentSearches : [( fromStationCode : String, toStationCode : String, coachType:CoachType ,quotaType:QuotaType,searchDate :Date,searchTime:Date)] = []
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveRecentSearches not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
            let fromStationCode = String(cString: sqlite3_column_text(readStatement, 0))
            let toStationCode = String(cString: sqlite3_column_text(readStatement, 1))
            let dateString = String(cString: sqlite3_column_text(readStatement, 2))
            let quotaType = QuotaType(rawValue:String(cString: sqlite3_column_text(readStatement, 3)))!
            let coachType = CoachType(rawValue:String(cString: sqlite3_column_text(readStatement, 4)))!
            let searchTimeString = String(cString: sqlite3_column_text(readStatement, 6))
            let dateFormatter = DateFormatter()
            
            let date = dateFormatter.toDate(format: "yyyy-MM-dd", string: dateString)
            let searchTime = dateFormatter.toDate(format: "yyyy-MM-dd'T'HH:mm:ss", string: searchTimeString)
            
            
            recentSearches.append(( fromStationCode : fromStationCode, toStationCode : toStationCode, coachType:coachType ,quotaType:quotaType,searchDate :date,searchTime:searchTime))
            
        }
        return recentSearches
    }
    
    
    func retrieveTrainNameAndNumbersOnly ()->[Int:String] {
        let readQuery = "SELECT trainName,trainNumber FROM Train;"
        
        
        var trainNamesAndNumbers : [Int:String] = [:]
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveTrainNameAndNumbersOnly not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
            let trainNumber = Int( sqlite3_column_int(readStatement, 1))
            let trainName = String(cString: sqlite3_column_text(readStatement, 0))
            
            
            trainNamesAndNumbers[trainNumber] = trainName
            
            
           
            
        }
        return trainNamesAndNumbers
    }
    
    func retrieveRacorWlTickets (coachType:CoachType, trainNumber : Int,ticketStatus : TicketBookingStatus,startDate:Date) -> [Ticket]{
        
        let startDateString = startDate.toString(format: "yyyy-MM-dd")
        
        
        
        let readQuery = "SELECT * FROM Ticket WHERE (coachType = '\(coachType.rawValue)' AND trainNumber = \(trainNumber) AND ticketStatus = '\(ticketStatus.rawValue)'AND trainStartDate = '\(startDateString)');"
        
        var racorWlTickets : [Ticket] = []
        
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveTicket not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            let pnrNumber = UInt64(sqlite3_column_int64(readStatement, 0))
            let trainNumber = Int(sqlite3_column_int(readStatement, 1))
            let fromStation = String(cString: sqlite3_column_text(readStatement, 2))
            let toStation = String(cString: sqlite3_column_text(readStatement, 3))
            let quotaType =  QuotaType(rawValue:String(cString: sqlite3_column_text(readStatement, 4)))!
            let coachType =  CoachType(rawValue:String(cString: sqlite3_column_text(readStatement, 5)))!
            let startTimeString = String(cString: sqlite3_column_text(readStatement, 6))
            let endTimeString = String(cString: sqlite3_column_text(readStatement, 7))
            let startDateString = String(cString: sqlite3_column_text(readStatement, 8))
            let trainFare = Float(sqlite3_column_double(readStatement, 10))
            let istravelInsuranceOpt = ( String(cString: sqlite3_column_text(readStatement, 11)) == "Yes" ? true : false)
            
            let dateFormatter = DateFormatter()
            let startTime = dateFormatter.toDate(format: "yyyy-MM-dd'T'HH:mm", string: startTimeString)
            let endTime = dateFormatter.toDate(format: "yyyy-MM-dd'T'HH:mm", string: endTimeString)
            let startDate = dateFormatter.toDate(format: "yyyy-MM-dd", string: startDateString)
            
            
            let passengerDetails = retrievePassengerDetailsList(pnrNumber: pnrNumber)
            
            racorWlTickets.append(Ticket(pnrNumber: pnrNumber, trainNumber: trainNumber, fromStation: fromStation, toStation: toStation, quotaType: quotaType, coachType: coachType, startTime: startTime, endTime: endTime, passengerDetails: passengerDetails,ticketFare: trainFare,isTravelInsuranceOpt: istravelInsuranceOpt,startDate: startDate))
        }
        return racorWlTickets
        
    }
    
    
    func retrieveRacorWlTickets (coachType:CoachType, trainNumber : Int, ticketStatus : TicketBookingStatus, startDate:Date, fromStation:String, toStation:String) -> [Ticket]{
        
        let startDateString = startDate.toString(format: "yyyy-MM-dd")
        
        
        
        let readQuery = "SELECT * FROM Ticket WHERE (fromStation = '\(fromStation)' AND toStation = '\(toStation)' AND coachType = '\(coachType.rawValue)' AND trainNumber = \(trainNumber) AND ticketStatus = '\(ticketStatus.rawValue)'AND trainStartDate = '\(startDateString)');"
        
        var racorWlTickets : [Ticket] = []
        
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveTicket not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            let pnrNumber = UInt64(sqlite3_column_int64(readStatement, 0))
            let trainNumber = Int(sqlite3_column_int(readStatement, 1))
            let fromStation = String(cString: sqlite3_column_text(readStatement, 2))
            let toStation = String(cString: sqlite3_column_text(readStatement, 3))
            let quotaType =  QuotaType(rawValue:String(cString: sqlite3_column_text(readStatement, 4)))!
            let coachType =  CoachType(rawValue:String(cString: sqlite3_column_text(readStatement, 5)))!
            let startTimeString = String(cString: sqlite3_column_text(readStatement, 6))
            let endTimeString = String(cString: sqlite3_column_text(readStatement, 7))
            let startDateString = String(cString: sqlite3_column_text(readStatement, 8))
            let trainFare = Float(sqlite3_column_double(readStatement, 10))
            let istravelInsuranceOpt = ( String(cString: sqlite3_column_text(readStatement, 11)) == "Yes" ? true : false)
            
            let dateFormatter = DateFormatter()
            let startTime = dateFormatter.toDate(format: "yyyy-MM-dd'T'HH:mm", string: startTimeString)
            let endTime = dateFormatter.toDate(format: "yyyy-MM-dd'T'HH:mm", string: endTimeString)
            let startDate = dateFormatter.toDate(format: "yyyy-MM-dd", string: startDateString)
            
            
            let passengerDetails = retrievePassengerDetailsList(pnrNumber: pnrNumber)
            
            racorWlTickets.append(Ticket(pnrNumber: pnrNumber, trainNumber: trainNumber, fromStation: fromStation, toStation: toStation, quotaType: quotaType, coachType: coachType, startTime: startTime, endTime: endTime, passengerDetails: passengerDetails,ticketFare: trainFare,isTravelInsuranceOpt: istravelInsuranceOpt,startDate: startDate))
        }
        return racorWlTickets
        
    }
    
    
    func retrieveRacorWlNumber (fromStationCode:String, toStationCode:String,startDate:Date,seatId:String)->Int?{
        
        let startDateString = startDate.toString(format: "yyyy-MM-dd")
        
        
        let readQuery = "SELECT racOrwlId FROM seatBookedStatus WHERE (seatId = '\(seatId)' AND fromStation = '\(fromStationCode)' AND toStation = '\(toStationCode)' AND startDate = '\(startDateString)');"
        
        
        
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveTrainNameAndNumbersOnly not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
            let racorWlNumber = Int( sqlite3_column_int(readStatement, 0))
            
            return racorWlNumber
            
        }
        
        return nil
        
    }
    
    
    func retrieveSavedPassenger (userName :String) -> [(name:String,age:Int,gender:Gender,berthPreference: SeatType?,passengerNumber:Int)] {
        
       
        
        let readQuery = "SELECT * FROM SavedPassenger WHERE (userName = '\(userName)');"
        
        var passengersList : [(name:String, age:Int, gender:Gender, berthPreference: SeatType?, passengerNumber:Int)] = []
        
        
        var readStatement : OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveTrainNameAndNumbersOnly not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
            let name = String(cString: sqlite3_column_text(readStatement, 1))
            let age = Int( sqlite3_column_int(readStatement, 2))
            let gender = String(cString: sqlite3_column_text(readStatement, 3))
            let berthPreference = String(cString: sqlite3_column_text(readStatement, 5))
            let passengerNumber = Int( sqlite3_column_int(readStatement, 0))
            
            let genderValue = Gender(rawValue: gender)!
            let berthPreferenceValue = SeatType(rawValue: berthPreference)
            
            passengersList.append((name: name, age: age, gender: genderValue,berthPreference : berthPreferenceValue,passengerNumber:passengerNumber))
           
        }
        
        return passengersList
    }
    
    func retrieveAvailableSeatId (trainNumber:Int, seatNumber:Int, coachNumber:Int, seatType:SeatType, coachType:CoachType, quotaType : QuotaType) -> String{
        
        let readQuery = "SELECT seatId FROM AvailableSeatChart WHERE (trainNumber = \(trainNumber) AND seatNumber = \(seatNumber) AND coachNumber = \(coachNumber) AND seatType = '\(seatType.rawValue)' AND coachType = '\(coachType.rawValue)'  AND quotaType = '\(quotaType.rawValue)');"
        
        
        var seatId : String = ""
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveAvailableSeatId not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
           
            seatId = String(cString: sqlite3_column_text(readStatement, 0))
            
            return seatId
        }
        
        return seatId

    }
    
    
    func retrieveRacSeatId (trainNumber:Int, seatNumber:Int, coachNumber:Int, seatType:SeatType, coachType:CoachType) -> String{
        
        let readQuery = "SELECT RACSeatId FROM RACSeatChart WHERE (trainNumber = \(trainNumber) AND seatNumber = \(seatNumber) AND coachNumber = \(coachNumber) AND seatType = '\(seatType.rawValue)' AND coachType = '\(coachType.rawValue)');"
        
        
        var seatId : String = ""
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveRacSeatId not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
           
            seatId = String(cString: sqlite3_column_text(readStatement, 0))
            
            return seatId
        }
        
        return seatId

    }
    
    
    func retrieveWLSeatId (trainNumber:Int, coachType:CoachType,wlNumber:Int) -> String{
        
        let readQuery = "SELECT WLId FROM WLSeatChart WHERE (trainNumber = \(trainNumber) AND coachType = '\(coachType.rawValue)'AND WLNumber = \(wlNumber));"
        
        
        var seatId : String = ""
        
        var readStatement : OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retrieveWLSeatId not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            
           
            seatId = String(cString: sqlite3_column_text(readStatement, 0))
            
            print("ldkankfnjc\(seatId)")
            
            return seatId
        }
        
        return seatId

    }
    
    
    
    
    func retrieveRACorWlSeatIdAndValues (trainNumber:Int,coachType:CoachType,racOrWl:TicketBookingStatus)->[ String: (seatNumberOrWlNumber:Int,coachNumber:Int?)]{
        
        
        var readQuery = ""
        
        var racOrwlSeatIds :  [ String: (seatNumberOrWlNumber:Int,coachNumber:Int?)] = [:]
        
       
        
        if racOrWl == .ReservationAgainstCancellation {
            readQuery = "SELECT RACSeatId , seatNumber , coachNumber FROM RACSeatChart WHERE (trainNumber = \(trainNumber) AND coachType = '\(coachType.rawValue)');"
            
            
            
            var readStatement : OpaquePointer?
            if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
                print("retrieveRACorWlSeatIds not Working")
            }
            while sqlite3_step(readStatement) == SQLITE_ROW {
                
               
                let seatId = String(cString: sqlite3_column_text(readStatement, 0))
                let seatNumber = Int(sqlite3_column_int(readStatement, 1))
                let coachNumber = Int(sqlite3_column_int(readStatement, 2))
                
                
                racOrwlSeatIds[seatId] = (seatNumberOrWlNumber:seatNumber,coachNumber:coachNumber)
            
            }
            
        }
        
        else {
            readQuery = "SELECT WLId,wlNumber FROM WLSeatChart WHERE (trainNumber = \(trainNumber) AND coachType = '\(coachType.rawValue)');"
            
            
            
            var readStatement : OpaquePointer?
            if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
                print("retrieveRACorWlSeatIds not Working")
            }
            while sqlite3_step(readStatement) == SQLITE_ROW {
                
               
                let seatId = String(cString: sqlite3_column_text(readStatement, 0))
                let wlNumber = Int(sqlite3_column_int(readStatement, 1))
                
                print("wlNumbwr \(wlNumber)")
                racOrwlSeatIds[seatId] = (seatNumberOrWlNumber:wlNumber,coachNumber:nil)
              
            }
        }
        
       
        return racOrwlSeatIds
    }
    
    
    func retrieveAllUsers () -> [User] {
        let readQuery = "SELECT * FROM User;"
        var readStatement : OpaquePointer?
        var users : [User] = []
        
        if sqlite3_prepare_v2(self.dbPointer, readQuery, -1, &readStatement, nil) != SQLITE_OK{
            print("retriveRACSeatChart not Working")
        }
        while sqlite3_step(readStatement) == SQLITE_ROW {
            //print("inside While")
            
            let userName = String(cString: sqlite3_column_text(readStatement, 0))
            let name =  String(cString: sqlite3_column_text(readStatement, 1))
            let mail = String(cString: sqlite3_column_text(readStatement, 2))
            let mobileNumber = UInt64(sqlite3_column_int64(readStatement, 3))
           
            
            
            users.append( User(name: name, userName: userName, mail: mail, mobileNumber: mobileNumber))
            
            
                
           
            
        }
        
        return users
    }
    
    // MARK: - DELETE
    func deleteSeatBookedStatus(seatId :String,fromStation:String,toStation:String,startDate:Date){
        
        
        let startDateString = startDate.toString(format: "yyyy-MM-dd")
        
        print("deltesed \(seatId)")
        
        let deleteQuery = "DELETE  FROM seatBookedStatus WHERE (seatID = '\(seatId)' AND fromStation = '\(fromStation)' AND toStation = '\(toStation)' AND  startDate = '\(startDateString)')"

        var statement:OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, deleteQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error while preparing deleting deleteSeatBookedStatus ")
        }
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Deleted successfully in deleteSeatBookedStatus ")
            
            print("(seatID = '\(seatId)' AND fromStation = '\(fromStation)' AND toStation = '\(toStation)' AND  startDate = '\(startDateString)')")
            
        }
    }
    
    
    func deleteTicketDetails(pnrNumber:UInt64){
        
        var deleteQuery = "Delete from Ticket where pnrNumber = '\(pnrNumber)';"
        var statement:OpaquePointer?
        
        if sqlite3_prepare_v2(self.dbPointer, deleteQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error while preparing deleting deleteTicketDetailsFully1 ")
        }
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Deleted successfully in deleteTicketDetailsFully1 ")
        }
        
        deleteQuery = "Delete from PassengerDetails where pnrNumber = '\(pnrNumber)'; "
        
        if sqlite3_prepare_v2(self.dbPointer, deleteQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error while preparing deleting deleteTicketDetailsFully2 ")
        }
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Deleted successfully in deleteTicketDetailsFully 2")
        }
        
        deleteQuery = "Delete from UsersTickets where pnrNumber = '\(pnrNumber)'; "
        
        if sqlite3_prepare_v2(self.dbPointer, deleteQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error while preparing deleting deleteTicketDetailsFully3 ")
        }
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Deleted successfully in deleteTicketDetailsFully3 ")
        }
    }
    
    
//    func deleteUserTicket (pnrNumber:UInt64 ,userId:String){
//        let deleteQuery = "Delete from UsersTickets where pnrNumber = '\(pnrNumber)';Delete from PassengerDetails where pnrNumber = '\(pnrNumber)';"
//        var statement:OpaquePointer?
//        
//        if sqlite3_prepare_v2(self.dbPointer, deleteQuery, -1, &statement, nil) != SQLITE_OK {
//            print("Error while preparing deleting deleteUserTicket ")
//        }
//        
//        if sqlite3_step(statement) == SQLITE_DONE {
//            print("Deleted successfully in deleteUserTicket ")
//        }
//    }
    
    func deleteExcessRecentlySearched (fromStationCode : String,toStationCode: String,date:Date,coachType : CoachType,quotaType : QuotaType,userID : String){
        
        let dateString = date.toString(format: "yyyy-MM-dd")
        
        
        let deleteQuery = "Delete from RecentSearchesTable WHERE fromStation = '\(fromStationCode)' AND toStation = '\(toStationCode)' AND date = '\(dateString)' AND quotaType = '\(quotaType.rawValue)' AND coachType = '\(coachType.rawValue)' AND userId = '\(userID)';"
        
        var statement:OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, deleteQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error while preparing deleting deleteExcessRecentlySearched ")
        }
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Deleted successfully in deleteExcessRecentlySearched ")
        }
        
    }
    
    func deleteSavedPassenger (userName : String,passengerNumber:Int){
        
        print("\(passengerNumber) pass")
        let deleteQuery = "Delete from SavedPassenger WHERE userName = '\(userName)' AND passengerNumber = \(passengerNumber);"
        
        var statement:OpaquePointer?
        if sqlite3_prepare_v2(self.dbPointer, deleteQuery, -1, &statement, nil) != SQLITE_OK {
            print("Error while preparing deleting deleteSavedPassenger ")
        }
        
        if sqlite3_step(statement) == SQLITE_DONE {
            print("Deleted successfully in deleteSavedPassenger ")
        }
        
    }
    
    
    // MARK: - Update
    
    
    func updatePassengerDetails(bookingDetails : BookingDetails,pnrNumber:UInt64,oldseatBookedDetails:BookingDetails){


        var rACorWLNumberFinal:Int = 0
        var coachNumberFinal:Int = 0
        var seatTypeString = ""
        var seatNumberFinal = 0
        var wlNumberFinal = 0
        

        if  bookingDetails.ticketBookingStatus == .Confirmed{
            rACorWLNumberFinal = 0
            coachNumberFinal = bookingDetails.coachNumber!
            seatTypeString = bookingDetails.seatType!.rawValue
            seatNumberFinal = bookingDetails.seatNumber!
        }

        if bookingDetails.ticketBookingStatus == .WaitingList{
            rACorWLNumberFinal = bookingDetails.RacOrWlRank!
            wlNumberFinal = bookingDetails.wlNumber!
        }

        if  bookingDetails.ticketBookingStatus == .ReservationAgainstCancellation{
            seatTypeString = bookingDetails.seatType!.rawValue
            coachNumberFinal = bookingDetails.coachNumber!
            rACorWLNumberFinal = bookingDetails.RacOrWlRank!
            seatNumberFinal = bookingDetails.seatNumber!
        }


        let updateQuery = "UPDATE PassengerDetails SET coachNumber = '\(coachNumberFinal)',seatNumber = '\(seatNumberFinal)',seatType = '\(seatTypeString)',ticketBookingStatus = '\(bookingDetails.ticketBookingStatus.rawValue)',racOrWLRank = '\(rACorWLNumberFinal)',wlNumber = \(wlNumberFinal) WHERE (pnrNumber = '\(pnrNumber)' AND  coachNumber = \(oldseatBookedDetails.coachNumber ?? 0 )  AND seatNumber = '\(oldseatBookedDetails.seatNumber ?? 0)'AND seatType = '\(oldseatBookedDetails.seatType?.rawValue ?? "")'AND ticketBookingStatus = '\(oldseatBookedDetails.ticketBookingStatus.rawValue)'AND racOrWLRank = '\(oldseatBookedDetails.RacOrWlRank ?? 0)' AND wlNumber = \(oldseatBookedDetails.wlNumber ?? 0));"

        var statement :OpaquePointer?

        if sqlite3_prepare_v2(self.dbPointer, updateQuery, -1, &statement, nil) != SQLITE_OK{
            print("updation failed")
        }

        if sqlite3_step(statement) == SQLITE_DONE{
            print("updation success")
        }

    }
   
    
    func updateTicketStatus (pnrNumber:UInt64 , ticketBookingStatus : TicketBookingStatus){
        
        let updateQuery = "UPDATE Ticket SET ticketStatus = '\(ticketBookingStatus.rawValue)' WHERE pnrNumber = '\(pnrNumber)'  ;"

        var statement :OpaquePointer?

        if sqlite3_prepare_v2(self.dbPointer, updateQuery, -1, &statement, nil) != SQLITE_OK{
            print("updation failed")
        }

        if sqlite3_step(statement) == SQLITE_DONE{
            print("updation success")
        }
        
    }
    
    
    func updateWlorRacNumbersInSeatBookedWithStation (seatId :String,fromStation:String,toStation:String,startDate:Date,updatedValue:Int){
        
        
        let dateString = startDate.toString(format: "yyyy-MM-dd")
        
        
        let updateQuery = "UPDATE seatBookedStatus SET racOrwlId = \(updatedValue) WHERE seatId = '\(seatId)' AND fromStation = '\(fromStation)' AND toStation = '\(toStation)' AND startDate = '\(dateString)';"

        var statement :OpaquePointer?

        if sqlite3_prepare_v2(self.dbPointer, updateQuery, -1, &statement, nil) != SQLITE_OK{
            print("updation failed")
        }

        if sqlite3_step(statement) == SQLITE_DONE{
            print("updation success")
        }
        
        
    }
    
    func updateRacNumber (pnrNumber : UInt64,seatNumber:Int,coachNumber:Int,racRank:Int) {
        
        let updateQuery = "UPDATE PassengerDetails SET RACorWLRank = \(racRank) WHERE pnrNumber = \(pnrNumber) AND seatNumber = '\(seatNumber)' AND coachNumber = '\(coachNumber)' AND ticketBookingStatus = '\(TicketBookingStatus.ReservationAgainstCancellation.rawValue)';"

        var statement :OpaquePointer?

        if sqlite3_prepare_v2(self.dbPointer, updateQuery, -1, &statement, nil) != SQLITE_OK{
            print("updation failed")
        }

        if sqlite3_step(statement) == SQLITE_DONE{
            print("updation success")
        }
        
        
    }
    
    
    func updateWlNumber (pnrNumber : UInt64,wlNumber:Int,wlRank:Int) {
        
        let updateQuery = "UPDATE PassengerDetails SET RACorWLRank = \(wlRank) WHERE pnrNumber = \(pnrNumber) AND WlNumber = '\(wlNumber)' ticketBookingStatus = '\(TicketBookingStatus.WaitingList.rawValue)';"

        var statement :OpaquePointer?

        if sqlite3_prepare_v2(self.dbPointer, updateQuery, -1, &statement, nil) != SQLITE_OK{
            print("updation failed")
        }

        if sqlite3_step(statement) == SQLITE_DONE{
            print("updation success")
        }
    }
    
    func updateTicketStatusToCancel (pnrNumber : UInt64,ticketFare : Float) {
        
        var updateQuery = "UPDATE Ticket SET ticketStatus = '\(TicketBookingStatus.Cancelled.rawValue)' , ticketFare = \(ticketFare) WHERE pnrNumber = \(pnrNumber);"
        
       

        var statement :OpaquePointer?

        if sqlite3_prepare_v2(self.dbPointer, updateQuery, -1, &statement, nil) != SQLITE_OK{
            print("updation failed")
        }

        if sqlite3_step(statement) == SQLITE_DONE{
            print("updation success")
        }
        
        updateQuery = "UPDATE PassengerDetails SET ticketBookingStatus = '\(TicketBookingStatus.Cancelled.rawValue)' WHERE pnrNumber = \(pnrNumber);"
        
        if sqlite3_prepare_v2(self.dbPointer, updateQuery, -1, &statement, nil) != SQLITE_OK{
            print("updation failed")
        }

        if sqlite3_step(statement) == SQLITE_DONE{
            print("updation success")
        }
    }
    
    
    func updateSavedPassenger (userName:String, passengerNumber:Int, name:String, age:Int, gender:Gender , berthPreference: SeatType?){
       // berthPreference?.rawValue ?? "No Preference"
        
        let updateQuery = "UPDATE SavedPassenger SET name = '\(name)', age = \(age), gender = '\(gender.rawValue)' , berthPreference = '\(berthPreference?.rawValue ?? "No Preference")' WHERE userName = '\(userName)' AND passengerNumber = \(passengerNumber) ;"

        var statement :OpaquePointer?

        if sqlite3_prepare_v2(self.dbPointer, updateQuery, -1, &statement, nil) != SQLITE_OK{
            print("updation failed")
        }

        if sqlite3_step(statement) == SQLITE_DONE{
            print("updation success")
        }
    }
    
    func updateUserDetails (userName:String, mobileNumber:UInt64, name:String, mail:String){
        
        
        let updateQuery = "UPDATE User SET name = '\(name)', mail ='\(mail)', mobileNumber = \(mobileNumber)  WHERE userName = '\(userName)';"

        var statement :OpaquePointer?

        if sqlite3_prepare_v2(self.dbPointer, updateQuery, -1, &statement, nil) != SQLITE_OK{
            print("updation failed")
        }

        if sqlite3_step(statement) == SQLITE_DONE{
            print("updation success")
        }
    }
    
}
