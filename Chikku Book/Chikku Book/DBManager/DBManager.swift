//
//  DBManager.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 28/07/22.
//

import Foundation


class DBManager {
    private let appDataBase = AppDatabase()
    
    private(set) public var coachTypeDetails : [CoachTypeDetails] = []
    private(set) public var trainTypeDetails : [TrainTypeDetails] = []
    private var staionNames : [String:String] = [:]
    private var trains : [Train] = []
    private static let shared : DBManager = DBManager()
    private var initialNumberOfWl : [CoachType:Int] = [:]
    private var initialNumberOfRac : [CoachType:Int] = [:]
    
    private init(){
       
        setInitialNumberofRacAndWlSeats()
        insertCoachTypeDetails()
        insertTrainTypeDetails()
        insertStationDetails()
        insertTrainDetails()
        getCoachTypeDetails()
        getTrainTypeDetails()
        getStationNames()
        getInitialNumberofRacAndWlSeats()
    }
    
    static func getInstance()->DBManager{
        return shared
    }
    private func getCoachTypeDetails(){
       coachTypeDetails =  appDataBase.retrieveCoachTypeDetails()
    }
    
    func getStationNamesandCodes() -> [String:String]{
        return staionNames
    }
    
    private func getTrainTypeDetails(){
        trainTypeDetails = appDataBase.retrieveTrainTypeDetails()
    }
    
    func getTrainTypeDetails(trainType : TrainType)->TrainTypeDetails?{
        for trainTypeDetail in trainTypeDetails{
            if(trainType == trainTypeDetail.type){
                return trainTypeDetail
            }
        }
        return nil
    }
    
    func getCoachDetails (coachType:CoachType)->CoachTypeDetails?{
       
        for coachTypeDetail in coachTypeDetails {
            if coachTypeDetail.type == coachType
            {
                return coachTypeDetail
            }
            
        }
        return nil
    }
    
    func getCoachTypeDetails(coachType : CoachType)->CoachTypeDetails?{
        for coachTypeDetail in coachTypeDetails{
            if(coachType == coachTypeDetail.type){
                return coachTypeDetail
            }
        }
        return nil
        
    }
    func insertCoachTypeDetails(){
        print("insertCoachTypeDetails Called")
        appDataBase.insertCoachTypeDetails(coachTypeDetails: CoachTypeDetails(type: .SecondSeaterClass,
                                                                              coachCode: "2S",
                                                                              coachName: "D",
                                                                              numberOfRowsOfSeats: 6,
                                                                              numberOfColumnsOfSeats: 6))
        appDataBase.insertCoachTypeDetails(coachTypeDetails: CoachTypeDetails(type: .SleeperClass,
                                                                              coachCode: "SL",
                                                                              coachName: "S",
                                                                              numberOfRowsOfSeats: 6,
                                                                              numberOfColumnsOfSeats: 4))
        appDataBase.insertCoachTypeDetails(coachTypeDetails: CoachTypeDetails(type: .AirConditioned3TierClass,
                                                                              coachCode: "3A",
                                                                              coachName: "B",
                                                                              numberOfRowsOfSeats: 6,
                                                                              numberOfColumnsOfSeats: 4))
        appDataBase.insertCoachTypeDetails(coachTypeDetails: CoachTypeDetails(type: .AirConditioned2TierClass,
                                                                              coachCode: "2A",
                                                                              coachName: "A",
                                                                              numberOfRowsOfSeats: 6,
                                                                              numberOfColumnsOfSeats: 3))
        appDataBase.insertCoachTypeDetails(coachTypeDetails: CoachTypeDetails(type: .AirConditioned1TierClass,
                                                                              coachCode: "1A",
                                                                              coachName: "H",
                                                                              numberOfRowsOfSeats: 2,
                                                                              numberOfColumnsOfSeats: 2))
        appDataBase.insertCoachTypeDetails(coachTypeDetails: CoachTypeDetails(type: .AirConditionedChaiCarClass,
                                                                              coachCode: "CC",
                                                                              coachName: "C",
                                                                              numberOfRowsOfSeats: 6,
                                                                              numberOfColumnsOfSeats: 6))
        appDataBase.insertCoachTypeDetails(coachTypeDetails: CoachTypeDetails(type: .ExecutiveChairCarClass,
                                                                              coachCode: "EC",
                                                                              coachName: "E",
                                                                              numberOfRowsOfSeats:  6,
                                                                              numberOfColumnsOfSeats: 4))
        
        
        
    }
    func insertTrainTypeDetails(){
        print("insertTrainTypeDetails Called")
        appDataBase.insertTrainTypeDetails(trainTypeDetails: TrainTypeDetails(type: .JanSadhapthiExpress,
                                                                              
                                                                              farePerKm2S: 1.5,
                                                                              farePerKmSL: 0,
                                                                              farePerKm3A: 0,
                                                                              farePerKm2A: 0,
                                                                              farePerKm1A: 0,
                                                                              farePerKmEC: 0,
                                                                              farePerKmCC: 2.0))
        
        appDataBase.insertTrainTypeDetails(trainTypeDetails: TrainTypeDetails(type: .MailExpress,
                                                                              
                                                                              farePerKm2S: 1.0,
                                                                              farePerKmSL: 1.75,
                                                                              farePerKm3A: 2.25,
                                                                              farePerKm2A: 2.75,
                                                                              farePerKm1A: 0,
                                                                              farePerKmEC: 0,
                                                                              farePerKmCC: 0))
        
        appDataBase.insertTrainTypeDetails(trainTypeDetails: TrainTypeDetails(type: .RajdhaniExpress,
                                                                              farePerKm2S: 1.5,
                                                                              farePerKmSL: 2.0,
                                                                              farePerKm3A: 2.5,
                                                                              farePerKm2A: 3.0,
                                                                              farePerKm1A: 3.5,
                                                                              farePerKmEC: 0,
                                                                              farePerKmCC: 2.0))
        
        appDataBase.insertTrainTypeDetails(trainTypeDetails: TrainTypeDetails(type: .SuperFastExpress,
                                                                              
                                                                              farePerKm2S: 1.5,
                                                                              farePerKmSL: 2.0,
                                                                              farePerKm3A: 2.30,
                                                                              farePerKm2A: 2.70,
                                                                              farePerKm1A: 3.50,
                                                                              farePerKmEC: 0,
                                                                              farePerKmCC: 0))
        
        appDataBase.insertTrainTypeDetails(trainTypeDetails: TrainTypeDetails(type: .TejasExpress,
                                                                            
                                                                              farePerKm2S: 0,
                                                                              farePerKmSL: 0,
                                                                              farePerKm3A: 0,
                                                                              farePerKm2A: 0,
                                                                              farePerKm1A: 0,
                                                                              farePerKmEC: 2.0,
                                                                              farePerKmCC: 3.25))
    }
    
    func insertTrainDetails(){
        print("insertTrainDetails Called")
        
        
        let timeFormat = DateFormatter()
        timeFormat.timeZone = TimeZone(abbreviation: "UTC")
        timeFormat.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        timeFormat.dateFormat = "HH:mm"

        
        
        //chozhan
        appDataBase.insertTrainDetails(trainNumber: 12345,
                                       trainName: "Chozhan Express",
                                       trainType: .SuperFastExpress,
                                       numberOfDaysRunning: 1,
                                       numberOf2SCoaches: 3,
                                       numberOfSLCoaches: 4,
                                       numberOf3ACoaches: 3,
                                       numberOf2ACoaches: 2,
                                       numberOf1ACoaches: 1,
                                       numberOfCCCoaches: 0,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "16:50")!,
                                          departureTime: timeFormat.date(from: "17:15")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 12345,
                                          stationCode: "MS")
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "17:55")!,
                                          departureTime: timeFormat.date(from: "18:00")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 12345,
                                          stationCode: "TBM")
        

        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "19:45")!,
                                          departureTime: timeFormat.date(from: "19:50")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 12345,
                                          stationCode: "VPM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "20:50")!,
                                          departureTime: timeFormat.date(from: "20:55")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 12345,
                                          stationCode: "VDM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 5,
                                          arrivalTime: timeFormat.date(from: "22:20")!,
                                          departureTime: timeFormat.date(from: "22:40")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 12345,
                                          stationCode: "TPJ")
        
        
        var isTrainStopsDetails : [String:Bool] = [ "MS":true ,"TBM":true,"VPM":true,"VDM":true,"TPJ":true]
        
        var stationPassingBy = ["MS","TBM","VPM","VDM","TPJ"]

        var distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 12345, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        
        //pandian
        appDataBase.insertTrainDetails(trainNumber: 12335,
                                       trainName: "Pandian Express",
                                       trainType: .SuperFastExpress,
                                       numberOfDaysRunning: 2,
                                       numberOf2SCoaches: 0,
                                       numberOfSLCoaches: 4,
                                       numberOf3ACoaches: 3,
                                       numberOf2ACoaches: 2,
                                       numberOf1ACoaches: 1,
                                       numberOfCCCoaches: 0,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "22:50")!,
                                          departureTime: timeFormat.date(from: "22:55")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1111111",
                                          trainNumber: 12335,
                                          stationCode: "MS")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "23:10")!,
                                          departureTime: timeFormat.date(from: "23:12")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1111111",
                                          trainNumber: 12335,
                                          stationCode: "TBM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "00:10")!,
                                          departureTime: timeFormat.date(from: "00:15")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1111111",
                                          trainNumber: 12335,
                                          stationCode: "VPM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "02:50")!,
                                          departureTime: timeFormat.date(from: "02:55")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1111111",
                                          trainNumber: 12335,
                                          stationCode: "TPJ")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 5,
                                          arrivalTime: timeFormat.date(from: "04:20")!,
                                          departureTime: timeFormat.date(from: "04:30")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1111111",
                                          trainNumber: 12335,
                                          stationCode: "MDU")
        
        isTrainStopsDetails = ["MS":true ,"TBM":true,"VPM":true,"VDM":false,"TPJ":true,"MDU":true]

        stationPassingBy = ["MS","TBM","VPM","VDM","TPJ","MDU"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 12335, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        
        
        
        //pallavan
        appDataBase.insertTrainDetails(trainNumber: 12235,
                                       trainName: "Pallavan Express",
                                       trainType: .JanSadhapthiExpress,
                                       numberOfDaysRunning: 1,
                                       numberOf2SCoaches: 5,
                                       numberOfSLCoaches: 0,
                                       numberOf3ACoaches: 0,
                                       numberOf2ACoaches: 0,
                                       numberOf1ACoaches: 0,
                                       numberOfCCCoaches: 5,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "15:30")!,
                                          departureTime: timeFormat.date(from: "15:45")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 12235,
                                          stationCode: "MS")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "16:13")!,
                                          departureTime: timeFormat.date(from: "16:15")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 12235,
                                          stationCode: "TBM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "18:05")!,
                                          departureTime: timeFormat.date(from: "18:10")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 12235,
                                          stationCode: "VPM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "18:50")!,
                                          departureTime: timeFormat.date(from: "18:52")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 12235,
                                          stationCode: "VDM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 5,
                                          arrivalTime: timeFormat.date(from: "20:45")!,
                                          departureTime: timeFormat.date(from: "20:50")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 12235,
                                          stationCode: "TPJ")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 6,
                                          arrivalTime: timeFormat.date(from: "21:43")!,
                                          departureTime: timeFormat.date(from: "21:45")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 12235,
                                          stationCode: "PDKT")
        
        
        
        isTrainStopsDetails = ["MS":true ,"TBM":true,"VPM":true,"VDM":true,"TPJ":true,"PDKT":true]

        stationPassingBy = ["MS","TBM","VPM","VDM","TPJ","PDKT"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 12235, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        //Vaigai Express
        appDataBase.insertTrainDetails(trainNumber: 12145,
                                       trainName: "Vaigai Express",
                                       trainType: .JanSadhapthiExpress,
                                       numberOfDaysRunning: 1,
                                       numberOf2SCoaches: 5,
                                       numberOfSLCoaches: 0,
                                       numberOf3ACoaches: 0,
                                       numberOf2ACoaches: 0,
                                       numberOf1ACoaches: 0,
                                       numberOfCCCoaches: 5,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "13:30")!,
                                          departureTime: timeFormat.date(from: "13:50")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1111111",
                                          trainNumber: 12145,
                                          stationCode: "MS")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "14:18")!,
                                          departureTime: timeFormat.date(from: "14:20")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1111111",
                                          trainNumber: 12145,
                                          stationCode: "TBM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "16:00")!,
                                          departureTime: timeFormat.date(from: "16:05")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1111111",
                                          trainNumber: 12145,
                                          stationCode: "VPM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "16:47")!,
                                          departureTime: timeFormat.date(from: "16:50")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1111111",
                                          trainNumber: 12145,
                                          stationCode: "VDM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 5,
                                          arrivalTime: timeFormat.date(from: "18:35")!,
                                          departureTime: timeFormat.date(from: "18:40")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1111111",
                                          trainNumber: 12145,
                                          stationCode: "TPJ")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 6,
                                          arrivalTime: timeFormat.date(from: "21:20")!,
                                          departureTime: timeFormat.date(from: "21:40")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1111111",
                                          trainNumber: 12145,
                                          stationCode: "MDU")
        
        isTrainStopsDetails = ["MS":true ,"TBM":true,"VPM":true,"VDM":true,"TPJ":true,"MDU":true]

        stationPassingBy = ["MS","TBM","VPM","VDM","TPJ","MDU"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 12145, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        
        // tejas express
        
        appDataBase.insertTrainDetails(trainNumber: 13335,
                                       trainName: "Madurai Tejas Express",
                                       trainType: .TejasExpress,
                                       numberOfDaysRunning: 1,
                                       numberOf2SCoaches: 0,
                                       numberOfSLCoaches: 0,
                                       numberOf3ACoaches: 0,
                                       numberOf2ACoaches: 0,
                                       numberOf1ACoaches: 0,
                                       numberOfCCCoaches: 0,
                                       numberOfECCoaches: 10)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "05:30")!,
                                          departureTime: timeFormat.date(from: "06:00")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13335,
                                          stationCode: "MS")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "09:55")!,
                                          departureTime: timeFormat.date(from: "10:00")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13335,
                                          stationCode: "TPJ")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "12:15")!,
                                          departureTime: timeFormat.date(from: "12:30")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13335,
                                          stationCode: "MDU")
        
        isTrainStopsDetails = ["MS":true ,"TBM":false,"VPM":false,"VDM":false,"TPJ":true,"MDU":true]

        stationPassingBy = ["MS","TBM","VPM","VDM","TPJ","MDU"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 13335, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
    
    
    
        //tejas return
        
        appDataBase.insertTrainDetails(trainNumber: 13235,
                                       trainName: "Chennai Tejas Express",
                                       trainType: .TejasExpress,
                                       numberOfDaysRunning: 1,
                                       numberOf2SCoaches: 0,
                                       numberOfSLCoaches: 0,
                                       numberOf3ACoaches: 0,
                                       numberOf2ACoaches: 0,
                                       numberOf1ACoaches: 0,
                                       numberOfCCCoaches: 0,
                                       numberOfECCoaches: 10)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "15:30")!,
                                          departureTime: timeFormat.date(from: "15:45")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101101",
                                          trainNumber: 13235,
                                          stationCode: "MDU")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "17:00")!,
                                          departureTime: timeFormat.date(from: "17:05")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101101",
                                          trainNumber: 13235,
                                          stationCode: "TPJ")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "19:10")!,
                                          departureTime: timeFormat.date(from: "19:30")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101101",
                                          trainNumber: 13235,
                                          stationCode: "MS")
        
        isTrainStopsDetails = ["MDU":true ,"TPJ":false,"VDM":false,"VPM":false,"TBM":true,"MS":true]

        stationPassingBy = ["MDU","TPJ","VDM","VPM","TBM","MS"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 13235, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        
        
        
        //cheran exp
        
        
        appDataBase.insertTrainDetails(trainNumber: 12985,
                                       trainName: "Cheran Express",
                                       trainType: .SuperFastExpress,
                                       numberOfDaysRunning: 2,
                                       numberOf2SCoaches: 1,
                                       numberOfSLCoaches: 3,
                                       numberOf3ACoaches: 2,
                                       numberOf2ACoaches: 1,
                                       numberOf1ACoaches: 1,
                                       numberOfCCCoaches: 0,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "22:40")!,
                                          departureTime: timeFormat.date(from: "22:50")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101101",
                                          trainNumber: 12985,
                                          stationCode: "CBE")
            
            
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                              arrivalTime: timeFormat.date(from: "23:33")!,
                                              departureTime: timeFormat.date(from: "23:35")!,
                                              arrivalDayOfTheTrain: 1,
                                              departureDayOfTheTrain: 1,
                                              trainAvailabilityStatusOfWeek: "1101101",
                                              trainNumber: 12985,
                                              stationCode: "KRR")
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "01:33")!,
                                          departureTime: timeFormat.date(from: "01:35")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101101",
                                          trainNumber: 12985,
                                          stationCode: "SA")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "07:00")!,
                                          departureTime: timeFormat.date(from: "07:30")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101101",
                                          trainNumber: 12985,
                                          stationCode: "MS")
        
        isTrainStopsDetails = ["CBE":true ,"KRR":true,"SA":true,"MS":true]

        stationPassingBy = ["CBE","KRR","SA","MS"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 12985, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
    
        
        appDataBase.insertTrainDetails(trainNumber: 18885,
                                       trainName: "Cheran Express",
                                       trainType: .SuperFastExpress,
                                       numberOfDaysRunning: 2,
                                       numberOf2SCoaches: 1,
                                       numberOfSLCoaches: 3,
                                       numberOf3ACoaches: 2,
                                       numberOf2ACoaches: 1,
                                       numberOf1ACoaches: 1,
                                       numberOfCCCoaches: 0,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "22:40")!,
                                          departureTime: timeFormat.date(from: "22:45")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1100111",
                                          trainNumber: 18885,
                                          stationCode: "MS")
            
            
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                              arrivalTime: timeFormat.date(from: "01:33")!,
                                              departureTime: timeFormat.date(from: "01:35")!,
                                              arrivalDayOfTheTrain: 2,
                                              departureDayOfTheTrain: 2,
                                              trainAvailabilityStatusOfWeek: "1100111",
                                              trainNumber: 18885,
                                              stationCode: "SA")
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "03:33")!,
                                          departureTime: timeFormat.date(from: "03:35")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1100111",
                                          trainNumber: 18885,
                                          stationCode: "KRR")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "07:00")!,
                                          departureTime: timeFormat.date(from: "07:30")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1100111",
                                          trainNumber: 18885,
                                          stationCode: "CBE")
        
        isTrainStopsDetails = ["MS" : true ,"SA" : true,"KRR" : true,"CBE" : true]

        stationPassingBy = ["MS","SA","KRR","CBE"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 18885, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        
        
        
        // UZHAVAN EXP
        
        appDataBase.insertTrainDetails(trainNumber: 19349,
                                       trainName: "Uzhavan Express",
                                       trainType: .SuperFastExpress,
                                       numberOfDaysRunning: 2,
                                       numberOf2SCoaches: 3,
                                       numberOfSLCoaches: 4,
                                       numberOf3ACoaches: 3,
                                       numberOf2ACoaches: 2,
                                       numberOf1ACoaches: 1,
                                       numberOfCCCoaches: 0,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "22:50")!,
                                          departureTime: timeFormat.date(from: "23:00")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101011",
                                          trainNumber: 19349,
                                          stationCode: "TPJ")
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "23:50")!,
                                          departureTime: timeFormat.date(from: "23:52")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101011",
                                          trainNumber: 19349,
                                          stationCode: "TJ")
        

        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "00:45")!,
                                          departureTime: timeFormat.date(from: "00:50")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101011",
                                          trainNumber: 19349,
                                          stationCode: "MV")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "02:50")!,
                                          departureTime: timeFormat.date(from: "02:55")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101011",
                                          trainNumber: 19349,
                                          stationCode: "VPM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 5,
                                          arrivalTime: timeFormat.date(from: "06:20")!,
                                          departureTime: timeFormat.date(from: "06:40")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101011",
                                          trainNumber: 19349,
                                          stationCode: "MS")
        
        
        isTrainStopsDetails = [ "TPJ":true ,"TJ":true,"MV":true,"VPM":true,"TBM":false,"MS":true]
        
        stationPassingBy = ["TPJ" ,"TJ","MV","VPM","TBM","MS"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 19349, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        
        
        
        // Jan shadhapthi
        
        appDataBase.insertTrainDetails(trainNumber: 11133,
                                       trainName: "CBE Janshadhapthi Express",
                                       trainType: .JanSadhapthiExpress,
                                       numberOfDaysRunning: 1,
                                       numberOf2SCoaches: 5,
                                       numberOfSLCoaches: 0,
                                       numberOf3ACoaches: 0,
                                       numberOf2ACoaches: 0,
                                       numberOf1ACoaches: 0,
                                       numberOfCCCoaches: 5,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "15:00")!,
                                          departureTime: timeFormat.date(from: "15:05")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 11133,
                                          stationCode: "MV")
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "16:40")!,
                                          departureTime: timeFormat.date(from: "16:52")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 11133,
                                          stationCode: "TJ")
        

        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "17:25")!,
                                          departureTime: timeFormat.date(from: "17:30")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 11133,
                                          stationCode: "TPJ")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "17:50")!,
                                          departureTime: timeFormat.date(from: "17:55")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 11133,
                                          stationCode: "KRR")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 5,
                                          arrivalTime: timeFormat.date(from: "20:20")!,
                                          departureTime: timeFormat.date(from: "20:40")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 11133,
                                          stationCode: "CBE")
        
        
        isTrainStopsDetails = [ "MV":true ,"TJ":true,"TPJ":true,"KRR":true,"CBE":true]
        
        stationPassingBy = ["MV" ,"TJ","TPJ","KRR","CBE"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 11133, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        
        
        //NELLAI
        
        appDataBase.insertTrainDetails(trainNumber: 13377,
                                       trainName: "Nellai Express",
                                       trainType: .SuperFastExpress,
                                       numberOfDaysRunning: 2,
                                       numberOf2SCoaches: 3,
                                       numberOfSLCoaches: 4,
                                       numberOf3ACoaches: 3,
                                       numberOf2ACoaches: 2,
                                       numberOf1ACoaches: 1,
                                       numberOfCCCoaches: 0,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "22:50")!,
                                          departureTime: timeFormat.date(from: "23:00")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13377,
                                          stationCode: "TEN")
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "23:50")!,
                                          departureTime: timeFormat.date(from: "23:52")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13377,
                                          stationCode: "MDU")
        

        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "00:45")!,
                                          departureTime: timeFormat.date(from: "00:50")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13377,
                                          stationCode: "TPJ")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "02:50")!,
                                          departureTime: timeFormat.date(from: "02:55")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13377,
                                          stationCode: "VPM")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 5,
                                          arrivalTime: timeFormat.date(from: "06:20")!,
                                          departureTime: timeFormat.date(from: "06:40")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13377,
                                          stationCode: "MS")
        
        
        isTrainStopsDetails = [ "TEN":true ,"MDU":true,"TPJ":true,"VDM":false,"VPM":true,"TBM":false,"MS":true]
        
        stationPassingBy = ["TEN" ,"MDU","TPJ","VDM","VPM","TBM","MS"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 13377, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        
        
        //Boat Mail
        
        appDataBase.insertTrainDetails(trainNumber: 14477,
                                       trainName: "Boat Mail Express",
                                       trainType: .MailExpress,
                                       numberOfDaysRunning: 2,
                                       numberOf2SCoaches: 3,
                                       numberOfSLCoaches: 4,
                                       numberOf3ACoaches: 3,
                                       numberOf2ACoaches: 2,
                                       numberOf1ACoaches: 0,
                                       numberOfCCCoaches: 0,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "22:50")!,
                                          departureTime: timeFormat.date(from: "23:00")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 14477,
                                          stationCode: "RMD")
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "23:55")!,
                                          departureTime: timeFormat.date(from: "23:58")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 14477,
                                          stationCode: "PDKT")
        

        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "01:45")!,
                                          departureTime: timeFormat.date(from: "01:50")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 14477,
                                          stationCode: "TPJ")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "03:15")!,
                                          departureTime: timeFormat.date(from: "03:25")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 14477,
                                          stationCode: "MV")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 5,
                                          arrivalTime: timeFormat.date(from: "06:30")!,
                                          departureTime: timeFormat.date(from: "07:00")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 14477,
                                          stationCode: "MS")
        
        
        isTrainStopsDetails = [ "RMD":true ,"PDKT":true,"TPJ":true ,"TJ":false,"MV":true,"VPM":false,"TBM":false,"MS":true]
        
        stationPassingBy = ["RMD" ,"PDKT","TPJ","TJ","MV","VPM","TBM","MS"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 14477, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        
        
        //Boat Mail
        
        appDataBase.insertTrainDetails(trainNumber: 14497,
                                       trainName: "Boat Mail Express",
                                       trainType: .MailExpress,
                                       numberOfDaysRunning: 2,
                                       numberOf2SCoaches: 3,
                                       numberOfSLCoaches: 4,
                                       numberOf3ACoaches: 3,
                                       numberOf2ACoaches: 2,
                                       numberOf1ACoaches: 0,
                                       numberOfCCCoaches: 0,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "22:50")!,
                                          departureTime: timeFormat.date(from: "23:00")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 14497,
                                          stationCode: "MS")
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "23:55")!,
                                          departureTime: timeFormat.date(from: "23:58")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 14497,
                                          stationCode: "MV")
        

        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "01:45")!,
                                          departureTime: timeFormat.date(from: "01:50")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 14497,
                                          stationCode: "TPJ")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "03:15")!,
                                          departureTime: timeFormat.date(from: "03:25")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 14497,
                                          stationCode: "PDKT")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 5,
                                          arrivalTime: timeFormat.date(from: "06:30")!,
                                          departureTime: timeFormat.date(from: "07:00")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 14497,
                                          stationCode: "RMD")
        
        
        isTrainStopsDetails = [ "MS":true ,"TBM":true,"VPM":true ,"MV":false,"TJ":true,"TPJ":false,"PDKT":false,"RMD":true]
        
        stationPassingBy = ["MS" ,"TBM","VPM" ,"MV","TJ","TPJ","PDKT","RMD"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 14497, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        
        // nellai return
        appDataBase.insertTrainDetails(trainNumber: 13307,
                                       trainName: "Nellai Express",
                                       trainType: .SuperFastExpress,
                                       numberOfDaysRunning: 2,
                                       numberOf2SCoaches: 3,
                                       numberOfSLCoaches: 4,
                                       numberOf3ACoaches: 3,
                                       numberOf2ACoaches: 2,
                                       numberOf1ACoaches: 1,
                                       numberOfCCCoaches: 0,
                                       numberOfECCoaches: 0)
        
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 1,
                                          arrivalTime: timeFormat.date(from: "22:55")!,
                                          departureTime: timeFormat.date(from: "23:00")!,
                                          arrivalDayOfTheTrain: 1,
                                          departureDayOfTheTrain: 1,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13307,
                                          stationCode: "MS")
        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 2,
                                          arrivalTime: timeFormat.date(from: "00:20")!,
                                          departureTime: timeFormat.date(from: "00:25")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13307,
                                          stationCode: "VPM")
        

        
        
        appDataBase.insertStoppingDetails(stoppingNumber: 3,
                                          arrivalTime: timeFormat.date(from: "01:15")!,
                                          departureTime: timeFormat.date(from: "01:20")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13307,
                                          stationCode: "TPJ")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 4,
                                          arrivalTime: timeFormat.date(from: "03:50")!,
                                          departureTime: timeFormat.date(from: "03:55")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13307,
                                          stationCode: "MDU")
        
        appDataBase.insertStoppingDetails(stoppingNumber: 5,
                                          arrivalTime: timeFormat.date(from: "06:20")!,
                                          departureTime: timeFormat.date(from: "06:40")!,
                                          arrivalDayOfTheTrain: 2,
                                          departureDayOfTheTrain: 2,
                                          trainAvailabilityStatusOfWeek: "1101111",
                                          trainNumber: 13307,
                                          stationCode: "TEN")
        
        
        isTrainStopsDetails = [ "MS":true ,"TBM":false,"VPM":true,"VDM":false,"TPJ":true,"MDU":true,"TEN":true]
        
        stationPassingBy = [ "MS","TBM","VPM","VDM","TPJ","MDU","TEN"]

        distancesBetweenStations = getStationPassingDistances(staionPassingList: stationPassingBy)
        
        
        for stationPassing in stationPassingBy{
            appDataBase.insertStationPassingDetails(trainNumber: 13307, stationCode: stationPassing, isTrainStops: isTrainStopsDetails[stationPassing]!, distanceFromTheOrigin: distancesBetweenStations[stationPassing]!)
        }
        
}
    
    func insertStationDetails(){
        
        
        appDataBase.insertStationDetails(stationCode: "MS", stationName: "Chennai Egmore")
        appDataBase.insertStationDetails(stationCode: "TPJ", stationName: "Tiruchirappalli")
        appDataBase.insertStationDetails(stationCode: "VDM", stationName: "Virudhachalam")
        appDataBase.insertStationDetails(stationCode: "VPM", stationName: "Villupuram")
        appDataBase.insertStationDetails(stationCode: "MDU", stationName: "Madurai")
        appDataBase.insertStationDetails(stationCode: "CBE", stationName: "Coimbatore")
        appDataBase.insertStationDetails(stationCode: "RMD", stationName: "Ramanathapuram")
        appDataBase.insertStationDetails(stationCode: "TEN", stationName: "Tirunelveli")
        appDataBase.insertStationDetails(stationCode: "SA", stationName: "Salem")
        appDataBase.insertStationDetails(stationCode: "KRR", stationName: "Karur")
        appDataBase.insertStationDetails(stationCode: "TJ", stationName: "Thanjavur")
        appDataBase.insertStationDetails(stationCode: "MV", stationName: "Mayiladuthurai")
        appDataBase.insertStationDetails(stationCode: "PDKT", stationName: "Pudukottai")
        appDataBase.insertStationDetails(stationCode: "TBM", stationName: "Tambaram")
        
        
        
        appDataBase.insertAdjacentStoppingDetails(station1Code: "MS", station2Code: "TBM", distanceBetweenThem: 40)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "TBM", station2Code: "VPM", distanceBetweenThem: 100)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "VPM", station2Code: "VDM", distanceBetweenThem: 60)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "VDM", station2Code: "TPJ", distanceBetweenThem: 140)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "TPJ", station2Code: "MDU", distanceBetweenThem: 120)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "MDU", station2Code: "TEN", distanceBetweenThem: 160)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "MS", station2Code: "SA", distanceBetweenThem: 260)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "SA", station2Code: "KRR", distanceBetweenThem: 130)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "KRR", station2Code: "CBE", distanceBetweenThem: 210)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "TPJ", station2Code: "KRR", distanceBetweenThem: 90)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "TPJ", station2Code: "PDKT", distanceBetweenThem: 105)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "PDKT", station2Code: "RMD", distanceBetweenThem: 175)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "VPM", station2Code: "MV", distanceBetweenThem: 256)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "MV", station2Code: "TJ", distanceBetweenThem: 106)
        appDataBase.insertAdjacentStoppingDetails(station1Code: "TJ", station2Code: "TPJ", distanceBetweenThem: 65)




    }
    
    func getStationNames(){
        staionNames = appDataBase.retrieveStationNames()
    }
    
    func setSeatAvailabilityChart() {

        if(!trains.isEmpty){
            for train in trains {
               print("trains not empty")
                let _ = seatAvailabilityChartCreator(train: train)
            }
        }
        else{
            let trainsFromDb = appDataBase.retrieveTrainDetails()
            trains = trainsFromDb
            for train in trains {
                print("trains  empty")
                let _ = seatAvailabilityChartCreator(train: train)
            }
        }
        
    }
    
    func getTrains()->[Train]{
        if(!trains.isEmpty){
            return trains
        }
        else{
            let trainsFromDb = appDataBase.retrieveTrainDetails()
            trains = trainsFromDb
            return trains
        }
    }
    
    func insertAvailableSeatChart (trainNumber :Int,quotaType: QuotaType,coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType){
        appDataBase.insertAvailableSeatsChartTable(trainNumber: trainNumber, quotaType: quotaType, coachtype: coachtype, coachNumber: coachNumber, seatNumber: seatNumber, seatType: seatType)
    }
    
    func insertWLSeatChart (trainNumber :Int,coachtype :CoachType,wlNumber:Int){
        appDataBase.insertWLSeatChartTable(trainNumber: trainNumber, coachtype: coachtype,wlNumber: wlNumber)
    }
    
    func insertRACSeatChart(trainNumber :Int,coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType){
        appDataBase.insertRACSeatsChartTable(trainNumber: trainNumber, coachtype: coachtype, coachNumber: coachNumber, seatNumber: seatNumber, seatType: seatType)
    }
    func getTrainDetails (trainNumber:Int)->Train?{
        
        return appDataBase.retrieveSeparateTrainDetails(trainNumber: trainNumber)
    }
    
    func getStationPassingDistances(staionPassingList : [String])->[String:Float]{
        
    
        var stationWithDistances : [String:Float] = [:]
        var previousStation = ""
        var totalDistance :Float =  0.0
        for stationCode in staionPassingList{
            
            if previousStation.isEmpty {
                stationWithDistances[stationCode] = totalDistance
                previousStation = stationCode
            }
            else {
                let adjacentStationWithDistances = appDataBase.retrieveAdjacentStoppingDetails(stationCode: previousStation)
                totalDistance += adjacentStationWithDistances[stationCode]!
                stationWithDistances[stationCode] = totalDistance
                previousStation = stationCode
            }
        }
        return stationWithDistances
    }
    
//    func getSeatAvailabilityChart (trainNumber:Int,startDate: Date)->SeatAvailabilityChart{
//
//        let train = getTrainDetails(trainNumber: trainNumber)
//
//
//
//        let RACSeatsChart :[(coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType,racNumber:Int,seatId:String)] = appDataBase.retrieveRACSeatChart(trainNumber: trainNumber)
//        let availableSeatsChart :[(quotaType: QuotaType,coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType,seatId:String)] = appDataBase.retrieveAvailableSeatChart(trainNumber: trainNumber)
//        let WLSeatsChart :[(coachtype :CoachType,wlNumber:Int,seatId:String)] = appDataBase.retrieveWLSeatChart(trainNumber: trainNumber)
//
//
//        var availableSeatsWithQuotas : [QuotaType:[CoachType:[Int:[SeatBookedWithStation]]]] = [:]
//        var RACSeatsBookedStatus : [CoachType:[Int:[SeatBookedWithStation]]] = [:]
//        var wLNumberBookedStatus : [CoachType:[SeatBookedWithStation]] = [:]
//
//
//        for availableSeatChart in availableSeatsChart {
//            let seatBookedStations = appDataBase.retrieveSeatBookedWithStations(seatId: availableSeatChart.seatId,startDate: startDate)
//
//            if (availableSeatsWithQuotas[availableSeatChart.quotaType] == nil) {
//                availableSeatsWithQuotas[availableSeatChart.quotaType] = [:]
//            }
//            if ( availableSeatsWithQuotas[availableSeatChart.quotaType]![availableSeatChart.coachtype] == nil){
//                availableSeatsWithQuotas[availableSeatChart.quotaType]![availableSeatChart.coachtype] = [:]
//            }
//            if(availableSeatsWithQuotas[availableSeatChart.quotaType]![availableSeatChart.coachtype]![availableSeatChart.coachNumber] == nil){
//                availableSeatsWithQuotas[availableSeatChart.quotaType]![availableSeatChart.coachtype]![availableSeatChart.coachNumber] = [SeatBookedWithStation]()
//            }
//
//
//
//            if(seatBookedStations.isEmpty){
//                availableSeatsWithQuotas[availableSeatChart.quotaType]![availableSeatChart.coachtype]![availableSeatChart.coachNumber]!.append(SeatBookedWithStation(seat: Seat(seatNumber: availableSeatChart.seatNumber, seatType: availableSeatChart.seatType)))
//            }
//            else{
//                for station in seatBookedStations {
//                    let seatBookedWithStation = SeatBookedWithStation(seat: Seat(seatNumber: availableSeatChart.seatNumber, seatType: availableSeatChart.seatType))
//                    seatBookedWithStation.setBookedStation(bookedStation: station)
//
//                    availableSeatsWithQuotas[availableSeatChart.quotaType]![availableSeatChart.coachtype]![availableSeatChart.coachNumber]!.append(seatBookedWithStation)
//
//                }
//
//            }
//        }
//
//
//
//        //RAC
//        var initialRACCount : [CoachType:Int] = [:]
//        initialRACCount[.AirConditioned3TierClass] = 0
//        initialRACCount[.AirConditioned2TierClass] = 0
//        initialRACCount[.SleeperClass] = 0
//        for racSeatChart in RACSeatsChart {
//            let racSeatBookedStations = appDataBase.retrieveSeatBookedWithStations(seatId: racSeatChart.seatId,startDate: startDate)
//
//            initialRACCount[racSeatChart.coachtype]! += 1
//            if(RACSeatsBookedStatus[racSeatChart.coachtype] == nil){
//                RACSeatsBookedStatus[racSeatChart.coachtype] = [:]
//            }
//            if(RACSeatsBookedStatus[racSeatChart.coachtype]![racSeatChart.coachNumber] == nil){
//                RACSeatsBookedStatus[racSeatChart.coachtype]![racSeatChart.coachNumber] = []
//            }
//
//
//
//            if(racSeatBookedStations.isEmpty){
//                RACSeatsBookedStatus[racSeatChart.coachtype]![racSeatChart.coachNumber]!.append(SeatBookedWithStation(seat: Seat(seatNumber: racSeatChart.seatNumber, seatType: racSeatChart.seatType), RACOrWlNumber: racSeatChart.racNumber))
//            }
//            else{
//                for station in racSeatBookedStations {
//                    let seatBookedWithStation = SeatBookedWithStation(seat: Seat(seatNumber: racSeatChart.seatNumber, seatType: racSeatChart.seatType),RACOrWlNumber: racSeatChart.racNumber)
//                    seatBookedWithStation.setBookedStation(bookedStation: station)
//
//                    RACSeatsBookedStatus[racSeatChart.coachtype]![racSeatChart.coachNumber]!.append(seatBookedWithStation)
//                }
//            }
//
//        }
//
//
//
//
//
//        //WL
//        var initialWLCount : [CoachType:Int] = [:]
//        for coachType in CoachType.allCases{
//            initialWLCount[coachType] = 0
//        }
//        for wlSeatChart in WLSeatsChart {
//            let wlBookedWithStations = appDataBase.retrieveSeatBookedWithStations(seatId: wlSeatChart.seatId,startDate: startDate)
//            if(wLNumberBookedStatus[wlSeatChart.coachtype] == nil){
//                wLNumberBookedStatus[wlSeatChart.coachtype] = []
//            }
//
//
//            if(wlBookedWithStations.isEmpty){
//                wLNumberBookedStatus[wlSeatChart.coachtype]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlSeatChart.wlNumber))
//            }
//            else{
//                for station in wlBookedWithStations {
//                    let seatBookedWithStation = SeatBookedWithStation(seat: nil, RACOrWlNumber: wlSeatChart.wlNumber)
//                    seatBookedWithStation.setBookedStation(bookedStation: station)
//
//                    wLNumberBookedStatus[wlSeatChart.coachtype]!.append(seatBookedWithStation)
//                }
//
//            }
//        }
//
//        let seatAvailabilityChart = SeatAvailabilityChart(availableSeatChart: AvailableSeatChart(availableSeatsWithQuotas: availableSeatsWithQuotas), racSeatChat: RACSeatChart(RACSeatsBookedStatus: RACSeatsBookedStatus, initialNumberOfRacSeats: initialRACCount), wlSeatChart: WLSeatChart(wLNumberBookedStatus: wLNumberBookedStatus, initialNumberOfWLNumber: initialWLCount), train: train!, startDate: startDate)
//
//        return seatAvailabilityChart
//    }
    
    func getSeatChartForQuotaType (trainNumber:Int,quotaType:QuotaType,startDate:Date) -> SeatAvailabilityChart{
        var train = getTrainDetails(trainNumber: trainNumber)!
        
        
         
        let availableSeatsChart :[(coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType,seatId:String)] = appDataBase.retrieveAvailableSeatChartWithQuotaType(trainNumber: trainNumber, quotaType: quotaType)
        
        var availableSeatsWithQuotas : [CoachType:[Int:[SeatBookedWithStation]]] = [:]
        for availableSeatChart in availableSeatsChart {
            let seatBookedStations = appDataBase.retrieveSeatBookedWithStations(seatId: availableSeatChart.seatId,startDate: startDate)
            
            
            if ( availableSeatsWithQuotas[availableSeatChart.coachtype] == nil){
                availableSeatsWithQuotas[availableSeatChart.coachtype] = [:]
            }
            if(availableSeatsWithQuotas[availableSeatChart.coachtype]![availableSeatChart.coachNumber] == nil){
                availableSeatsWithQuotas[availableSeatChart.coachtype]![availableSeatChart.coachNumber] = [SeatBookedWithStation]()
            }
            
            if(seatBookedStations.isEmpty){
                availableSeatsWithQuotas[availableSeatChart.coachtype]![availableSeatChart.coachNumber]!.append(SeatBookedWithStation(seat: Seat(seatNumber: availableSeatChart.seatNumber, seatType: availableSeatChart.seatType)))
            }
            else{
                for station in seatBookedStations {
                    let seatBookedWithStation = SeatBookedWithStation(seat: Seat(seatNumber: availableSeatChart.seatNumber, seatType: availableSeatChart.seatType))
                    seatBookedWithStation.setBookedStation(bookedStation: station)
                    
                    availableSeatsWithQuotas[availableSeatChart.coachtype]![availableSeatChart.coachNumber]!.append(seatBookedWithStation)
                    
                }
        
            }
        }
        
    
        var RACSeatsBookedStatus : [CoachType:[Int:[SeatBookedWithStation]]] = [:]
        var wLNumberBookedStatus : [CoachType:[SeatBookedWithStation]] = [:]
        
        var initialRACCount : [CoachType:Int] = [:]
        initialRACCount[.AirConditioned3TierClass] = 0
        initialRACCount[.AirConditioned2TierClass] = 0
        initialRACCount[.SleeperClass] = 0
        
        var initialWLCount : [CoachType:Int] = self.initialNumberOfWl
        for coachType in CoachType.allCases{
            initialWLCount[coachType] = 0
        }
        if(quotaType == .General){
            
            
            //RAC
            let RACSeatsChart :[(coachtype :CoachType,coachNumber :Int,seatNumber :Int,seatType :SeatType,seatId:String)] = appDataBase.retrieveRACSeatChart(trainNumber: trainNumber)
            
            
            for racSeatChart in RACSeatsChart {
                let racSeatBookedStations = appDataBase.retrieveSeatBookedWithStations(seatId: racSeatChart.seatId,startDate: startDate)
                
                initialRACCount[racSeatChart.coachtype]! += 1
                if(RACSeatsBookedStatus[racSeatChart.coachtype] == nil){
                    RACSeatsBookedStatus[racSeatChart.coachtype] = [:]
                }
                if(RACSeatsBookedStatus[racSeatChart.coachtype]![racSeatChart.coachNumber] == nil){
                    RACSeatsBookedStatus[racSeatChart.coachtype]![racSeatChart.coachNumber] = []
                }
                
                
                
                if(racSeatBookedStations.isEmpty){
                    RACSeatsBookedStatus[racSeatChart.coachtype]![racSeatChart.coachNumber]!.append(SeatBookedWithStation(seat: Seat(seatNumber: racSeatChart.seatNumber, seatType: racSeatChart.seatType)))
                }
                else{
                    for station in racSeatBookedStations {
                        let seatBookedWithStation = SeatBookedWithStation(seat: Seat(seatNumber: racSeatChart.seatNumber, seatType: racSeatChart.seatType))
                        seatBookedWithStation.setBookedStation(bookedStation: station)
                        
                        RACSeatsBookedStatus[racSeatChart.coachtype]![racSeatChart.coachNumber]!.append(seatBookedWithStation)
                    }
                }
                    
            }
            
            //WL
            let WLSeatsChart :[(coachtype :CoachType,wlNumber:Int,seatId:String)] = appDataBase.retrieveWLSeatChart(trainNumber: trainNumber)
            
            for wlSeatChart in WLSeatsChart{
                let wlBookedWithStations = appDataBase.retrieveSeatBookedWithStations(seatId: wlSeatChart.seatId,startDate: startDate)
                if(wLNumberBookedStatus[wlSeatChart.coachtype] == nil){
                    wLNumberBookedStatus[wlSeatChart.coachtype] = []
                }
                
                
                if(wlBookedWithStations.isEmpty){
                    wLNumberBookedStatus[wlSeatChart.coachtype]!.append(SeatBookedWithStation(seat: nil, WlNumber: wlSeatChart.wlNumber))
                }
                else{
                    for station in wlBookedWithStations {
                        let seatBookedWithStation = SeatBookedWithStation(seat: nil, WlNumber: wlSeatChart.wlNumber)
                        seatBookedWithStation.setBookedStation(bookedStation: station)
                        
                        wLNumberBookedStatus[wlSeatChart.coachtype]!.append(seatBookedWithStation)
                    }
                    
                }
            }


        }
        else{
            return SeatAvailabilityChart(availableSeatChart: AvailableSeatChart(availableSeatsWithQuotas: availableSeatsWithQuotas), racSeatChart: nil, wlSeatChart: nil, train: train, startDate: startDate, quotaType: quotaType)
        }
        
         
        var initialNumberOfRac : [CoachType:Int] = [:]
        
        initialNumberOfRac[.AirConditioned3TierClass] = (train.getCoaches()[.AirConditioned3TierClass]?.count ?? 0) * self.initialNumberOfRac[.AirConditioned3TierClass]!
        initialNumberOfRac[.AirConditioned2TierClass] = (train.getCoaches()[.AirConditioned2TierClass]?.count ?? 0) * self.initialNumberOfRac[.AirConditioned2TierClass]!
        initialNumberOfRac[.SleeperClass] = (train.getCoaches()[.SleeperClass]?.count ?? 0) * self.initialNumberOfRac[.SleeperClass]!

        
        return SeatAvailabilityChart(availableSeatChart:AvailableSeatChart(availableSeatsWithQuotas: availableSeatsWithQuotas), racSeatChart: RACSeatChart(RACSeatsBookedStatus: RACSeatsBookedStatus, initialNumberOfRacSeats:initialNumberOfRac  ), wlSeatChart: WLSeatChart(wLNumberBookedStatus: wLNumberBookedStatus, initialNumberOfWLNumber: initialNumberOfWl), train: train, startDate: startDate, quotaType: quotaType)

        
    
    }
    
    func setBookedStationsInDb (quotaType : QuotaType?, coachType:CoachType, coachNumber:Int?, seatType:SeatType?, seatNumber:Int?, trainNumber:Int, fromStation:String, toStation:String, startDate:Date, ticketBookingStatus:TicketBookingStatus,racOrWlId:Int? ,wlNumber:Int?){
        print("seting")
        switch(ticketBookingStatus){
        case .Confirmed :
            
            let seatId = appDataBase.retrieveAvailableSeatId(trainNumber: trainNumber, seatNumber: seatNumber!, coachNumber: coachNumber!, seatType: seatType!, coachType: coachType, quotaType: quotaType!)
            return appDataBase.insertAvailableSeatBookedWithStationsTable( fromStation: fromStation, toStation: toStation, startDate: startDate,seatId: seatId)
            
        case .ReservationAgainstCancellation :
            let seatId = appDataBase.retrieveRacSeatId(trainNumber: trainNumber, seatNumber: seatNumber!, coachNumber: coachNumber!, seatType: seatType!, coachType: coachType)
            return appDataBase.insertRACSeatBookedWithStationTable(fromStation: fromStation, toStation: toStation, startDate: startDate,racOrwlId: racOrWlId! , seatId: seatId)
        case .WaitingList :
            let seatId = appDataBase.retrieveWLSeatId(trainNumber: trainNumber, coachType: coachType, wlNumber: wlNumber!)
            return appDataBase.insertWLSeatBookedWithStationTable(fromStation: fromStation, toStation: toStation, startDate: startDate,racOrwlId: racOrWlId!,seatId: seatId)
        case .Cancelled:
            return
        }
        
    
        
    }
    
    func insertTicketDetails (ticket:Ticket){
        let passengerDetails = ticket.passengerDetails
        
        appDataBase.insertTicketDetails(pnrNumber: ticket.pnrNumber, trainNumber: ticket.trainNumber, fromStationCode: ticket.fromStation, toStationCode: ticket.toStation, quotoType: ticket.quotaType, coachtype: ticket.coachType, startTime: ticket.startTime, endTime: ticket.endTime, ticketStatus: ticket.ticketStatus,ticketFare: ticket.ticketFare,isTravelInsuranceOpt:ticket.isTravelInsuranceOpt ,startDate: ticket.startDate)
        
        
        for passengerDetail in passengerDetails {
            appDataBase.insertPassengerDetails(passengerName: passengerDetail.name,
                                              passengerAge: passengerDetail.age,
                                               passengerGender: passengerDetail.gender,coachNumber: passengerDetail.bookingDetails.coachNumber, seatnumber: passengerDetail.bookingDetails.seatNumber, seatType: passengerDetail.bookingDetails.seatType, ticketBookingStatus: passengerDetail.bookingDetails.ticketBookingStatus, pnrNumber: ticket.pnrNumber, rACorWLRank: passengerDetail.bookingDetails.RacOrWlRank,wlNumber: passengerDetail.bookingDetails.wlNumber)
        }
        
        let user = UserDefaults.standard.object(forKey: "user") as! String
        
        
        
        appDataBase.insertToUsersTicketTable(userId: user , pnrNumber: ticket.pnrNumber)
    }
    
    func getPnrNumbers () ->[UInt64]{
        return appDataBase.retrievePNRNumbers()
    }
    func insertToUserticketList(userId:String,pnrNumber:UInt64){
        
    }
    
    func removeStationFromBooked(fromStation:String, toStation:String, coachType:CoachType, quotaType:QuotaType, racOrWlId : Int? , startDate:Date, trainNumber:Int, coachNumber : Int?, seatType:SeatType?, ticketBookingStatus:TicketBookingStatus, seatNumber :Int?,wlNumber : Int?){
        
        
        print("removing ticket")
        
        switch ticketBookingStatus {
        case .Confirmed:
            let seatId = appDataBase.retrieveAvailableSeatId(trainNumber: trainNumber, seatNumber: seatNumber!, coachNumber: coachNumber!, seatType: seatType!, coachType: coachType, quotaType: quotaType)
            appDataBase.deleteSeatBookedStatus(seatId: seatId, fromStation: fromStation, toStation: toStation, startDate: startDate)
            break
        case .ReservationAgainstCancellation:
            let seatId = appDataBase.retrieveRacSeatId(trainNumber: trainNumber, seatNumber: seatNumber!, coachNumber: coachNumber!, seatType: seatType!, coachType: coachType)
            appDataBase.deleteSeatBookedStatus(seatId: seatId, fromStation: fromStation, toStation: toStation, startDate: startDate)
            
        case .WaitingList:
            print("\(trainNumber) \(coachType) \(wlNumber!)")
            let seatId = appDataBase.retrieveWLSeatId(trainNumber: trainNumber, coachType: coachType, wlNumber: wlNumber!)
            print("wl ticektf\(seatId)")
            appDataBase.deleteSeatBookedStatus(seatId: seatId, fromStation: fromStation, toStation: toStation, startDate: startDate)
        case .Cancelled:
            return
        }
        
    }
    
    
    func cancelTicket(pnrNumber:UInt64,ticketFare : Float){
        appDataBase.updateTicketStatusToCancel(pnrNumber: pnrNumber,ticketFare : ticketFare)
        
        
    }
    
    
    func getUsers () -> [User] {
        return appDataBase.retrieveAllUsers()
    }
    
    
    
    func getUpcomingUserTickets () -> [Ticket] {
        
        let userID = UserDefaults.standard.object(forKey: "user") as! String
        
        let pnrNumbers = appDataBase.retrieveUserPnrs(userId: userID)
        
        var tickets : [Ticket] = []
        
        print("Pnr numbers \(pnrNumbers.count)")
        
        for pnrNumbers in pnrNumbers {
            let ticket = appDataBase.retrieveTicketDetails(pnrNumber: pnrNumbers)!
            
            if ticket.startTime.compare(Date.now.localDate()) == .orderedDescending && ticket.ticketStatus != .Cancelled{
               
                tickets.append(ticket)
            }
        }

        return tickets
        
        
        
    }
    
    func getCancelledTicketList () -> [Ticket] {
        let userID = UserDefaults.standard.object(forKey: "user") as! String
        
        let pnrNumbers = appDataBase.retrieveUserPnrs(userId: userID)
        
        var tickets : [Ticket] = []
        
        print("Pnr numbers \(pnrNumbers.count)")
        
        for pnrNumbers in pnrNumbers {
            let ticket = appDataBase.retrieveTicketDetails(pnrNumber: pnrNumbers)!
            
            if ticket.startTime.compare(Date.now.localDate()) == .orderedDescending && ticket.ticketStatus == .Cancelled{
               
                tickets.append(ticket)
            }
        }

        return tickets
    }
    
    func getCompletedTicketList () -> [Ticket] {
        let userID = UserDefaults.standard.object(forKey: "user") as! String
        
        let pnrNumbers = appDataBase.retrieveUserPnrs(userId: userID)
        
        var tickets : [Ticket] = []
        
        for pnrNumbers in pnrNumbers {
            let ticket = appDataBase.retrieveTicketDetails(pnrNumber: pnrNumbers)!
            
            if ticket.startTime.compare(Date.now.localDate()) == .orderedAscending && ticket.ticketStatus != .Cancelled{
               
                tickets.append(ticket)
            }
        }

        return tickets
    }
    
    
    
    func setInitialNumberofRacAndWlSeats () {
        
        
        var initialNumberOfRacSeats : [CoachType:Int] = [:]
        
        initialNumberOfRacSeats[.AirConditioned2TierClass] = 6
        
        initialNumberOfRacSeats[.AirConditioned3TierClass] = 6
        
        initialNumberOfRacSeats[.SleeperClass] = 6
        
        appDataBase.insertInitialNumberOfRACSeats(initialNumberOfRAC: initialNumberOfRacSeats)
        
        var initialNumberOfWl : [CoachType:Int] = [:]
        
        initialNumberOfWl[.AirConditioned2TierClass] = 7
        initialNumberOfWl[.AirConditioned1TierClass] = 3
        initialNumberOfWl[.AirConditioned3TierClass] = 10
        initialNumberOfWl[.SleeperClass] = 15
        initialNumberOfWl[.SecondSeaterClass] = 17
        initialNumberOfWl[.AirConditionedChaiCarClass] = 12
        initialNumberOfWl[.ExecutiveChairCarClass] = 3
        
        appDataBase.insertInitialNumberOfWLSeats(initialNumberOfWL: initialNumberOfWl)
        
        

    }
    
    func getInitialNumberofRacAndWlSeats(){
        initialNumberOfWl = appDataBase.retrieveInitialNumberOfWlSeats()
        
        initialNumberOfRac = appDataBase.retrieveInitialNumberOfRacSeats()
        
        print("initialnumberofrac\(initialNumberOfRac.count)")
    }
    
    func getAvailableTrains (travelDayOfWeek : Int , fromStationNameCode : String , toStationNameCode : String) ->[Int]{
        
        return appDataBase.retrieveTrainData(travelDayOfWeek: travelDayOfWeek, fromStationNameCode: fromStationNameCode, toStationNameCode: toStationNameCode)
        
    }
    func insertRecentSearches(fromStationCode : String,toStationCode: String,date:Date,coachType : CoachType,quotaType : QuotaType,searchTime: Date){
        let userID = UserDefaults.standard.object(forKey: "user") as! String
        
        appDataBase.insertRecentSearchesDetails(fromStationCode: fromStationCode, toStationCode: toStationCode, date: date, coachType: coachType, quotaType: quotaType, userID: userID,searchTime: searchTime)
        
    }
    
    
    func retreiveRecentSearches ()->[( fromStationNameAndCode : (name:String,code:String),  toStationNameAndCode : (name:String,code:String), coachType:CoachType ,quotaType:QuotaType,searchDate :Date)]{
        
        let userID = UserDefaults.standard.object(forKey: "user") as! String
        
        var values = appDataBase.retrieveRecentSearches(userId: userID)
        
        values = values.sorted(by: { $0.searchTime.compare($1.searchTime) == .orderedDescending })
        
        if values.count > 10 {
            
            
            for valuesCount in 10..<values.count{
                
                let deleteValue = values[valuesCount]
                appDataBase.deleteExcessRecentlySearched(fromStationCode: deleteValue.fromStationCode, toStationCode: deleteValue.toStationCode, date: deleteValue.searchDate, coachType: deleteValue.coachType, quotaType: deleteValue.quotaType, userID: userID)
            }
            
        }
        
        var recentSearches : [( fromStationNameAndCode : (name:String,code:String),  toStationNameAndCode : (name:String,code:String), coachType:CoachType ,quotaType:QuotaType,searchDate :Date)] = []
        
        for value in values {
            let fromStationName = staionNames[value.fromStationCode]!
            
            let toStationName = staionNames[value.toStationCode]!
            
            recentSearches.append((fromStationNameAndCode: (name: fromStationName, code: value.fromStationCode), toStationNameAndCode: (name: toStationName, code: value.toStationCode), coachType: value.coachType, quotaType: value.quotaType,searchDate: value.searchDate))
            
        }
        
        
        
        return recentSearches
    }
    
    
    func recentSearchStationsOnly() -> [( fromStationNameAndCode : (name:String,code:String),  toStationNameAndCode : (name:String,code:String))]{
        
        
        let recentData = retreiveRecentSearches()
        
        
        var uniqueValues  : [( fromStationNameAndCode : (name:String,code:String),  toStationNameAndCode : (name:String,code:String))] = []
        
        
        for recentDatum in recentData {
            
            var uniqueValueFlag = true
            for uniqueValue in uniqueValues {
                
                if (uniqueValue.fromStationNameAndCode.code == recentDatum.fromStationNameAndCode.code && uniqueValue.toStationNameAndCode.code == recentDatum.toStationNameAndCode.code){
                        
                    uniqueValueFlag = false
                    break
                }
            }
            if uniqueValueFlag {
                uniqueValues.append((fromStationNameAndCode: recentDatum.fromStationNameAndCode, toStationNameAndCode: recentDatum.toStationNameAndCode))
            }
        }
        
        
        

        return uniqueValues
    }
    
    func retrieveTrainNameAndNumbers()->[Int:String]{
        
        return appDataBase.retrieveTrainNameAndNumbersOnly()
    }
    
    
    func retrieveRacOrWlTickets(coachType:CoachType, trainNumber : Int,ticketStatus : TicketBookingStatus,startDate:Date) -> [Ticket]{
        
        
        var tickets = appDataBase.retrieveRacorWlTickets(coachType: coachType, trainNumber: trainNumber, ticketStatus: ticketStatus, startDate: startDate)
        
        tickets = tickets.sorted(by: { $0.passengerDetails[$0.passengerDetails.count - 1 ].bookingDetails.RacOrWlRank! <  $1.passengerDetails[$1.passengerDetails.count - 1 ].bookingDetails.RacOrWlRank!})
        
        return tickets
    }
    
    func getPassword (userName : String) -> String {
        return appDataBase.retrieveUserPassword(userName: userName)
    }
    
    
    func updatePassengerDetails (bookingDetails : BookingDetails,pnrNumber:UInt64,oldBookingDetails:BookingDetails){
        
       return appDataBase.updatePassengerDetails(bookingDetails: bookingDetails, pnrNumber: pnrNumber, oldseatBookedDetails: oldBookingDetails)
        
    }
    
    func updateTicketBookingStatus (pnrNumber:UInt64 , ticketBookingStatus : TicketBookingStatus){
        return appDataBase.updateTicketStatus(pnrNumber: pnrNumber, ticketBookingStatus: ticketBookingStatus)
    }
    
    
    func  updateRacOrWlRank (fromStationCode:String, toStationCode:String, coachType:CoachType,trainNumber:Int,startDate:Date,racOrWl:TicketBookingStatus){
        
       
        
        var seatIdWithValues : [ String: (seatNumberOrWlNumber:Int,coachNumber:Int?)] = [:]
        
        var racOrWlList : [(seatId:String,racOrWlNumber:Int)] = []
        
        let racOrWlTickets : [Ticket] = appDataBase.retrieveRacorWlTickets(coachType: coachType, trainNumber: trainNumber, ticketStatus: racOrWl, startDate: startDate, fromStation: fromStationCode, toStation: toStationCode)
        
        
        
        
        if racOrWl == .ReservationAgainstCancellation {
            seatIdWithValues = appDataBase.retrieveRACorWlSeatIdAndValues(trainNumber: trainNumber, coachType: coachType, racOrWl: .ReservationAgainstCancellation)
        }
        else if racOrWl == .WaitingList {
            seatIdWithValues = appDataBase.retrieveRACorWlSeatIdAndValues(trainNumber: trainNumber, coachType: coachType, racOrWl: .WaitingList)
        }
        
        
        
        
        for seatId in seatIdWithValues.keys {
            
            if let racorWlNumber = appDataBase.retrieveRacorWlNumber(fromStationCode: fromStationCode, toStationCode: toStationCode, startDate: startDate, seatId: seatId){
                racOrWlList.append((seatId: seatId, racOrWlNumber:racorWlNumber ))

            }
            
           
            
        }
        
        racOrWlList = racOrWlList.sorted(by: {$0.racOrWlNumber < $1.racOrWlNumber})
        
        
        for racNumberCount in 0..<racOrWlList.count {
            
            racOrWlList[racNumberCount].racOrWlNumber = racNumberCount+1
            
            
            
            appDataBase.updateWlorRacNumbersInSeatBookedWithStation(seatId: racOrWlList[racNumberCount].seatId, fromStation: fromStationCode, toStation: toStationCode, startDate: startDate, updatedValue: racNumberCount+1)
            
            for ticketCount in 0..<racOrWlTickets.count {
               
                let ticket = racOrWlTickets[ticketCount]
               
                
                for passengerDetails in ticket.passengerDetails{
                    
                    if racOrWl == .ReservationAgainstCancellation {
                        let seatNumber = seatIdWithValues[racOrWlList[racNumberCount].seatId]!.seatNumberOrWlNumber
                        let coachNumber = seatIdWithValues[racOrWlList[racNumberCount].seatId]!.coachNumber!
                        
                        
                        if passengerDetails.bookingDetails.coachNumber == coachNumber && passengerDetails.bookingDetails.seatNumber == seatNumber {
                            appDataBase.updateRacNumber(pnrNumber: ticket.pnrNumber, seatNumber: seatNumber, coachNumber: coachNumber, racRank: racNumberCount+1)
                            
                        }

                    }
                    
                    else {
                        let wlNumber = seatIdWithValues[racOrWlList[racNumberCount].seatId]!.seatNumberOrWlNumber
                        
                        if passengerDetails.bookingDetails.wlNumber == wlNumber {
                            appDataBase.updateWlNumber(pnrNumber: ticket.pnrNumber, wlNumber: wlNumber, wlRank: racNumberCount+1)
                            
                        }
                        
                    }
                }
                
                
            }
            
            
            print("After")
            print(racOrWlList[racNumberCount].racOrWlNumber)
        }
        
        
        
        
        
        // do changes of changed value in seat booked with status and the tickets of passengers list
        // and also make the changes in the ticet if anything needed and write code for wl also
    
    }
    
    func addTicketToUsersCancelledTicket(ticket:Ticket){
        
        
    }
    
    func getTicket (pnrNumber: UInt64) -> Ticket?{
        appDataBase.retrieveTicketDetails(pnrNumber: pnrNumber)
    }
    
    
    func insertUserDetails (user:User,password:String)  {
        appDataBase.insertUserDetails(user: user, password: password)
    }
    
    func getUserObject () -> User? {
        
        let userName = UserDefaults.standard.object(forKey: "user")
        
        return appDataBase.retrieveUserData(userName: userName as! String)
    }
    
    
    func getUserName (mail : String) -> String {
        appDataBase.getUserName(userMail: mail)
    }
    
    
    func insertSavedPassenger (name:String, age:Int, gender:Gender, berthPreference:SeatType?) {
        let userName = UserDefaults.standard.object(forKey: "user")
        
        let savedPassenger = retrieveSavedPassenger()
            
        
       
        
        appDataBase.insertSavedPassengerDetails(name: name, age: age, gender: gender, userName: userName as! String , berthPreference: berthPreference,passengerNumber: (savedPassenger.count + 1))
    }
    
    func retrieveSavedPassenger () -> [(name:String,age:Int,gender:Gender,berthPreference:SeatType?,passengerNumber:Int)] {
        
        let userName = UserDefaults.standard.object(forKey: "user")
        
        return appDataBase.retrieveSavedPassenger(userName: userName as! String).sorted(by: { $0.passengerNumber < $1.passengerNumber
            
        })
    }
    
    func deleteSavedPasseger (passengerNumber : Int) {
        let userName = UserDefaults.standard.object(forKey: "user")
        
        appDataBase.deleteSavedPassenger(userName: userName as! String, passengerNumber: passengerNumber)
        
        updatePassegerNumber()
        
//        let userName = UserDefaults.standard.object(forKey: "user")
        
        let savedPassengers : [(name:String,age:Int, gender:Gender, berthPreference:SeatType?, passengerNumber:Int)] = retrieveSavedPassenger()
        
        var passengerCount = 1
        
        for savedPassenger in savedPassengers {
            

            
            appDataBase.insertSavedPassengerDetails(name: savedPassenger.name, age: savedPassenger.age, gender: savedPassenger.gender, userName: userName as! String , berthPreference: savedPassenger.berthPreference,passengerNumber: passengerCount)
            
            passengerCount = passengerCount + 1
           
        }
        
        
        appDataBase.deleteSavedPassenger(userName: userName as! String, passengerNumber: passengerCount)
        
        
    }
    
    
    func updatePassegerNumber () {
        
        
        
    }
    func updateSavedPassenger (name:String, age:Int, gender:Gender, berthPreference:SeatType?, passengerNumber :Int) {
        let userName = UserDefaults.standard.object(forKey: "user") as! String
        
        appDataBase.updateSavedPassenger(userName: userName, passengerNumber: passengerNumber, name: name, age: age, gender: gender, berthPreference: berthPreference)
        
    }
    
    
    func updateUserDetails (user:User){
        appDataBase.updateUserDetails(userName: user.userName, mobileNumber: user.mobileNumber, name: user.name, mail: user.mail)
    }
    
    func getUserMail () {
        
    }
}

enum SeatChartCreatedStatus : Int{
    case Created = 1
    case NotCreated = 0
}




extension Date {
    
    func toString(format: String)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        return formatter.string(from:self)
    }
    
    func getDateFor(days:Int) -> Date? {
        var  calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        return calendar.date(byAdding: .day, value: days, to: self)
    }
    func dayNumberOfWeek() -> Int? {
        var  calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        return calendar.dateComponents([.weekday], from: self).weekday
    }
    
    func secondsFromBeginningOfTheDay() -> TimeInterval {
        var  calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: self)
       
        let dateSeconds = dateComponents.hour! * 3600 + dateComponents.minute! * 60 + dateComponents.second!
       
        return TimeInterval(dateSeconds)
    }

        
    func timeOfDayInterval(toDate date: Date) -> TimeInterval {
        
        
        let date1Seconds = self.secondsFromBeginningOfTheDay()
        
        
        let date2Seconds = date.secondsFromBeginningOfTheDay()
            
        return date2Seconds - date1Seconds
    }
    
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

        return localDate
    }

}

extension DateFormatter{
    func toDate(format: String, string:String) -> Date{
        self.dateFormat = format
        self.timeZone = TimeZone(abbreviation: "UTC")
        self.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
       
        
        return date(from: string)!
    }

}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    
}
