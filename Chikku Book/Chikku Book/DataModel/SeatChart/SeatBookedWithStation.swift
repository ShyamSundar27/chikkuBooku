//
//  SeatBookedWithStation.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 02/08/22.
//

import Foundation


class SeatBookedWithStation {
    
    let seat : Seat?
    var WlNumber : Int? = nil
    private(set) public var bookedStations : [(fromStation:String,toStation:String)]  = [(fromStation:String,toStation:String)]()
    
    init(seat : Seat){
        self.seat = seat
    }
    init(seat : Seat? , WlNumber : Int){
        self.seat = seat
        self.WlNumber = WlNumber
    }
    
    func setBookedStation (bookedStation:(fromStation:String,toStation:String)){
        bookedStations.append(bookedStation)
    }
    func removeBookedStation(removeStation:(fromStation:String,toStation:String)){
        var indexCount =  0
        for bookedStation in bookedStations {
            if bookedStation == removeStation{
                break
            }
            indexCount += 1
        }
        bookedStations.remove(at: indexCount)
    }
    //func getSeat
    
    
}
