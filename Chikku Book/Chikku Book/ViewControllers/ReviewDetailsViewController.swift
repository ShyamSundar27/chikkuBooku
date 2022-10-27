//
//  ReviewDetailsViewController.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 30/08/22.
//

import UIKit

class ReviewDetailsViewController: UIViewController {

    
    let reviewDetailsTableView : UITableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let passengersList : [PassengerDetailsInput]
    
    let travelInsuranceOpt : Bool
    
    let prefferedCoachNumber : String?
    
    let bookConfirmBerth : Bool
    
    let fromStationNameAndCode : (code:String,name:String)
    
    let toStationNameAndCode : (code:String,name:String)
    
    let travelDate : Date
    
    let quotaType : QuotaType
    
    let coachType : CoachType
    
    let train : Train
    
//    let bookButton : UIButton = {
//
//        let button = UIButton()
//        button.tintColor = .systemGreen
//        button.layer.cornerRadius = 10
//        return button
//    }()
    
    let seatAvailabilityInEachBookingType : SeatAvailableInEachBookingType
    
    let ticketCounter = TicketCounter()
    
    let passengerMobileNumber : UInt64
    
    
    init(nibName nibNameOrNil : String?, bundle nibBundleOrNil : Bundle?,passsengerList : [PassengerDetailsInput],travelInsuranceOpt : Bool,prefferedCoachNumber : String?,bookConfirmBerth : Bool,fromStationName : (code:String,name:String), toStationName : (code:String,name:String)  ,travelDate : Date,quotaType : QuotaType,coachType : CoachType,train : Train,passengerMobileNumber:UInt64) {
        
        self.passengersList = passsengerList
        self.travelInsuranceOpt = travelInsuranceOpt
        self.prefferedCoachNumber = prefferedCoachNumber
        self.bookConfirmBerth = bookConfirmBerth
        self.fromStationNameAndCode = fromStationName
        self.toStationNameAndCode = toStationName
        self.travelDate = travelDate
        self.quotaType = quotaType
        self.coachType = coachType
        self.train = train
        self.passengerMobileNumber = passengerMobileNumber
        self.seatAvailabilityInEachBookingType = ticketCounter.getSeatAvailabilityInEachBookingType(trainNumber: train.trainNumber, travelDate: travelDate, fromStation: fromStationName.name, toStation: toStationName.name, quotatype: quotaType, coachType: coachType)
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("Hi")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Review Details"
        view.backgroundColor = .systemBackground
        
        
        
        reviewDetailsTableView.delegate = self
        reviewDetailsTableView.dataSource = self
        registerCells()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Book Ticket", style: .plain, target: self, action: #selector(bookButtonPressed))
        
        
        view.addSubview(reviewDetailsTableView)
        //view.addSubview(bookButton)
        
        
        print ("subviewsCount \(view.subviews.count)")
        
        setConstraints()
    }
    
    
    @objc func bookButtonPressed(){
        print("Hi")
       
        if bookConfirmBerth {
            if seatAvailabilityInEachBookingType.seatsAvailable < passengersList.count{
                let alertController = UIAlertController(title: nil, message: "Booking doesn't meet your requirements of Confirm Berth. Do you wan't to continue Booking? ", preferredStyle: .alert)
                    
                let okButton = UIAlertAction(title: "Okay", style: .default,handler: {[weak self]_ in
                    self!.dismiss(animated: true)
                    self!.bookTicketAndPresentTicketVc()
                    return
                })
                
                let cancelButton = UIAlertAction(title: "Cancel", style: .cancel,handler: {_ in return})
                    
                alertController.addAction(okButton)
                
                alertController.addAction(cancelButton)
                
                alertController.view.tintColor = .systemGreen
                    
                present(alertController, animated: true)
            }
            else{
                bookTicketAndPresentTicketVc()
                return
            }
        }

        
        else{
            bookTicketAndPresentTicketVc()
            return
        }
        
       
        
      
        
       
    }
    
    func bookTicketAndPresentTicketVc () {
        
        
        
        
        let ticket = ticketCounter.bookTickets(quotatype: quotaType, travelDate: travelDate, fromStationCode: fromStationNameAndCode.code, toStationCode: toStationNameAndCode.code, coachType: coachType, trainNumber: train.trainNumber, ticketNeeded: passengersList.count, passengerDetailsInputs: passengersList, prefferedCoachNumberString: prefferedCoachNumber,isTravelInsuranceOpt: travelInsuranceOpt )
        
        if let ticket = ticket {
             
             
            
             let ticketVc = TicketViewController(nibName: nil, bundle: nil, ticket: ticket,fromStationName: fromStationNameAndCode,toStationName:toStationNameAndCode)
            ticketVc.addHomeBackButton()
             navigationController?.pushViewController(ticketVc, animated: true)
         }
        
        else{
            let alertController = UIAlertController(title: nil, message: "Ticket Not Available.Please Book For Another Date ", preferredStyle: .alert)
                
            
            
            let okButton = UIAlertAction(title: "Okay", style: .cancel,handler: {_ in return})
                
            alertController.addAction(okButton)
            
            alertController.view.tintColor = .systemGreen
                
            present(alertController, animated: true)
        }
        
       
    }
    
    func registerCells(){
        
        reviewDetailsTableView.register(TrainNameDisplayTableViewCell.self, forCellReuseIdentifier: TrainNameDisplayTableViewCell.identifier)
        
        reviewDetailsTableView.register(TrainRunningAndCoachDetailsTableViewCell.self, forCellReuseIdentifier: TrainRunningAndCoachDetailsTableViewCell.identifier)
        
        reviewDetailsTableView.register(BookingDetailsTableViewCell.self, forCellReuseIdentifier: BookingDetailsTableViewCell.identifier)
        
        reviewDetailsTableView.register(PassengerDetailsTableViewCell.self, forCellReuseIdentifier: PassengerDetailsTableViewCell.identifier)
        
        reviewDetailsTableView.register(FareDisplayTableViewCell.self, forCellReuseIdentifier: FareDisplayTableViewCell.identifier)
        
    }
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        

        
        reviewDetailsTableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(reviewDetailsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(reviewDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(reviewDetailsTableView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(reviewDetailsTableView.rightAnchor.constraint(equalTo: view.rightAnchor))
        
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func getSeatAvilabiltySpecificValues (seatsAvailableInEachBookingType:SeatAvailableInEachBookingType ) ->  (bookingTypeAvailable:TicketAvailabilityStatus,numbersAvailable : Int){
        
            
            if seatsAvailableInEachBookingType .seatsAvailable > 0 {
                return (bookingTypeAvailable:.Available,numbersAvailable : seatsAvailableInEachBookingType.seatsAvailable)
            }
        
            else if seatsAvailableInEachBookingType.racSeatsAvailable > 0{
              
                return (bookingTypeAvailable:.ReservationAgainstCancellation,numbersAvailable : seatsAvailableInEachBookingType.racSeatsBooked + 1)
            }
        
            else if seatsAvailableInEachBookingType.wlSeatsAvailable > 0{
               
                return (bookingTypeAvailable:.WaitingList,numbersAvailable : seatsAvailableInEachBookingType.wlSeatsBooked + 1)
            }
            else if seatsAvailableInEachBookingType.wlSeatsAvailable == 0 {
                return (bookingTypeAvailable:.NotAvailable,numbersAvailable : 0)
            }
            else{
                return (bookingTypeAvailable:.ChartPrepared,numbersAvailable : 0)
            }
            
           
     
    }
    

}

extension ReviewDetailsViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        if section == 1 {
            return passengersList.count
        }
        if section == 2 {
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrainNameDisplayTableViewCell.identifier, for: indexPath) as! TrainNameDisplayTableViewCell
            
                cell.separatorInset = UIEdgeInsets.zero
                cell.layoutMargins = UIEdgeInsets.zero
                cell.selectionStyle = .none
                cell.setTrainNameAndNumberLabelText(trainNumber: train.trainNumber, trainName: train.trainName)

                
                return cell
            }
            if indexPath.row == 1{
                let cell = tableView.dequeueReusableCell(withIdentifier: TrainRunningAndCoachDetailsTableViewCell.identifier, for: indexPath) as! TrainRunningAndCoachDetailsTableViewCell
                
                let fromStationStoppingNumber = train.getStoppingDetails(stationCode: fromStationNameAndCode.code)!.departureDayOfTheTrain
                let toStationStoppingNumber = train.getStoppingDetails(stationCode: toStationNameAndCode.code)!.arrivalDayOfTheTrain
                let diffInDays = (toStationStoppingNumber - fromStationStoppingNumber)
                let travelEndDate = travelDate.getDateFor(days: diffInDays )
                
                
                let fromStationStoppingDetails = train.getStoppingDetails(stationCode: fromStationNameAndCode.code)!
                let toStationStoppingDetails = train.getStoppingDetails(stationCode: toStationNameAndCode.code)!
                
                cell.setValuesOfView(fromStationNameAndCode: fromStationNameAndCode, toStationNameAndCode: toStationNameAndCode, fromStationDepTime: fromStationStoppingDetails.departureTime, toStationArrTime: toStationStoppingDetails.arrivalTime,travelStartDate: travelDate,travelEndDate:travelEndDate!,startStationDayOfTravel: nil,endStationDayOfTravel: nil)
                
                cell.isUserInteractionEnabled = false
                cell.separatorInset = UIEdgeInsets(top: 0, left: 100000, bottom: 0, right: -100)
                cell.layoutMargins = UIEdgeInsets.zero
                cell.selectionStyle = .none
                
                return cell
            }
            
            if indexPath.row == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: BookingDetailsTableViewCell.identifier, for: indexPath) as! BookingDetailsTableViewCell
                cell.setLabelValues(trainSeatAvailability: getSeatAvilabiltySpecificValues(seatsAvailableInEachBookingType: seatAvailabilityInEachBookingType), coachType: coachType, quotaType: quotaType)
                cell.isUserInteractionEnabled = false
                return cell
            }
        }
        if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PassengerDetailsTableViewCell.identifier, for: indexPath) as! PassengerDetailsTableViewCell
            cell.setLabelValues(name: passengersList[indexPath.row].name, age: passengersList[indexPath.row].age, berthPreference: passengersList[indexPath.row].seatTypePreference?.rawValue ?? "No Preference", gender: passengersList[indexPath.row].gender,passengerNumber: indexPath.row + 1)
            cell.removeDeleteButton()
            //cell.delegate = self
            cell.selectionStyle = .none
            
            return cell
        }
        
        if indexPath.section == 2{
            let cell = UITableViewCell()
            let yesOrNoLabel : UILabel = {
                
                let label = UILabel(frame: .zero)
                label.text = (travelInsuranceOpt ?"Yes":"No")
                if travelInsuranceOpt {
                    label.textColor = .systemGreen
                }
                else{
                    label.textColor = .systemGray
                }
                
                label.font = .preferredFont(forTextStyle: .body)
                label.sizeToFit()
                return label
            }()
                        
            cell.textLabel!.text = "Travel Insurance Opted"
            cell.selectionStyle = .none
            cell.accessoryView = yesOrNoLabel
           
            
            return cell
        }
        if indexPath.section == 3 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "+91 \(passengerMobileNumber)"
            cell.selectionStyle = .none

            return cell

        }
        
        if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FareDisplayTableViewCell.identifier, for: indexPath) as! FareDisplayTableViewCell
            
            let ticketFare = ticketCounter.fareCalculator(fromStationCode: fromStationNameAndCode.code, toStationCode: toStationNameAndCode.code, train: train, coachType: coachType, quotaType: quotaType, numberOfPassengers: passengersList.count,isTravelInsuranceOpt: travelInsuranceOpt,isOnlyFareNeeded: false)
            
            cell.setValues(ticketFare: ticketFare, numberOfPassengers: passengersList.count, travelInsuranceOpt: travelInsuranceOpt)
            cell.selectionStyle = .none
            return cell
            
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Journey Details"
        }
        if section == 1{
            return "Passenger Details"

        }
        if section == 2 {
           return  "Travel Insurance"
        }
        if section == 3 {
            return "Mobile Number"
        }
        if section == 4 {
            return "Fare Break Up"
        }
        return "Fare Break Up"

    }
    
    
    
}

