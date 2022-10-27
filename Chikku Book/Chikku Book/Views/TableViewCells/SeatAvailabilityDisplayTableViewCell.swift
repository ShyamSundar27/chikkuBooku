//
//  SeatAvailabilityDisplayTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 17/08/22.
//

import UIKit

class SeatAvailabilityDisplayTableViewCell: UITableViewCell {
    
    static let identifier = "SeatAvailabilityDisplayTableViewCell"
    
    weak var delegate : SeatAvailabilityDisplayTableViewCellDelegate? = nil
    
    var seatsAvailableInEachBookingType : [CoachType:SeatAvailableInEachBookingType] = [:]
    
    
    var seatAvailabilityCollectionView : UICollectionView? = nil
    
    let seatAvailabilityCollectionViewLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()

   
    
    var coachTypes = [CoachType]()
    
    var fareInEachType : [CoachType:Float] = [:]
    
    var trainSeatAvailabilityValues: [(coachCode:String,bookingTypeAvailable:TicketAvailabilityStatus,numbersAvailable :Int,fare:Float)] = []

    var coachTypesSegmentedControl : UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    var presentSegmentedControl : Bool = false

    var presentCollectionView = false
    
    var selectedSegmentedIndexCoachType : CoachType? = nil
    
    
    var indexPath : IndexPath? = nil
    
    
    
    
    func setDetails() {
        

        
        
                
        if presentCollectionView {
            setTrainSeatAvailabilityValues()

            
            seatAvailabilityCollectionViewLayout.itemSize = CGSize(width: 100, height: 50)
            print("cllayout")
            print((width: contentView.frame.width/3.2, contentView: contentView.frame.height/1.5))
            seatAvailabilityCollectionViewLayout.scrollDirection = .horizontal
            seatAvailabilityCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: seatAvailabilityCollectionViewLayout)
            seatAvailabilityCollectionView!.delegate = self
            seatAvailabilityCollectionView!.dataSource = self
            seatAvailabilityCollectionView!.register(AvailabilityDisplayCollectionViewCell.self, forCellWithReuseIdentifier: AvailabilityDisplayCollectionViewCell.identifier)
            seatAvailabilityCollectionView!.showsHorizontalScrollIndicator = false
            //seatAvailabilityCollectionView?.backgroundColor = .secondarySystemBackground

            contentView.addSubview(seatAvailabilityCollectionView!)
        }
        
        if presentSegmentedControl {
            setSegmentedControlValues()
            contentView.addSubview(coachTypesSegmentedControl)
            
            coachTypesSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
            //contentView.addSubview(seatAvailabilityForFurtherTableView)
            coachTypesSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        }
        setConstraints()
       
    }
    
    
    func setConstraints() {
        
        
        var constraints = [NSLayoutConstraint]()
        
        if presentCollectionView {
            print ("hi inside constraints setter of seat avilability collection view")
            seatAvailabilityCollectionView!.translatesAutoresizingMaskIntoConstraints = false
            
            constraints.append(seatAvailabilityCollectionView!.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5))
            constraints.append(seatAvailabilityCollectionView!.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -5))
            constraints.append(seatAvailabilityCollectionView!.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 9))
            
            constraints.append(seatAvailabilityCollectionView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -9 ))
        }
        
        
        if presentSegmentedControl {
            print ("hi inside constraints setter of segmented view")

            coachTypesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false

            constraints.append(coachTypesSegmentedControl.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 3))
            constraints.append(coachTypesSegmentedControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
            constraints.append(coachTypesSegmentedControl.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75))
            constraints.append(coachTypesSegmentedControl.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier:  0.15 * CGFloat(coachTypes.count )))
            

                    
        }
        
        NSLayoutConstraint.activate(constraints)
        constraints.removeAll()
    }
    
    
    
    func setSegmentedControlValues(){
       
        var segmentedValuesString = [String]()
        
        var selectedSegmentCoachCode = ""
        
        for coachType in coachTypes {
            let coachCode = DBManager.getInstance().getCoachTypeDetails(coachType: coachType)!.coachCode
            if coachType == selectedSegmentedIndexCoachType{
                selectedSegmentCoachCode = coachCode
            }
            segmentedValuesString.append(coachCode)
        }
        
        let coachIndex = segmentedValuesString.firstIndex(of: selectedSegmentCoachCode)
        
        
        coachTypesSegmentedControl  = UISegmentedControl(items: segmentedValuesString)
        coachTypesSegmentedControl.selectedSegmentIndex = coachIndex!
        
        
        coachTypesSegmentedControl.selectedSegmentTintColor = .systemGreen
        coachTypesSegmentedControl.apportionsSegmentWidthsByContent = true
        coachTypesSegmentedControl.sizeToFit()
        
        
    }
    

    func setValuesOfCell(seatsAvailableInEachBookingType :[CoachType:SeatAvailableInEachBookingType], coachType :CoachType, fareValues : [CoachType:Float]){
        self.seatsAvailableInEachBookingType = seatsAvailableInEachBookingType
        
        self.coachTypes = Array(seatsAvailableInEachBookingType.keys)
        
        coachTypes = coachTypes.sorted(by: {$0.rawValue<$1.rawValue})
        if let coachIndex = coachTypes.firstIndex(of: coachType){
            coachTypes.remove(at: coachIndex)
            coachTypes.insert(coachType, at: 0)
        }
        self.fareInEachType =  fareValues
    }
    
    func setTrainSeatAvailabilityValues(){
        var values : (coachCode:String,bookingTypeAvailable:TicketAvailabilityStatus,numbersAvailable :Int,fare:Float)
        trainSeatAvailabilityValues = []
        for coachType in coachTypes {
            
            values.coachCode = DBManager.getInstance().getCoachTypeDetails(coachType: coachType)!.coachCode
            values.fare = fareInEachType[coachType]!
            
            if seatsAvailableInEachBookingType[coachType]!.seatsAvailable > 0 {
                values.numbersAvailable = seatsAvailableInEachBookingType[coachType]!.seatsAvailable
                values.bookingTypeAvailable = .Available
            }
            else if seatsAvailableInEachBookingType[coachType]!.racSeatsAvailable > 0{
                values.numbersAvailable = seatsAvailableInEachBookingType[coachType]!.racSeatsBooked + 1
                values.bookingTypeAvailable = .ReservationAgainstCancellation
            }
            else if seatsAvailableInEachBookingType[coachType]!.wlSeatsAvailable > 0{
                values.numbersAvailable = seatsAvailableInEachBookingType[coachType]!.wlSeatsBooked + 1
                values.bookingTypeAvailable = .WaitingList
            }
            else if seatsAvailableInEachBookingType[coachType]!.wlSeatsAvailable == 0 {
                values.numbersAvailable = 0
                values.bookingTypeAvailable = .NotAvailable
            }
            else  {
                values.numbersAvailable = 0
                values.bookingTypeAvailable = .ChartPrepared
            }
            
            
           
            trainSeatAvailabilityValues.append(values)
           
        }
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trainSeatAvailabilityValues = []
        if let seatAvailabilityCollectionView = seatAvailabilityCollectionView {
            seatAvailabilityCollectionView.removeFromSuperview()
        }
        
        coachTypesSegmentedControl.removeFromSuperview()
        
        seatAvailabilityCollectionView = nil
        
    }
    
}



extension SeatAvailabilityDisplayTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trainSeatAvailabilityValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvailabilityDisplayCollectionViewCell.identifier, for: indexPath) as! AvailabilityDisplayCollectionViewCell
                
        cell.backgroundColor = .systemGray6.withAlphaComponent(1)
        cell.layer.cornerRadius = 5
        cell.setLabelValues(labelValues: trainSeatAvailabilityValues[indexPath.row])
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coachType : CoachType = getCoachType(coachCode: trainSeatAvailabilityValues[indexPath.row].coachCode)
        
        
        
        delegate!.presentCoachSeatAvailabilityForRemainingDays(coachType: coachType,indexPath:  self.indexPath!)
    }
    
    func getCoachType (coachCode:String)-> CoachType{
        switch coachCode{
        case "SL":
            return .SleeperClass
            
        case "2S":
            return .SecondSeaterClass
            
        case "1A":
            return .AirConditioned1TierClass
            
        case "2A":
            return .AirConditioned2TierClass
            
        case "3A":
            return .AirConditioned3TierClass
            
        case "CC":
            return .AirConditionedChaiCarClass
            
        case "EC":
            return .ExecutiveChairCarClass
            
        default:
            return .SleeperClass
        }
    }
    
    
    @objc func segmentedControlValueChanged (_ sender: UISegmentedControl){
        
        delegate!.presentCoachSeatAvailabilityForRemainingDays(coachType: coachTypes[sender.selectedSegmentIndex],indexPath:  self.indexPath!)
        
    }
    
    
    
}


