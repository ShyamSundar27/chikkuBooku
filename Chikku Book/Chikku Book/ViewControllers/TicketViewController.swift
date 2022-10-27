//
//  TicketViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 04/09/22.
//

import UIKit

class TicketViewController: UIViewController {

    
    
    let ticketTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var ticket : Ticket
    
    let dbManager : DBManager = DBManager.getInstance()
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?,ticket : Ticket,fromStationName : (code:String,name:String), toStationName : (code:String,name:String)) {
        self.ticket = ticket
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Ticket"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        view.addSubview(ticketTableView)
       
        ticketTableView.delegate = self
        ticketTableView.dataSource = self
        setConstraints()
        registerCells()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    
    func addHomeBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(goToHome))
    }
    
    @objc func goToHome (){
        print ("hi")
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    func addBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
    }
    
    @objc func goBack (){
        print ("hi")
        navigationController?.popViewController(animated: true)
    }
    
    
    func addCancelButton(){
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel Ticket", style: .plain, target: self, action: #selector(cancelTicket))
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
        
       
            
    }
    
    @objc func cancelTicket () {
        
        
        let alertController = UIAlertController(title: nil, message: "Are you sure! Do you want to Cancel Ticket ?", preferredStyle: .alert)
        
        let yesButton = UIAlertAction(title: "Yes", style: .default,handler: {[weak self]_ in
                                                                              
            TicketCounter().cancelTicket(ticket: self!.ticket)
                                                                              
            if let ticket = self!.dbManager.getTicket(pnrNumber: self!.ticket.pnrNumber){
                  self!.ticket =  ticket
              }
            self!.navigationItem.rightBarButtonItem = nil
            self!.ticketTableView.reloadData()
            
        })
        
        
        
        let noButton = UIAlertAction(title: "No", style: .cancel, handler: {_ in return})
        
        
        alertController.addAction(yesButton)
        
        alertController.addAction(noButton)
        
        alertController.view.tintColor = .systemGreen
        
        present(alertController, animated: true)
        
        
        
       
        
        
        
    }
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        

        
        
        ticketTableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(ticketTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(ticketTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(ticketTableView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(ticketTableView.rightAnchor.constraint(equalTo: view.rightAnchor))
        
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func registerCells (){
        ticketTableView.register(TrainNameDisplayTableViewCell.self, forCellReuseIdentifier: TrainNameDisplayTableViewCell.identifier)
        
        ticketTableView.register(TrainRunningAndCoachDetailsTableViewCell.self, forCellReuseIdentifier: TrainRunningAndCoachDetailsTableViewCell.identifier)
        
        ticketTableView.register(BookingDetailsTableViewCell.self, forCellReuseIdentifier: BookingDetailsTableViewCell.identifier)
        
        ticketTableView.register(FareDisplayTableViewCell.self, forCellReuseIdentifier: FareDisplayTableViewCell.identifier)
        
        ticketTableView.register(SeatAndPassengerTableViewCell.self, forCellReuseIdentifier: SeatAndPassengerTableViewCell.identifier)
        
    }

   
}
extension TicketViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        
        if section == 1 {
            return 1
        }
        
        if section == 2{
            return ticket.passengerDetails.count
        }
        
        if section == 3 {
            return 1
        }
        
        if section == 4 {
            return 1
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrainNameDisplayTableViewCell.identifier, for: indexPath) as! TrainNameDisplayTableViewCell
                let trainName = DBManager.getInstance().getTrainDetails(trainNumber: ticket.trainNumber)!.trainName
                cell.setTrainNameAndNumberLabelText(trainNumber: ticket.trainNumber, trainName: trainName)
                
                cell.backgroundColor = .systemOrange.withAlphaComponent(0.7)
                if ticket.ticketStatus == .Confirmed {
                    cell.backgroundColor = .systemGreen.withAlphaComponent(0.7)
                }
                else if ticket.ticketStatus == .Cancelled{
                    cell.backgroundColor = .systemRed.withAlphaComponent(0.7)
                }
                
                cell.isUserInteractionEnabled = false
                //cell.separatorInset = UIEdgeInsets(top: 0, left: 100000, bottom: 0, right: -100)
                cell.layoutMargins = UIEdgeInsets.zero
                cell.selectionStyle = .none
                return cell
            }
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TrainRunningAndCoachDetailsTableViewCell.identifier, for: indexPath) as! TrainRunningAndCoachDetailsTableViewCell
                                
                let fromStationName = dbManager.getStationNamesandCodes()[ticket.fromStation]!
                
                let toStationName = dbManager.getStationNamesandCodes()[ticket.toStation]!
                
                


                cell.setValuesOfView(fromStationNameAndCode: (code:fromStationName,name:ticket.fromStation), toStationNameAndCode: (code:toStationName,name:ticket.toStation), fromStationDepTime: ticket.startTime, toStationArrTime: ticket.endTime, travelStartDate: ticket.startTime, travelEndDate: ticket.endTime, startStationDayOfTravel:nil , endStationDayOfTravel: nil)
                
//                cell.backgroundColor = .systemOrange.withAlphaComponent(0.7)
//                if ticket.ticketStatus == .Confirmed {
//                    cell.backgroundColor = .systemGreen.withAlphaComponent(0.7)
//                }
//                else if ticket.ticketStatus == .Cancelled{
//                    cell.backgroundColor = .systemRed.withAlphaComponent(0.7)
//                }
//                
                cell.isUserInteractionEnabled = false
                cell.separatorInset = UIEdgeInsets(top: 0, left: 100000, bottom: 0, right: -100)
                cell.layoutMargins = UIEdgeInsets.zero
                cell.selectionStyle = .none
                return cell
            }
            if indexPath.row == 2{
                let cell = tableView.dequeueReusableCell(withIdentifier: BookingDetailsTableViewCell.identifier, for: indexPath) as! BookingDetailsTableViewCell
                cell.setLabelValues(trainSeatAvailability: nil, coachType: ticket.coachType, quotaType: ticket.quotaType)
                
//                cell.backgroundColor = .systemOrange.withAlphaComponent(0.7)
//                if ticket.ticketStatus == .Confirmed {
//                    cell.backgroundColor = .systemGreen.withAlphaComponent(0.7)
//                }
//                else if ticket.ticketStatus == .Cancelled{
//                    cell.backgroundColor = .systemRed.withAlphaComponent(0.7)
//                }
                
                cell.isUserInteractionEnabled = false
                cell.separatorInset = UIEdgeInsets(top: 0, left: 100000, bottom: 0, right: -100)
                cell.layoutMargins = UIEdgeInsets.zero
                cell.selectionStyle = .none
                return cell
                
            }
            
            
            
        }
        
        if indexPath.section == 1 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "PNR "
            let pnrTextView = UITextView()
            pnrTextView.text = "\(ticket.pnrNumber)"
            pnrTextView.font = .preferredFont(forTextStyle: .body)
            pnrTextView.isEditable = false
            pnrTextView.textColor = .systemGray
            pnrTextView.sizeToFit()
           
            cell.selectionStyle = .none
            cell.accessoryView = pnrTextView
            return cell
        }
        
        if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: SeatAndPassengerTableViewCell.identifier, for: indexPath)as! SeatAndPassengerTableViewCell
            let passenger = ticket.passengerDetails[indexPath.row]
            let coachName = DBManager.getInstance().getCoachDetails(coachType: ticket.coachType)!.coachName
            var coachNameAndNumber : String? = nil
            if let coachNumber = passenger.bookingDetails.coachNumber{
                coachNameAndNumber = "\(coachName)\(coachNumber)"
            }
            else {
                coachNameAndNumber = nil
            }
            cell.setValuesOfCell(name: passenger.name , age: passenger.age, gender: passenger.gender, seatNumber: passenger.bookingDetails.seatNumber, seatType: passenger.bookingDetails.seatType, coachName:coachNameAndNumber, ticketStatus: passenger.bookingDetails.ticketBookingStatus, racOrWlNumber: passenger.bookingDetails.RacOrWlRank)
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.section == 3 {
            
            let cell = UITableViewCell()
            let yesOrNoLabel : UILabel = {
                
                let label = UILabel(frame: .zero)
                label.text = (ticket.isTravelInsuranceOpt ?"Yes":"No")
                if ticket.isTravelInsuranceOpt {
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
        
        if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: FareDisplayTableViewCell.identifier, for: indexPath) as! FareDisplayTableViewCell
            
            if ticket.ticketStatus == .Cancelled {
                cell.setRefundValues(refundAmount: ticket.ticketFare, numberOfPassengers: ticket.passengerDetails.count, travelInsuranceOpt: ticket.isTravelInsuranceOpt)
            }
            
            else {
                cell.setValues(ticketFare: ticket.ticketFare, numberOfPassengers: ticket.passengerDetails.count, travelInsuranceOpt: ticket.isTravelInsuranceOpt)
            }
           
            
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "Passenger Details"
        }
        if section == 4  {
            
            if ticket.ticketStatus == .Cancelled{
                return "Refund Break Up"
            }
            return "Fare Break Up"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
    
        if let headerView = view as? UITableViewHeaderFooterView {
            

                headerView.textLabel?.textAlignment = .center
            
        }
    }
}
