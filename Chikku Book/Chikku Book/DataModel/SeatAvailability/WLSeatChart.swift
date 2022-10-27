//
//  WLSeatChart.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 01/08/22.
//

import Foundation


class WLSeatChart {
    var WLNumberBookedStatus : [CoachType:[SeatBookedWithStation]] = [:]
    var initialNumberOfWLNumber : [CoachType : Int] = [:]
    let train :Train
    let dbManager = DBManager.getInstance()
    
    init (train:Train){
        self.train = train
        setWlNumber()
    }
    
    func setWlNumber(){
        for coachType in train.getCoaches().keys{
            switch (coachType){
            case .SleeperClass :
                WLNumberBookedStatus[.SleeperClass] = []
                initialNumberOfWLNumber[.SleeperClass] = 30
                for wlCount in 1...30{
                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.appDataBase.insertWLSeatChartTable(trainNumber: train.trainNumber, coachtype: coachType)
                }
            
            case .SecondSeaterClass :
                WLNumberBookedStatus[.SecondSeaterClass] = []
                initialNumberOfWLNumber[.SecondSeaterClass] = 35
                for wlCount in 1...35{
                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.appDataBase.insertWLSeatChartTable(trainNumber: train.trainNumber, coachtype: coachType)
                }
                
            case .AirConditioned3TierClass :
                WLNumberBookedStatus[.AirConditioned3TierClass] = []
                initialNumberOfWLNumber[.AirConditioned3TierClass] = 20
                for wlCount in 1...20{
                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.appDataBase.insertWLSeatChartTable(trainNumber: train.trainNumber, coachtype: coachType)
                }
            
            case .AirConditioned2TierClass :
                WLNumberBookedStatus[.AirConditioned2TierClass] = []
                initialNumberOfWLNumber[.AirConditioned2TierClass] = 15
                for wlCount in 1...15{
                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.appDataBase.insertWLSeatChartTable(trainNumber: train.trainNumber, coachtype: coachType)
                }
                
            case .AirConditioned1TierClass :
                WLNumberBookedStatus[.AirConditioned1TierClass] = []
                initialNumberOfWLNumber[.AirConditioned1TierClass] = 5
                for wlCount in 1...5{
                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.appDataBase.insertWLSeatChartTable(trainNumber: train.trainNumber, coachtype: coachType)
                }
                
            case .AirConditionedChaiCarClass :
                WLNumberBookedStatus[.AirConditionedChaiCarClass] = []
                initialNumberOfWLNumber[.AirConditionedChaiCarClass] = 25
                for wlCount in 1...25{
                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.appDataBase.insertWLSeatChartTable(trainNumber: train.trainNumber, coachtype: coachType)
                }
                
            case .ExecutiveChairCarClass :
                WLNumberBookedStatus[.ExecutiveChairCarClass] = []
                initialNumberOfWLNumber[.ExecutiveChairCarClass] = 5
                for wlCount in 1...5{
                    WLNumberBookedStatus[coachType]!.append(SeatBookedWithStation(seat: nil, RACOrWlNumber: wlCount))
                    dbManager.appDataBase.insertWLSeatChartTable(trainNumber: train.trainNumber, coachtype: coachType)
                }
                
            }
        }
    }
}
