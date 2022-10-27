//
//  TrainAvailabilityDetailsTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 09/08/22.
//

import UIKit

class TrainAvailabilityDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "TrainAvailabilityDetailsTableViewCell"
    
    
    let trainAvailabilityDetailsTableView = UITableView()
    
    var train:Train? = nil
    
    var fromStation:(code:String,name:String)? = nil
    
    var toStation:(code:String,name:String)? = nil
    
    var travelStartDate : Date? = nil
    
    var travelEndDate : Date? = nil
    
    var coachType : CoachType? = nil
    
    var seatsAvailableInEachBookingType : [CoachType:SeatAvailableInEachBookingType]? = nil
    
    var fareValues:[CoachType:Float] = [:]
    
    var isExpanded = false
    
    var indexPath : IndexPath? =  nil
    
    var seatAvailabilityForRemainingDays : [Date:SeatAvailableInEachBookingType]? = nil
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        
        trainAvailabilityDetailsTableView.dataSource = self
        trainAvailabilityDetailsTableView.delegate = self
        registerTableViewCells()
        setCellValues()
        setConstraints()
        
    }
    
    func registerTableViewCells(){
        trainAvailabilityDetailsTableView.register(TrainNameDisplayTableViewCell.self, forCellReuseIdentifier: TrainNameDisplayTableViewCell.identifier)
        trainAvailabilityDetailsTableView.register(TrainRunningAndCoachDetailsTableViewCell.self, forCellReuseIdentifier: TrainRunningAndCoachDetailsTableViewCell.identifier)
        trainAvailabilityDetailsTableView.register(SeatAvailabilityDisplayTableViewCell.self, forCellReuseIdentifier: SeatAvailabilityDisplayTableViewCell.identifier)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setCellValues(){
        
        contentView.addSubview(trainAvailabilityDetailsTableView)
        backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        trainAvailabilityDetailsTableView.isScrollEnabled = false
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 1
        contentView.layer.shadowOpacity = 0.25
        
    }
    
    func setValues(train:Train, fromStation:(code:String,name:String), toStation:(code:String,name:String), travelDate: Date, seatsAvailableInEachBookingType: [CoachType:SeatAvailableInEachBookingType],coachType:CoachType,fareValues:[CoachType:Float]){
        
        self.train = train
        self.fromStation = fromStation
        self.toStation = toStation
        self.travelStartDate = travelDate
        self.seatsAvailableInEachBookingType = seatsAvailableInEachBookingType
        self.coachType = coachType
        
        
        let fromStationStoppingNumber = train.getStoppingDetails(stationCode: fromStation.code)!.departureDayOfTheTrain
        let toStationStoppingNumber = train.getStoppingDetails(stationCode: toStation.code)!.arrivalDayOfTheTrain
        let diffInDays = (toStationStoppingNumber - fromStationStoppingNumber)
        self.travelEndDate = travelStartDate!.getDateFor(days: diffInDays )
        self.fareValues = fareValues
        
        
        
        
        
    }
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        
        trainAvailabilityDetailsTableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(trainAvailabilityDetailsTableView.rightAnchor.constraint(equalTo: contentView.rightAnchor))
        constraints.append(trainAvailabilityDetailsTableView.leftAnchor.constraint(equalTo: contentView.leftAnchor))
        constraints.append(trainAvailabilityDetailsTableView.topAnchor.constraint(equalTo: contentView.topAnchor))
        constraints.append(trainAvailabilityDetailsTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
            
       
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0 ))
    }
    
}



extension TrainAvailabilityDetailsTableViewCell: UITableViewDelegate ,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
       
        if isExpanded == true{
            let value : Float = (1.0 + Float(seatAvailabilityForRemainingDays!.count)/5.0)
            

            if indexPath.row == 0 {
               
                return contentView.frame.height/(4.5 * CGFloat(value))
               
            }
            
            if indexPath.row == 1 {
                

                return contentView.frame.height/(2.5 * CGFloat(value))
               
            }
            
            if indexPath.row == 2 {
                print(contentView.frame.height )
                print((contentView.frame.height - contentView.frame.height/(4.5 * CGFloat(value)) - contentView.frame.height/(2.5 * CGFloat(value))))
                print(contentView.frame.height/(4.5 * CGFloat(value)))
                print(contentView.frame.height/(2.5 * CGFloat(value)))
                return (contentView.frame.height - contentView.frame.height/(4.5 * CGFloat(value)) - contentView.frame.height/(2.5 * CGFloat(value)))
            }
            
        }
        else{
            if indexPath.row == 0 {
                
                return contentView.frame.height/4.5
            }
            
            if indexPath.row == 1 {
                
                return contentView.frame.height/2.5
            }
            
            if indexPath.row == 2 {
                //return contentView.frame.height/(1.5)
                return contentView.frame.height - contentView.frame.height/2.5 - contentView.frame.height/4.5
            }
        }
        print(UITableView.automaticDimension)
        return UITableView.automaticDimension
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seatsAvailableInEachBookingType = [:]
        
    }
    
    
}

//extension TrainAvailabilityDetailsTableViewCell : SeatAvailabilityDisplayTableViewCellDelegate{
//    
//    func presentCoachSeatAvailabilityForRemainingDays(coachType: CoachType) {
//        
//        
//        delegate?.presentCoachAndSeatAvailabilityDetails(coachType: coachType, train: train!,indexPath:indexPath!)
//        print("presentCoachSeatAvailabilityForRemainingDays \(indexPath!.row)")
//        
//    }
//}
