//
//  Train.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 26/07/22.
//

import Foundation


struct Train {
    
    let trainNumber : Int
    let trainName : String
    let trainTypeDetails : TrainTypeDetails
    let numberOfDaysRunning : Int
    let stoppingList : [StoppingDetails]
    let stationPassByList : [StationPassingDetails]
    lazy private(set) public var coaches : [Coach] = createCoaches()
    private(set) public var numberOfCoachInEachType : [CoachType:Int] = [:]
    let dbManager = DBManager.getInstance()
    
    init (trainNumber : Int,
          trainName : String,
          trainType : TrainType,
          numberOfDaysRunning : Int,
          stoppingList : [StoppingDetails],
          stationPassByList : [StationPassingDetails],
          numberOf2SCoaches : Int,
          numberOfSLCoaches : Int,
          numberOf3ACoaches : Int,
          numberOf2ACoaches : Int,
          numberOf1ACoaches : Int,
          numberOfCCCoaches : Int,
          numberOfECCoaches : Int){
        
        
        
        
        self.trainNumber  = trainNumber
        self.trainName = trainName
        self.numberOfDaysRunning = numberOfDaysRunning
        self.stationPassByList = stationPassByList
        self.trainTypeDetails = dbManager.getTrainTypeDetails(trainType: trainType)!
        self.numberOfCoachInEachType[.SecondSeaterClass] = numberOf2SCoaches
        self.numberOfCoachInEachType[.SleeperClass] = numberOfSLCoaches
        self.numberOfCoachInEachType[.AirConditioned1TierClass] = numberOf1ACoaches
        self.numberOfCoachInEachType[.AirConditioned2TierClass] = numberOf2ACoaches
        self.numberOfCoachInEachType[.AirConditioned3TierClass] = numberOf3ACoaches
        self.numberOfCoachInEachType[.AirConditionedChaiCarClass] = numberOfCCCoaches
        self.numberOfCoachInEachType[.ExecutiveChairCarClass] = numberOfECCoaches
        self.stoppingList = stoppingList.sorted(by: {$0.stoppingNumber<$1.stoppingNumber})
//        self.coaches = self.createCoaches()
    
    }
    
    private func createCoaches () -> [Coach]{
        var coaches = [Coach]()
        var coachNumberCount = 0
        for _ in 0..<numberOfCoachInEachType[.SecondSeaterClass]!{
            coachNumberCount+=1
            coaches.append(SecondSeaterClass(coachNumber: coachNumberCount))
        }
        for _ in 0..<numberOfCoachInEachType[.SleeperClass]!{
            coachNumberCount+=1
            coaches.append(SleeperClass(coachNumber: coachNumberCount))
        }
        for _ in 0..<numberOfCoachInEachType[.AirConditioned1TierClass]!{
            coachNumberCount+=1
            coaches.append(AirConditioned1TierClass(coachNumber: coachNumberCount))
        }
        for _ in 0..<numberOfCoachInEachType[.AirConditioned2TierClass]!{
            coachNumberCount+=1
            coaches.append(AirConditioned2TierClass(coachNumber: coachNumberCount))
        }
        for _ in 0..<numberOfCoachInEachType[.AirConditioned3TierClass]!{
            coachNumberCount+=1
            coaches.append(AirConditioned3TierClass(coachNumber: coachNumberCount))
        }
        for _ in 0..<numberOfCoachInEachType[.AirConditionedChaiCarClass]!{
            coachNumberCount+=1
            coaches.append(AirConditionedChaiCarClass(coachNumber: coachNumberCount))
        }
        for _ in 0..<numberOfCoachInEachType[.ExecutiveChairCarClass]!{
            coachNumberCount+=1
            coaches.append(ExecutiveChairCarClass(coachNumber: coachNumberCount))
        }

        return coaches
    }
    
    
    func getCoachTypes () -> [CoachType]{
        
        var coachTypes : [CoachType] = []
        for coachType in numberOfCoachInEachType.keys{
            if numberOfCoachInEachType[coachType] != 0{
               
                coachTypes.append(coachType)
            }
        }
        
        return coachTypes
       
    }
    mutating func getCoaches ()->[CoachType:[Coach]]{
        var coachesWithTypes : [CoachType:[Coach]] = [:]
        for coachType in getCoachTypes(){
            coachesWithTypes[coachType] = []
        }
        for coach in coaches{
            coachesWithTypes[coach.coachTypeDetails.type]!.append(coach)
        }
        return coachesWithTypes
    }
    
    func getStoppingDetails(stationCode:String)->StoppingDetails?{
        for stopping in stoppingList {
            if stationCode == stopping.stationCode{
                return stopping
            }
        }
        return nil
    }
    
    func isCoachTypeAvilable(coachType:CoachType) ->Bool{
        if getCoachTypes().contains(coachType){
            return true
        }
        return false
    }
    
    func getStationPassByDetails(stationCode:String)->StationPassingDetails?{
        for stationPassByList in stationPassByList {
            if stationPassByList.stationCode == stationCode{
                return stationPassByList
            }
        }
        return  nil
    }
}

struct TrainTypeDetails {
    let type : TrainType
    private(set) public var farePerKm : [CoachType:Float] = [:]
    
    init(type : TrainType,farePerKm2S : Float,farePerKmSL : Float,farePerKm3A : Float,farePerKm2A : Float,farePerKm1A : Float,farePerKmEC : Float,farePerKmCC : Float){
        
        self.type = type
        self.farePerKm[.SecondSeaterClass] = farePerKm2S
        self.farePerKm[.SleeperClass] = farePerKmSL
        self.farePerKm[.AirConditioned1TierClass] = farePerKm1A
        self.farePerKm[.AirConditioned2TierClass] = farePerKm2A
        self.farePerKm[.AirConditioned3TierClass] = farePerKm3A
        self.farePerKm[.AirConditionedChaiCarClass] = farePerKmCC
        self.farePerKm[.ExecutiveChairCarClass] = farePerKmEC
    }
}

enum TrainType: String,CaseIterable {
    case  JanSadhapthiExpress
    case  RajdhaniExpress
    case  TejasExpress
    case  SuperFastExpress
    case  MailExpress
    case  Passenger
    
}

enum TrainPassesOrStops : String,CaseIterable {
    case Passes
    case Stops
}

