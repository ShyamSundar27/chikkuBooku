//
//  Delegates & DataSources.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 07/08/22.
//
//5544170807
import Foundation


protocol SelectorViewDataSource : AnyObject {
    
    func getSelectorValues (identifier : String) -> [String]
    
    func getSelectedValue (identifier : String) -> String
    
}

protocol SelectorViewDelegate : AnyObject {
    
    func selectedValue(selectedValue:String,identifier:String)
}

protocol HomePageSearchTrainViewDelegete: AnyObject{
    
    func selectedDateValue(selectedDate:Date)
    
    func swapSelectedStations()
    
    func presentQuotaTypeSelector()
    
    func presentCoachTypeSelector()
    
    func presentSearchFromStationVc()
    
    func presentSearchToStationVc()
    
    func searchTrainsButtonClicked()
}

protocol HomePageSearchTrainViewDataSource: AnyObject{
    
    
    func getQuotaTypeSelectedValue() -> String
    
    func getCoachTypeSelectedValue() -> String
    
    func getSelectedFromStationValue() -> String
    
    func getSelectedToStationValue() -> String
    
    func getSelectedDateValue() -> Date
}

protocol QuotaTypeOrCoachTypeCellDelegate: AnyObject{
    
    func presentQuotaTypeSelector()
    
    func presentCoachTypeSelector()
}

protocol QuotaTypeOrCoachTypeCellDataSource: AnyObject{
    
    func getQuotaTypeSelectedValue() -> String
    
    func getCoachTypeSelectedValue() -> String
    
}

protocol SearchStationInputTableViewCellDelegate :AnyObject{
    
    func presentSearchStationVc(identifier : String)
}

protocol SearchStationTableViewControllerDelegate: AnyObject{
    
    func selectedStationValue(identifier : String,stationName:String,stationCode :String)
    
    func selectedRecentSearched (fromStationNameAndCode:(name:String,code:String),  toStationNameAndCode : (name:String,code:String))
}

protocol JourneyDateSelecterTableViewCellDelegate : AnyObject {
    func selectedDateValue(date:Date)
}

protocol TrainAvailabilityListViewControllerDelegate : AnyObject{
    
}



protocol SeatAvailabilityDisplayTableViewCellDelegate : AnyObject {
    func presentCoachSeatAvailabilityForRemainingDays(coachType:CoachType,indexPath:IndexPath)
}

protocol RemainingDaysSeatAvailabilityTableViewCellDelegate : AnyObject{
    func bookingButtonPressed(bookingDate:Date)
}


protocol SearchStationInputsTableViewCellDelegate :AnyObject{
    
    func presentSearchFromStationVc()
    
    func presentSearchToStationVc()
    
    func swapButtonClicked()
}

protocol AddPassengerTableViewCellDelegate : AnyObject{
    
    func addPassengerButtonClicked()
    
    func addExistingPassengerButtonClicked()
}

protocol UserDetailsReceiverTableViewCellDelegate : AnyObject {
    func presentBerthTypeSelector ()
    
    func nameTextFieldEndEditing(enteredText : String)
    
    func ageTextFieldEndEditing(enteredText : String)
    
    func passengerInputValues(name:String, age:Int, gender:Gender, BerthPreference:String, isToBeUpdated:Bool)
}

protocol NewPassengerAddingViewControllerDelegete : AnyObject {
    
    func passengerInputValues (name:String, age:Int, gender:Gender, berthPreference:String, isToBeUpdated:Bool, passengerNumber:Int?)
    
    
}

protocol PassengerDetailsTableViewCellDelegate : AnyObject {
    func deletePassenger(passengerNumber : Int)
}

protocol TextFieldInputTableViewCellDelegate : AnyObject {
    func editingEnded (enteredText : String,identifier:String)
    
    func startsEditing ()
}


protocol RecentSearchesDisplayTableViewCellDelegate : AnyObject {
    
    func selectedRecentSearchValue (recentSearch:( fromStationNameAndCode : (name:String,code:String), toStationNameAndCode : (name:String,code:String), coachType:CoachType ,quotaType:QuotaType,searchDate :Date))
        
    }


protocol TrainSearchTableViewControllerDelegate : AnyObject {
    
    func presentTrainScheduleFor(trainNumber:Int,trainName : String)
        
    
}


protocol OtherServicesTableViewCellDelegate : AnyObject {
    
    func otherSrevicesSelected (otherServices : OtherServices )
}

protocol EditProfileViewControllerDelegete : AnyObject {
    
    func doneButtonPressed ()
}


protocol PrefferedCoachViewControllerDelegate : AnyObject {
    
    func selectedCoachName (coachName : String)
}

protocol ExistingPassengerViewControllerDelegate : AnyObject {
    
    func selectedPassengerNumbers (passengerNumbers:[Int])
}
