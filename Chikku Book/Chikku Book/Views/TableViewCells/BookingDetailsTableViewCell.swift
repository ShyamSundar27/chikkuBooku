//
//  BookingDetailsTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 22/08/22.
//

import UIKit

class BookingDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "BookingDetailsTableViewCell"
    
    let seatAvailabilityLabel : UILabel =  {
        
        let label = UILabel()
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: .callout)
        
        return label
        
    }()
    
    let quotaAndCoachTypeLabel : UILabel =  {
        
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .systemGray5
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
        
    }()
    
    
    
    let pnrNumberLabel  : UILabel =  {
        
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
        
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(seatAvailabilityLabel)
        contentView.addSubview(quotaAndCoachTypeLabel)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelValues(trainSeatAvailability : (bookingTypeAvailable:TicketAvailabilityStatus,numbersAvailable : Int)?, coachType:CoachType, quotaType:QuotaType) {
        
        if let trainSeatAvailability = trainSeatAvailability{
            
            if trainSeatAvailability.bookingTypeAvailable != .NotAvailable  &&   trainSeatAvailability.bookingTypeAvailable != .ChartPrepared
            {
                seatAvailabilityLabel.text = "\(trainSeatAvailability.bookingTypeAvailable.rawValue) - \(trainSeatAvailability.numbersAvailable)"
                
                switch (trainSeatAvailability.bookingTypeAvailable) {
                case .Available :
                    seatAvailabilityLabel.textColor = .systemGreen
                case .ReservationAgainstCancellation :
                    seatAvailabilityLabel.textColor = .systemGreen
                case .WaitingList :
                    seatAvailabilityLabel.textColor = .orange
                default :
                    seatAvailabilityLabel.textColor = .systemRed
                
                }
            }
            
            
        }
        
        else{
            seatAvailabilityLabel.numberOfLines = 0
            seatAvailabilityLabel.text = ""
        }
        
                
            
     
        
        
       
        let coachTypeCode = DBManager.getInstance().getCoachDetails(coachType: coachType)!.coachCode
        
        quotaAndCoachTypeLabel.text = "  \(coachType.rawValue) (\(coachTypeCode)) | \(quotaType.rawValue)  "
        
        setSeatAvailabilityLabelConstraints()
    }
    
    
   
    
    
    func setSeatAvailabilityLabelConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        
        seatAvailabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(seatAvailabilityLabel.topAnchor.constraint(equalTo: contentView.topAnchor))
//        constraints.append(seatAvailabilityLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.5))
        constraints.append(seatAvailabilityLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10))
        constraints.append(seatAvailabilityLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
        
        
        quotaAndCoachTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(quotaAndCoachTypeLabel.topAnchor.constraint(equalTo: seatAvailabilityLabel.bottomAnchor,constant: 10))
        constraints.append(quotaAndCoachTypeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.3))
        constraints.append(quotaAndCoachTypeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        //constraints.append(quotaAndCoachTypeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.5))
        
        
        
        NSLayoutConstraint.activate(constraints)
    }

//    func setPnrConstraints(){
//        var constraints = [NSLayoutConstraint]()
//
//
//        pnrNumberLabel.translatesAutoresizingMaskIntoConstraints = false
//        constraints.append(pnrNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant:  5))
//        constraints.append(pnrNumberLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10))
//        constraints.append(pnrNumberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
//
//
//        quotaAndCoachTypeLabel.translatesAutoresizingMaskIntoConstraints = false
//        constraints.append(quotaAndCoachTypeLabel.topAnchor.constraint(equalTo: seatAvailabilityLabel.bottomAnchor,constant: 5))
//        constraints.append(quotaAndCoachTypeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.3))
//        constraints.append(quotaAndCoachTypeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
//        //constraints.append(quotaAndCoachTypeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.5))
//
//
//
//        NSLayoutConstraint.activate(constraints)
//    }
    
    
}
