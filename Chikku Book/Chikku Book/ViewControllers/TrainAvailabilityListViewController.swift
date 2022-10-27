//
//  TrainAvailabilityListViewController.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 09/08/22.
//

import UIKit

class TrainAvailabilityListViewController: UIViewController {
    
    
    
    
    var trainAvailabilityDetailsTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let ticketCounter : TicketCounter = TicketCounter()
    
    var trainsRunningList : [Train] = []
    
    var fromStationName : (code:String,name:String)
    
    var toStationName : (code:String,name:String)
    
    var travelDate : Date
    
    var quotaType : QuotaType
    
    var coachType : CoachType
    
    var fareValues : [CoachType:Float] = [:]
    
    var seatsAvailableInEachBookingTypeInEachTrain : [Int:[CoachType:SeatAvailableInEachBookingType]] = [:]
    
    //var isViewPresented = false
    
    var coachTypeCurrentlySelected : CoachType? = nil
    
    var seatAvailableForRemainingDays: [Date:SeatAvailableInEachBookingType] = [:]
    
    
    var remainingDateSeatAvailability :[(date:Date, bookingTypeAvailable:TicketAvailabilityStatus ,numbersAvailable :Int, fare:Float)] = []
    
    var currentlyPresenting : IndexPath? = nil
    
    var trainCurrentlySelected : Train? = nil
    
    var noSearchesLabel  = UILabel()
    
    var spinner : UIActivityIndicatorView? = UIActivityIndicatorView(style: .large)
    
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?,fromStationName:(code:String,name:String),toStationName:(code:String,name:String),travelDate:Date,quotaType : QuotaType,coachType : CoachType) {
        
        self.fromStationName = fromStationName
        
        self.toStationName = toStationName
        
        self.travelDate = travelDate
        
        self.quotaType = quotaType
        
        self.coachType = coachType
        
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (fromStationName:(code:String,name:String),toStationName:(code:String,name:String),travelDate:Date,quotaType : QuotaType,coachType : CoachType){
        
        self.init(nibName: nil, bundle: nil, fromStationName:fromStationName, toStationName:toStationName , travelDate:travelDate, quotaType : quotaType, coachType : coachType)
        
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
    
        registerTableViewCells()
        trainAvailabilityDetailsTableView.delegate = self
        trainAvailabilityDetailsTableView.dataSource = self
        trainAvailabilityDetailsTableView.allowsSelection = false
        
        
//        setActivityIndicator()
        
        view.addSubview(trainAvailabilityDetailsTableView)
        setConstraints()
        
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonClicked))
        trainAvailabilityDetailsTableView.backgroundColor = .secondarySystemBackground
        
        
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if trainsRunningList.isEmpty{
            setValues()
            trainAvailabilityDetailsTableView.reloadData()
        }
        
        

    }
    
    
    func setActivityIndicator(){
        
        
       
        
        
        
        
        
    }
    func setValues(){
        
        
        self.setTableDefaultValues()
       
//        spinner?.stopAnimating()
//        trainAvailabilityDetailsTableView.backgroundView = nil
        spinner = nil
            
      
        
    }
    
    func registerTableViewCells(){
        trainAvailabilityDetailsTableView.register(TrainNameDisplayTableViewCell.self, forCellReuseIdentifier: TrainNameDisplayTableViewCell.identifier)
        trainAvailabilityDetailsTableView.register(TrainRunningAndCoachDetailsTableViewCell.self, forCellReuseIdentifier: TrainRunningAndCoachDetailsTableViewCell.identifier)
        trainAvailabilityDetailsTableView.register(SeatAvailabilityDisplayTableViewCell.self, forCellReuseIdentifier: SeatAvailabilityDisplayTableViewCell.identifier)
        trainAvailabilityDetailsTableView.register(RemainingDaysSeatAvailabilityTableViewCell.self, forCellReuseIdentifier: RemainingDaysSeatAvailabilityTableViewCell.identifier)
        trainAvailabilityDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        trainAvailabilityDetailsTableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(trainAvailabilityDetailsTableView.rightAnchor.constraint(equalTo: view.rightAnchor))
        constraints.append(trainAvailabilityDetailsTableView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(trainAvailabilityDetailsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(trainAvailabilityDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    func setTableDefaultValues() {
        
        let ticketCounter = TicketCounter()

        
        trainsRunningList = ticketCounter.trainListForUserInput(quotatype: quotaType, travelDate: travelDate, fromStation: fromStationName.name, toStation: toStationName.name, coachType: coachType)
        
        trainsRunningList = rearrangeAccordingToCoachType(trainList: trainsRunningList, coachType: coachType)
        
        for train in trainsRunningList {
            
            seatsAvailableInEachBookingTypeInEachTrain[train.trainNumber] = [:]
            let coachTypesAvailable = train.getCoachTypes()
            let todayDate = Date().localDate()
            
            var  calendar = Calendar.current
            calendar.timeZone = TimeZone(abbreviation: "UTC")!
            let travelDateComparesion : ComparisonResult = calendar.compare(todayDate, to: travelDate, toGranularity: .day)
            
            for coachType in coachTypesAvailable{
                var listAvailableInEachBookingType : SeatAvailableInEachBookingType
                
                if travelDateComparesion == .orderedSame &&  todayDate.timeOfDayInterval(toDate:train.getStoppingDetails(stationCode: fromStationName.code)!.arrivalTime ) < 7200{
                    
                    listAvailableInEachBookingType = SeatAvailableInEachBookingType(seatsAvailable: 0, racSeatsAvailable: 0, racSeatsBooked: 0, wlSeatsAvailable: -1, wlSeatsBooked: 0)
                }
                else{
                    listAvailableInEachBookingType = ticketCounter.getSeatAvailabilityInEachBookingType(trainNumber: train.trainNumber, travelDate: travelDate, fromStation: fromStationName.name, toStation: toStationName.name, quotatype: quotaType, coachType: coachType)
                }
                
                seatsAvailableInEachBookingTypeInEachTrain[train.trainNumber]![coachType] = listAvailableInEachBookingType
                
                
               
                fareValues[coachType] = ticketCounter.fareCalculator(fromStationCode: fromStationName.code, toStationCode: toStationName.code, train: train , coachType: coachType, quotaType: quotaType, numberOfPassengers: 1,isTravelInsuranceOpt: false ,isOnlyFareNeeded: true)
                        
            }
        }
        
    }
       
    func getValuesForRemainingDays (coachType: CoachType, train: Train ){
        
        remainingDateSeatAvailability.removeAll()
        let maxDate = Date().localDate().getDateFor(days: 7)!
        var dayCount = 0
        
        while remainingDateSeatAvailability.count < 5 {
            
            let dateCount = travelDate.getDateFor(days: dayCount)!
            print("\(remainingDateSeatAvailability.count )")
            let trainList = ticketCounter.trainListForUserInput(quotatype: quotaType, travelDate:dateCount, fromStation: fromStationName.name, toStation: toStationName.name, coachType: coachType)
            var isTrainAvailable = false
            for trainCount in trainList {
                if trainCount.trainNumber == train.trainNumber{
                    isTrainAvailable = true
                }
                
            }
            if !isTrainAvailable{
                dayCount += 1
                continue
            }
            
            var  calendar = Calendar.current
            calendar.timeZone = TimeZone(abbreviation: "UTC")!
            let travelDateComparesion : ComparisonResult = calendar.compare(maxDate, to: dateCount, toGranularity: .day)
            
            let todayDateComparison : ComparisonResult = calendar.compare(Date().localDate(), to: dateCount, toGranularity: .day)
           
            print("traion num = \(train.trainNumber)")
            if train.trainNumber == 12335 {
                print("\(todayDateComparison == .orderedSame) && \(dateCount.timeOfDayInterval(toDate:train.getStoppingDetails(stationCode: fromStationName.code)!.arrivalTime )),  \(travelDate.toString(format:" HH:mm"))")
                print("dateCount \(dateCount)")
            }
           
            
            if todayDateComparison == .orderedSame && dateCount.timeOfDayInterval(toDate:train.getStoppingDetails(stationCode: fromStationName.code)!.arrivalTime ) < 7200{
                
               
                
                print("Hi inside ordered same")
                
                
               let  listAvailableInEachBookingType = SeatAvailableInEachBookingType.init(seatsAvailable: 0, racSeatsAvailable: 0, racSeatsBooked: 0, wlSeatsAvailable: -1, wlSeatsBooked: 0)
                
                //seatAvailableForRemainingDays[dateCount.getDateFor(days: dayCount)!] = listAvailableInEachBookingType
                
                remainingDateSeatAvailability.append(setTrainSeatAvailabilityValues (coachType: coachType, date: dateCount, seatsAvailableInEachBookingType: listAvailableInEachBookingType))
                
            }
            else if travelDateComparesion != .orderedAscending {
                        
                let listAvailableInEachBookingType = ticketCounter.getSeatAvailabilityInEachBookingType(trainNumber: train.trainNumber, travelDate: dateCount, fromStation: fromStationName.name, toStation: toStationName.name, quotatype: quotaType, coachType: coachType)
                        
                //seatAvailableForRemainingDays[dateCount.getDateFor(days: dayCount)!] = listAvailableInEachBookingType
                        
                remainingDateSeatAvailability.append(setTrainSeatAvailabilityValues (coachType: coachType, date: dateCount, seatsAvailableInEachBookingType: listAvailableInEachBookingType))

            }
            
            else {
                dayCount += 1
                break
            }
            dayCount += 1
        }
        
    }
    func setTrainSeatAvailabilityValues(coachType:CoachType , date:Date, seatsAvailableInEachBookingType: SeatAvailableInEachBookingType ) -> (date:Date, bookingTypeAvailable:TicketAvailabilityStatus ,numbersAvailable :Int, fare:Float){
        
        var values : (date:Date,bookingTypeAvailable:TicketAvailabilityStatus,numbersAvailable :Int,fare:Float)
        
        
            
            values.fare = fareValues[coachType]!
            values.date = date
            
            if seatsAvailableInEachBookingType .seatsAvailable > 0 {
                values.numbersAvailable = seatsAvailableInEachBookingType.seatsAvailable
                values.bookingTypeAvailable = .Available
            }
        
            else if seatsAvailableInEachBookingType.racSeatsAvailable > 0{
                values.numbersAvailable = seatsAvailableInEachBookingType.racSeatsBooked + 1
                values.bookingTypeAvailable = .ReservationAgainstCancellation
            }
        
            else if seatsAvailableInEachBookingType.wlSeatsAvailable > 0{
                values.numbersAvailable = seatsAvailableInEachBookingType.wlSeatsBooked + 1
                values.bookingTypeAvailable = .WaitingList
            }
            else if seatsAvailableInEachBookingType.wlSeatsAvailable == 0 {
                values.numbersAvailable = 0
                values.bookingTypeAvailable = .NotAvailable
            }
            else{
                values.numbersAvailable = 0
                values.bookingTypeAvailable = .ChartPrepared
            }
            
           return values
     
    }

    func rearrangeAccordingToCoachType(trainList:[Train],coachType:CoachType) -> [Train]{
        
        var trainListCopy = trainList
    
    
        for trainIndexCount in 0..<trainList.count {
            let isCoachTypeAvailable = trainList[trainIndexCount].isCoachTypeAvilable(coachType: coachType)
            
            if isCoachTypeAvailable {
                let element  = trainListCopy.remove(at: trainIndexCount)
                trainListCopy.insert(element, at: 0)
            }
        }
       
        return trainListCopy
        
    }

    
}

extension TrainAvailabilityListViewController : UITableViewDelegate,UITableViewDataSource,TrainAvailabilityListViewControllerDelegate{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == currentlyPresenting?.section{
            if remainingDateSeatAvailability.isEmpty{
                
                return 4
            }
            return 3 + remainingDateSeatAvailability.count
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: TrainNameDisplayTableViewCell.identifier, for: indexPath) as! TrainNameDisplayTableViewCell
        
            cell.backgroundColor = .systemBackground
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            cell.selectionStyle = .none
            cell.setTrainNameAndNumberLabelText(trainNumber: trainsRunningList[indexPath.section].trainNumber, trainName: trainsRunningList[indexPath.section].trainName)
        
            return cell
            
        }
        
        if indexPath.row == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TrainRunningAndCoachDetailsTableViewCell.identifier, for: indexPath) as! TrainRunningAndCoachDetailsTableViewCell
            
            cell.backgroundColor = .systemBackground
            let fromStationStoppingNumber = trainsRunningList[indexPath.section].getStoppingDetails(stationCode: fromStationName.code)!.departureDayOfTheTrain
            let toStationStoppingNumber = trainsRunningList[indexPath.section].getStoppingDetails(stationCode: toStationName.code)!.arrivalDayOfTheTrain
            let diffInDays = (toStationStoppingNumber - fromStationStoppingNumber)
            let travelEndDate = travelDate.getDateFor(days: diffInDays )
            
            
            let fromStationStoppingDetails = trainsRunningList[indexPath.section].getStoppingDetails(stationCode: fromStationName.code)!
            let toStationStoppingDetails = trainsRunningList[indexPath.section].getStoppingDetails(stationCode: toStationName.code)!
            
            cell.setValuesOfView(fromStationNameAndCode: fromStationName, toStationNameAndCode: toStationName, fromStationDepTime: fromStationStoppingDetails.departureTime, toStationArrTime: toStationStoppingDetails.arrivalTime,travelStartDate: travelDate,travelEndDate:travelEndDate!,startStationDayOfTravel: fromStationStoppingDetails.departureDayOfTheTrain,endStationDayOfTravel: toStationStoppingDetails.arrivalDayOfTheTrain)
            
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            cell.selectionStyle = .none
            
           
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SeatAvailabilityDisplayTableViewCell.identifier, for: indexPath) as! SeatAvailabilityDisplayTableViewCell
            cell.setValuesOfCell(seatsAvailableInEachBookingType: seatsAvailableInEachBookingTypeInEachTrain[trainsRunningList[indexPath.section].trainNumber]!, coachType: coachType, fareValues: fareValues)
            cell.presentCollectionView = true
            cell.presentSegmentedControl = false
            cell.indexPath = indexPath
            cell.backgroundColor = .systemBackground
            if currentlyPresenting == indexPath {
                cell.presentSegmentedControl = true
                cell.presentCollectionView = false
                cell.selectedSegmentedIndexCoachType = coachTypeCurrentlySelected
                
            }
            cell.setDetails()
            cell.delegate = self

            cell.separatorInset = UIEdgeInsets(top: 0, left: self.view.frame.width + 1000, bottom: 0, right: -100)
            return cell
        }
//        if remainingDateSeatAvailability.isEmpty {
//            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//            cell.addSubview(UIActivityIndicatorView())
//            cell.textLabel?.text = "Shyam"
//            return cell
//            
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: RemainingDaysSeatAvailabilityTableViewCell.identifier, for: indexPath) as! RemainingDaysSeatAvailabilityTableViewCell
        
        cell.setLabelValues(remainingDateSeatAvailability: remainingDateSeatAvailability[indexPath.row - 3])
        cell.backgroundColor = .systemBackground
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.delegate = self
        
        
        return cell
    
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if trainsRunningList.isEmpty && spinner == nil{
            
            
                
            noSearchesLabel.text = "No Results Found"
            noSearchesLabel.textColor = .systemGray
            tableView.backgroundView = noSearchesLabel
            noSearchesLabel.textAlignment = .center
            var constraints = [NSLayoutConstraint]()
            
            noSearchesLabel.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(noSearchesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor))
            constraints.append(noSearchesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
            
            NSLayoutConstraint.activate(constraints)
                    
            
            
            return 0
        }
        
        else if trainsRunningList.isEmpty && spinner != nil {
            
            trainAvailabilityDetailsTableView.backgroundView = spinner!
            spinner!.startAnimating()
            spinner!.translatesAutoresizingMaskIntoConstraints = false
            trainAvailabilityDetailsTableView.backgroundView = spinner!
            spinner!.centerXAnchor.constraint(equalTo: trainAvailabilityDetailsTableView.centerXAnchor).isActive = true
            spinner!.centerYAnchor.constraint(equalTo: trainAvailabilityDetailsTableView.centerYAnchor).isActive = true
            spinner!.widthAnchor.constraint(equalTo: trainAvailabilityDetailsTableView.widthAnchor).isActive = true
            spinner!.heightAnchor.constraint(equalTo: trainAvailabilityDetailsTableView.heightAnchor).isActive = true
            
            return 0 
        }
        tableView.backgroundView = nil
        return trainsRunningList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        if indexPath.row == 0 {
            //return self.view.frame.height/20
            return UITableView.automaticDimension

        }
        else if indexPath.row == 1 {
            //return self.view.frame.height/12
            return UITableView.automaticDimension

        }
       // else
        if indexPath.row == 2{
            if currentlyPresenting == indexPath {
                return self.view.frame.height/16
            }
            return 70
            
        }
        
        if remainingDateSeatAvailability.isEmpty{
            return 45
        }
        
        
        print("self.view.frame.height/18 \(self.view.frame.height/18)")
 
        return 45
    }
    
    
    
}




extension TrainAvailabilityListViewController :SeatAvailabilityDisplayTableViewCellDelegate ,RemainingDaysSeatAvailabilityTableViewCellDelegate{
    func presentCoachSeatAvailabilityForRemainingDays(coachType: CoachType,indexPath :IndexPath) {
        
        let train = trainsRunningList[indexPath.section]
        
        let currentlyPresentingSection : Int? = currentlyPresenting?.section
        currentlyPresenting = indexPath
        coachTypeCurrentlySelected = coachType
        trainCurrentlySelected = train
        remainingDateSeatAvailability.removeAll()
        //trainAvailabilityDetailsTableView.reloadData()
        print(remainingDateSeatAvailability.count)
        getValuesForRemainingDays(coachType: coachType,train: train)
        
        trainAvailabilityDetailsTableView.reloadData()
        
        
        
        if currentlyPresentingSection == nil {
            trainAvailabilityDetailsTableView.scrollToRow(at: IndexPath(row: 2 + remainingDateSeatAvailability.count , section: indexPath.section), at: .bottom, animated: true)
        }
        
        else {
            if currentlyPresentingSection != indexPath.section {
                trainAvailabilityDetailsTableView.scrollToRow(at: IndexPath(row: 2 + remainingDateSeatAvailability.count , section: indexPath.section), at: .bottom, animated: true)
            }
        }
        
        
//        trainAvailabilityDetailsTableView.scrollToRow(at: IndexPath(row: 2 + remainingDateSeatAvailability.count , section: indexPath.section), at: .bottom, animated: true)
        
        
       
    }
    
    func bookingButtonPressed(bookingDate: Date) {
        
        print("Hi bro pressed")
        let passengerDetailsVc = PassengerDetailsEntryViewController(fromStationName: fromStationName, toStationName: toStationName, travelDate: bookingDate, quotaType: quotaType, coachType: coachTypeCurrentlySelected!, train: trainCurrentlySelected!)
         
        navigationController?.pushViewController(passengerDetailsVc, animated: true)
        
    }
}


