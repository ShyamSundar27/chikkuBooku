//
//  PassengerDetailsEntryViewController.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 19/08/22.
//

import UIKit

class PassengerDetailsEntryViewController: UIViewController {
 
    
    
    var fromStationNameAndCode : (code:String,name:String)
    
    let toStationNameAndCode : (code:String,name:String)
    
    let travelDate : Date
    
    let quotaType : QuotaType
    
    let coachType : CoachType
   
    let ticketCounter = TicketCounter()
    
    var train : Train
    
    let seatAvailabilityInEachType : SeatAvailableInEachBookingType
    
    let passengerDetailsTableView : UITableView = UITableView(frame: .zero ,style: .insetGrouped)
    
    var numberOfPassengers : Int = 0
    
    var selectedStationValue : String
    
    var boardingStations : [String] = []
    
    var passengersList : [PassengerDetailsInput] = []
    
    var passengerDetailsTableViewVerticalAnchor : NSLayoutConstraint?  = nil
    
    var viewTapGesture : UITapGestureRecognizer? = nil
    
    var preffereCoachNumber : String? = nil
    
    var bookConfirmBerth : Bool = false
    
    var isTravelInsuranceNoSelected : Bool = true
    
    var isTravelInsuranceYesSelected : Bool = false
    
    var passengerMobileNumber = "\(DBManager.getInstance().getUserObject()!.mobileNumber)"
    
    var mobileNumberErrorValue = ""
    
    var existingPassengerAndItsNumber :[Int :Int] = [:]
    

    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?,fromStationName:(code:String,name:String),toStationName:(code:String,name:String),travelDate:Date,quotaType : QuotaType,coachType : CoachType,train:Train) {
        
        
        self.fromStationNameAndCode = fromStationName
        self.toStationNameAndCode = toStationName
        self.travelDate = travelDate
        self.quotaType = quotaType
        self.coachType = coachType
        self.train = train
        self.selectedStationValue = fromStationNameAndCode.name
        self.seatAvailabilityInEachType = ticketCounter.getSeatAvailabilityInEachBookingType(trainNumber: train.trainNumber, travelDate: travelDate, fromStation: fromStationName.name, toStation: toStationName.name, quotatype: quotaType, coachType: coachType)
        
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (fromStationName:(code:String,name:String), toStationName:(code:String,name:String) , travelDate:Date, quotaType : QuotaType, coachType : CoachType,train:Train) {
        self.init(nibName: nil, bundle: nil, fromStationName: fromStationName, toStationName: toStationName, travelDate: travelDate, quotaType: quotaType, coachType: coachType, train: train)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Passenger Details"
        
        setBoardingStations()
        
        
        passengerDetailsTableView.delegate = self
        passengerDetailsTableView.dataSource = self
        view.addSubview(passengerDetailsTableView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Review", style: .plain, target: self, action: #selector(reviewButtonPressed))
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        
        
        registerCells()
        setConstraints()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        passengerDetailsTableView.reloadSections([0], with: .none)

    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    @objc func reviewButtonPressed(){
        
        view.resignFirstResponder()
        var flag = false
        if passengersList.isEmpty {
            
            flag = true
            let alertController = UIAlertController(title: nil, message: "Passengers List Cannot Be Empty", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel)
            
            
            alertController.addAction(okButton)
            
            alertController.view.tintColor = .systemGreen
            
            present(alertController, animated: true)
        }
        
        
        else if !mobileNumberErrorValue.isEmpty{
            
            
            if mobileNumberErrorValue == "Mobile Number Cannot Be Empty"{
                
                flag = true

                let alertController = UIAlertController(title: nil, message: "Enter Mobile Number", preferredStyle: .alert)
                    
                let okButton = UIAlertAction(title: "OK", style: .cancel)
                    
                alertController.addAction(okButton)
                    
                alertController.view.tintColor = .systemGreen
                    
                present(alertController, animated: true)
            }
            else {
               
                let alertController = UIAlertController(title: nil, message: "Enter a Valid Mobile Number", preferredStyle: .alert)
                    
                let okButton = UIAlertAction(title: "OK", style: .cancel)
                    
                alertController.addAction(okButton)
                    
                alertController.view.tintColor = .systemGreen
                    
                present(alertController, animated: true)
                
                flag = true

            }
        }
           
       

        else if !(isTravelInsuranceNoSelected) && !(isTravelInsuranceYesSelected){
            let alertController = UIAlertController(title: nil, message: "Choose Any Option For Travel Insurance", preferredStyle: .alert)
                
            let okButton = UIAlertAction(title: "OK", style: .cancel)
                
                
            alertController.addAction(okButton)
                
            alertController.view.tintColor = .systemGreen
                
            present(alertController, animated: true)
            
            flag = true

        }
        print("\(isTravelInsuranceNoSelected) hinnhjn")
        if !flag {
            if selectedStationValue != fromStationNameAndCode.name {
                for stoppingList in train.stoppingList{
                    let stoppingName = DBManager.getInstance().getStationNamesandCodes()[stoppingList.stationCode]!
                    if stoppingName == selectedStationValue{
                        fromStationNameAndCode.name = selectedStationValue
                        fromStationNameAndCode.code = stoppingList.stationCode
                        print(fromStationNameAndCode.name,fromStationNameAndCode.code)
                        break
                    }
                    
                }
            }
            
            let reviewDetailsVc = ReviewDetailsViewController(nibName: nil, bundle: nil, passsengerList: passengersList, travelInsuranceOpt: isTravelInsuranceYesSelected, prefferedCoachNumber: preffereCoachNumber, bookConfirmBerth: bookConfirmBerth, fromStationName: fromStationNameAndCode, toStationName: toStationNameAndCode, travelDate: travelDate, quotaType: quotaType, coachType: coachType, train: train,passengerMobileNumber: UInt64(passengerMobileNumber)!)
           
            navigationController?.pushViewController(reviewDetailsVc, animated: true)
        
    
        }
    }
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        passengerDetailsTableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(passengerDetailsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(passengerDetailsTableView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(passengerDetailsTableView.rightAnchor.constraint(equalTo: view.rightAnchor))
        //constraints.append(passengerDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        passengerDetailsTableViewVerticalAnchor = passengerDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        passengerDetailsTableViewVerticalAnchor!.isActive = true
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func registerCells (){
        
        passengerDetailsTableView.register(TrainNameDisplayTableViewCell.self, forCellReuseIdentifier: TrainNameDisplayTableViewCell.identifier)
        
        passengerDetailsTableView.register(TrainRunningAndCoachDetailsTableViewCell.self, forCellReuseIdentifier: TrainRunningAndCoachDetailsTableViewCell.identifier)
        
        passengerDetailsTableView.register(BookingDetailsTableViewCell.self, forCellReuseIdentifier: BookingDetailsTableViewCell.identifier)
        
        passengerDetailsTableView.register(AddPassengerTableViewCell.self, forCellReuseIdentifier: AddPassengerTableViewCell.identifier)
        
        passengerDetailsTableView.register(PassengerDetailsTableViewCell.self, forCellReuseIdentifier: PassengerDetailsTableViewCell.identifier)
        
        passengerDetailsTableView.register(TextFieldInputTableViewCell.self, forCellReuseIdentifier: TextFieldInputTableViewCell.identifier)
        
        passengerDetailsTableView.register(CheckBoxTableViewCell.self, forCellReuseIdentifier: CheckBoxTableViewCell.identifier)
        
        passengerDetailsTableView.register(CheckBoxTableViewCell.self, forCellReuseIdentifier: "CheckBoxTableViewCell.identifier")
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
    func setBoardingStations(){
        
        let fromStationStoppingNumber = train.getStoppingDetails(stationCode: fromStationNameAndCode.code)!.stoppingNumber
        let toStationStoppingNumber = train.getStoppingDetails(stationCode: toStationNameAndCode.code)!.stoppingNumber
        
        print(fromStationStoppingNumber,toStationStoppingNumber)
        
        
        
        
        for stopping in train.stoppingList {
            
            if stopping.stoppingNumber >= fromStationStoppingNumber && stopping.stoppingNumber < toStationStoppingNumber{
                let stoppingCode = stopping.stationCode
                boardingStations.append((DBManager.getInstance().getStationNamesandCodes()[stoppingCode]!))
                
            }
           
        }
        
    }
    
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        
        
        

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
       
        
            
            passengerDetailsTableView.isScrollEnabled = true
            passengerDetailsTableViewVerticalAnchor!.isActive = false
            //passengerDetailsTableView.heightAnchor.constraint(equalTo:view.heightAnchor,constant: -(keyboardSize.height + 90)).isActive = true
            print("navigationBar \(navigationController!.navigationBar.frame.height)")
            passengerDetailsTableViewVerticalAnchor =  passengerDetailsTableView.heightAnchor.constraint(equalTo:view.heightAnchor,constant: -(keyboardSize.height + self.navigationController!.navigationBar.frame.height + 20))
            passengerDetailsTableViewVerticalAnchor!.isActive = true
            self.isModalInPresentation = true
            
            
            
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        print("KeyBoard Closing")
        
        passengerDetailsTableViewVerticalAnchor!.isActive = false
        
        passengerDetailsTableViewVerticalAnchor = passengerDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        passengerDetailsTableViewVerticalAnchor!.isActive = true
        

      
        self.isModalInPresentation = true
        

    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}

extension PassengerDetailsEntryViewController : UITableViewDelegate,UITableViewDataSource,SelectorViewDelegate,SelectorViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        
        else if section == 1 {
            return 1
        }
        
        else if section == 2 {
            return 1 + numberOfPassengers
        }
        
        else if section == 3 {
            return 1
        }
        else if section == 4 {
            return 2
        }
        
        else if section == 5 {
            return 2
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
                cell.setLabelValues(trainSeatAvailability: getSeatAvilabiltySpecificValues(seatsAvailableInEachBookingType: seatAvailabilityInEachType), coachType: coachType, quotaType: quotaType)
                cell.isUserInteractionEnabled = false
                return cell
            }
        }
        if indexPath.section == 1 {
            let cell = UITableViewCell()
            cell.isUserInteractionEnabled = true
            cell.textLabel?.text = "\(selectedStationValue)"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        if indexPath.section == 2{
            
            if indexPath.row == numberOfPassengers{
                let cell = tableView.dequeueReusableCell(withIdentifier: AddPassengerTableViewCell.identifier, for: indexPath) as! AddPassengerTableViewCell
                cell.delegate = self
                if numberOfPassengers >= 4{
                    cell.disableButtons()
                    cell.isUserInteractionEnabled = false
                    cell.selectionStyle = .none
                }
                else{
                    cell.enableButtons()
                    cell.isUserInteractionEnabled = true
                    cell.selectionStyle = .none
                }
                
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: PassengerDetailsTableViewCell.identifier, for: indexPath) as! PassengerDetailsTableViewCell
                cell.setLabelValues(name: passengersList[indexPath.row].name, age: passengersList[indexPath.row].age, berthPreference: passengersList[indexPath.row].seatTypePreference?.rawValue ?? "No Preference", gender: passengersList[indexPath.row].gender,passengerNumber: indexPath.row + 1)
                cell.delegate = self
                
                return cell
            }
        }
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldInputTableViewCell.identifier, for: indexPath) as! TextFieldInputTableViewCell
            cell.selectionStyle = .none
            
            cell.setTextFieldValues(labelName: "Mobile Number", defaultText: passengerMobileNumber, keyBoardType: .numberPad,widthOfTextField: 150)
            cell.setErrorValue(error: mobileNumberErrorValue)
            cell.delegate = self
            
            return cell
            
        }
        
        if indexPath.section == 4 {
            if indexPath.row == 0 {
//                let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldInputTableViewCell.identifier, for: indexPath) as! TextFieldInputTableViewCell
//
//                cell.setTextFieldValues(labelName: "Preffered Coach Number", defaultText: preffereCoachNumber, keyBoardType: .alphabet,widthOfTextField: 100)
//                cell.setErrorValue(error: prefferedCoachErrorValue)
//                cell.delegate = self
                
                let cell = UITableViewCell()
                
                let coachLabel : UILabel = {
                    let label = UILabel()
                    if let preffereCoachNumber = preffereCoachNumber {
                        label.font = .preferredFont(forTextStyle: .body)
                        label.text = preffereCoachNumber
                    }
                    else {
                        label.font = .preferredFont(forTextStyle: .footnote)
                        label.text = "Select"
                    }
                   
                    label.textAlignment = .center
                    return label
                }()
                
                let downArrow : UIImageView = {
                    
                    let imageView = UIImageView(frame: .zero)
                    imageView.image =  UIImage(systemName: "chevron.down")
                    imageView.tintColor = .systemGreen
                   // imageView.sizeToFit()
                    imageView.contentMode = .scaleAspectFit
                    return imageView
                }()
                
                let accessoryView = UIView(frame: CGRect(x: cell.contentView.frame.width/4, y: 0, width: cell.contentView.frame.width/3, height: cell.contentView.frame.height))
                
                accessoryView.addSubview(coachLabel)
                accessoryView.addSubview(downArrow)
                
                coachLabel.translatesAutoresizingMaskIntoConstraints = false
                downArrow.translatesAutoresizingMaskIntoConstraints = false
                
                
                NSLayoutConstraint.activate([
        
                    
                    downArrow.rightAnchor.constraint(equalTo: accessoryView.rightAnchor),
                    
                    downArrow.topAnchor.constraint(equalTo: accessoryView.topAnchor,constant: 10),
                    
                    downArrow.bottomAnchor.constraint(equalTo: coachLabel.bottomAnchor),
                    
                    downArrow.widthAnchor.constraint(equalToConstant: 20),
                    
                    coachLabel.rightAnchor.constraint(equalTo: downArrow.leftAnchor,constant: -10),
                    
                    coachLabel.topAnchor.constraint(equalTo: accessoryView.topAnchor,constant: 10),
                    
                    coachLabel.bottomAnchor.constraint(equalTo: accessoryView.bottomAnchor,constant: -10),
                    
                    coachLabel.widthAnchor.constraint(equalTo: accessoryView.widthAnchor,multiplier: 0.7),
                    
                ])
                
                accessoryView.sizeToFit()
               
                cell.textLabel?.text = "Preffered Coach Number"
                cell.accessoryView = accessoryView
                cell.selectionStyle = .none
                
                return cell
                
                
            }
            
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CheckBoxTableViewCell.identifier", for: indexPath) as! CheckBoxTableViewCell
                
                if bookConfirmBerth {
                    cell.swapCheck()
                }
                cell.setLabelValues(input: "Book Only If Confirm Berth Are Allocated",checkedImageName: nil,uncheckedImageName: nil)
                cell.selectionStyle = .none
                return cell
            }
        }
        
        if indexPath.section == 5 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: CheckBoxTableViewCell.identifier, for: indexPath) as! CheckBoxTableViewCell
                cell.setLabelValues(input: "Yes and I Accept Terms And Conditions",checkedImageName: "smallcircle.filled.circle.fill",uncheckedImageName: "circle")
                if isTravelInsuranceYesSelected {
                    cell.swapCheck()
                }
                cell.selectionStyle = .none
                return cell
            }
            
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: CheckBoxTableViewCell.identifier, for: indexPath) as! CheckBoxTableViewCell
                cell.setLabelValues(input: "No",checkedImageName:"smallcircle.filled.circle.fill" ,uncheckedImageName: "circle")
                if isTravelInsuranceNoSelected {
                    print("hi")
                    cell.swapCheck()
                }
                
                
                
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Journey Details"
        }

        if section == 1 {
            return "Change Boarding Station"
        }
        if section == 2 {
            return "Passenger Details"
        }
        if section == 3 {
            return "Passenger Mobile Number"
        }
        if section == 4 {
            return "Other Preferences"
        }
        
        if section == 5 {
            return "Do you want to opt for travel Insurance(Rs 1 / person)?"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
    
        if let headerView = view as? UITableViewHeaderFooterView {
            

                headerView.textLabel?.textAlignment = .left
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 && indexPath.section == 1 {
            let presentVc = SelectorViewController(nibName: nil, bundle: nil, identifier: "ChangeStationSelector")
            presentVc.title = "Boarding Station"
            presentVc.dataSource = self
            presentVc.delegate = self
            let presentingNc = UINavigationController(rootViewController: presentVc)
            
            if let sheet = presentingNc.sheetPresentationController{
                sheet.detents = [.medium()]
            }
            self.present(presentingNc, animated: true)
            
           
            

        }
        if indexPath.section == 2 && indexPath.row != numberOfPassengers {
            
            let presentVc = NewPassengerAddingViewController(nibName: nil, bundle: nil, coachType: coachType,isVcForUpdating: true)
            presentVc.delegate = self
            presentVc.title = "Add Passenger Details"
            
            let passenger = passengersList[indexPath.row]
            
            presentVc.addDefaultValues(passengerDetails: (name: passenger.name, age: passenger.age, gender: passenger.gender, berthPreference: passenger.seatTypePreference, passengerNumber: indexPath.row))
            
            let presentingNc = UINavigationController(rootViewController: presentVc)
            
            presentingNc.modalPresentationStyle = .pageSheet
            
            
            
            if let sheet = presentingNc.sheetPresentationController{
                sheet.detents = [.medium(),.large()]
                sheet.prefersGrabberVisible = true
            }
            self.present(presentingNc, animated: true)
            
            
        }
        
        if indexPath.section == 4 && indexPath.row == 0 {
            let presentVc = PrefferedCoachViewController()
            
            let presentingNc = UINavigationController(rootViewController: presentVc)
            
            presentingNc.modalPresentationStyle = .pageSheet
            
            presentVc.setCoachValue(coachType: coachType, numberOfCoaches: train.getCoaches()[coachType]!.count)
            
            presentVc.delegate = self
            //navigationController?.pushViewController(presentVc, animated: true)
            if let sheet = presentingNc.sheetPresentationController{
                sheet.detents = [.medium()]
                                
            }
            self.present(presentingNc, animated: true)
            
        }
        
        
        if indexPath.section == 4 && indexPath.row == 1 {
            let cell = passengerDetailsTableView.cellForRow(at: indexPath) as! CheckBoxTableViewCell
            cell.swapCheck()
            bookConfirmBerth = !bookConfirmBerth
        }
        
        if indexPath.section == 5 && indexPath.row == 0 {
            let cell = passengerDetailsTableView.cellForRow(at: indexPath) as! CheckBoxTableViewCell
            let otherCell =  passengerDetailsTableView.cellForRow(at: IndexPath(row: 1, section: 5)) as! CheckBoxTableViewCell
            
            if otherCell.isCheckBoxChecked(){
                otherCell.swapCheck()
                isTravelInsuranceNoSelected = false
            }
            cell.swapCheck()
            if cell.isCheckBoxChecked(){
                isTravelInsuranceYesSelected = true
            }
            
        }
        
        if indexPath.section == 5 && indexPath.row == 1 {
            let cell = passengerDetailsTableView.cellForRow(at: indexPath) as! CheckBoxTableViewCell
            let otherCell =  passengerDetailsTableView.cellForRow(at: IndexPath(row: 0, section: 5)) as! CheckBoxTableViewCell
            
            if otherCell.isCheckBoxChecked(){
                otherCell.swapCheck()
                isTravelInsuranceYesSelected = false
            }
            print("\( cell.isCheckBoxChecked()) aertr")
            cell.swapCheck()
            print("\( cell.isCheckBoxChecked()) aertr")
           
            isTravelInsuranceNoSelected = !isTravelInsuranceNoSelected
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func selectedValue(selectedValue: String, identifier: String) {
        if identifier == "ChangeStationSelector"{
        
            selectedStationValue = selectedValue
            
            print(selectedValue)
            passengerDetailsTableView.reloadSections([1], with: .fade)
        }
    }
    
    func getSelectorValues(identifier: String) -> [String] {
        if identifier == "ChangeStationSelector"{
            return boardingStations
        }
        return []
    }
    
    func getSelectedValue(identifier: String) -> String {
        if identifier == "ChangeStationSelector"{
            return selectedStationValue
        }
        return ""
    }
    
}


extension PassengerDetailsEntryViewController : AddPassengerTableViewCellDelegate  {
    
    func addPassengerButtonClicked() {
        
        let presentVc = NewPassengerAddingViewController(nibName: nil, bundle: nil, coachType: coachType,isVcForUpdating: false)
        presentVc.delegate = self
        presentVc.title = "Add Passenger Details"
        
        let presentingNc = UINavigationController(rootViewController: presentVc)
        
        presentingNc.modalPresentationStyle = .pageSheet
        
       
        
        
        if let sheet = presentingNc.sheetPresentationController{
            sheet.detents = [.medium(),.large()]
            sheet.prefersGrabberVisible = true
        }
        self.present(presentingNc, animated: true)
        
        
    }
    
    func addExistingPassengerButtonClicked() {
        
        
        if !DBManager.getInstance().retrieveSavedPassenger().isEmpty {
            let presentVc = ExistingPassengerViewController()
            
            presentVc.title = "Select Existing Passenger"
            
            presentVc.delegate = self
            
            presentVc.setSelectedPassengers(passengerNumbers: Array(existingPassengerAndItsNumber.keys))
            
            presentVc.setAlreadyEnteredPassenger(alreadyEnteredPassenger: abs(passengersList.count - existingPassengerAndItsNumber.count))
            
            let presentingNc = UINavigationController(rootViewController: presentVc)
            
            presentingNc.modalPresentationStyle = .pageSheet
            
            if let sheet = presentingNc.sheetPresentationController{
                sheet.detents = [.medium()]
                sheet.prefersGrabberVisible = true
            }
            self.present(presentingNc, animated: true)
        }
        
        else {
            let alertController = UIAlertController(title: nil, message: "Passengers List is Empty", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel)
            
            
            alertController.addAction(okButton)
            
            alertController.view.tintColor = .systemGreen
            
            present(alertController, animated: true)
        }
       
        
        
        
    }
    
    
    
    
}

extension PassengerDetailsEntryViewController : NewPassengerAddingViewControllerDelegete{
   
    func passengerInputValues(name: String, age: Int, gender: Gender, berthPreference: String, isToBeUpdated:Bool,passengerNumber:Int?) {
        
        
        if isToBeUpdated {
            passengersList[passengerNumber!] = PassengerDetailsInput(name: name, age: age, gender: gender, seatTypePreference: SeatType(rawValue: berthPreference))
        }
        
        else {
            numberOfPassengers += 1
            
            passengersList.append(PassengerDetailsInput(name: name, age: age, gender: gender, seatTypePreference: SeatType(rawValue: berthPreference)))
        }
        
        passengerDetailsTableView.reloadSections([2], with: .automatic)
    }
    
}


extension PassengerDetailsEntryViewController : PassengerDetailsTableViewCellDelegate {
    
    func deletePassenger(passengerNumber: Int) {
        passengersList.remove(at: passengerNumber-1)
        numberOfPassengers -= 1
        passengerDetailsTableView.reloadSections([2], with: .automatic)
        
        for existingPass in existingPassengerAndItsNumber.keys {
            if existingPassengerAndItsNumber[existingPass] == passengerNumber {
                existingPassengerAndItsNumber.removeValue(forKey: existingPass)
            }
        }
    }
}

extension PassengerDetailsEntryViewController : TextFieldInputTableViewCellDelegate {
    
    
    
    func editingEnded(enteredText: String, identifier: String) {
        
        
        if identifier ==  "Mobile Number" {
            if passengerMobileNumber != enteredText{
                passengerMobileNumber = enteredText
                if enteredText.isEmpty {
                    mobileNumberErrorValue = "Mobile Number Cannot Be Empty"
                }
                else{
                    if !Validator.shared.validateMobileNumber(text: enteredText){
                        mobileNumberErrorValue = """
                            ✷ Mobile Number Should Contain 10 Digit Numbers Only
                            ✷ Mobile Number should start between (6-9)
                            """
                                                
                    }
                    else{
                        mobileNumberErrorValue = ""
                    }
                }
                passengerDetailsTableView.reloadSections([3], with: .automatic)
            }
        
        }
        
        view.removeGestureRecognizer(viewTapGesture!)
        
    }
    
    func startsEditing() {
        viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTapGesture!)
       
    }
    
    
}


extension PassengerDetailsEntryViewController : PrefferedCoachViewControllerDelegate {
    
    func selectedCoachName(coachName: String) {
        preffereCoachNumber = coachName
        
        passengerDetailsTableView.reloadSections([4], with: .automatic)
    }
    
}

extension PassengerDetailsEntryViewController : ExistingPassengerViewControllerDelegate {
    func selectedPassengerNumbers(passengerNumbers: [Int]) {
        
        
        
        let passengers = DBManager.getInstance().retrieveSavedPassenger()
        
        
        print(existingPassengerAndItsNumber)
        
        print(passengersList.count)
        
       
        
        var differenceCount = 1
        
        for deletingPassengers in existingPassengerAndItsNumber.values.sorted(by:{ $0 < $1}) {
            print(deletingPassengers)
            passengersList.remove(at: deletingPassengers - differenceCount)
            differenceCount = differenceCount + 1
        }
        
        existingPassengerAndItsNumber.removeAll()
        
        
        
        for passenger in passengers {
            if passengerNumbers.contains(passenger.passengerNumber) {
                
                if let _ = existingPassengerAndItsNumber[passenger.passengerNumber]{
                    continue
                }
                passengersList.append(PassengerDetailsInput(name: passenger.name, age: passenger.age, gender: passenger.gender, seatTypePreference: passenger.berthPreference))
                
                existingPassengerAndItsNumber[passenger.passengerNumber] = passengersList.count
            }
        }
        
        numberOfPassengers = passengersList.count
        
        passengerDetailsTableView.reloadSections([2], with: .automatic)
    }
}
