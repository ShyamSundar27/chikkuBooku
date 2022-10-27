//
//  AvailabilityDisplayCollectionViewCell.swift
//  Chikku Book
//
//  Created by shyam-15059 on 19/09/22.
//

import UIKit

class AvailabilityDisplayCollectionViewCell: UICollectionViewCell {
    static let identifier = "AvailabilityDisplayCollectionViewCell"
    
    let coachCodeLabel = UILabel()
    
    let fareLabel  = UILabel()
    
    let availableSeatsLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(coachCodeLabel)
        contentView.addSubview(fareLabel)
        contentView.addSubview(availableSeatsLabel)
        
        setConstraints()
    }
    
    func setLabelValues(labelValues : (coachCode:String,bookingTypeAvailable:TicketAvailabilityStatus,numbersAvailable :Int,fare:Float)){
        
        if labelValues.bookingTypeAvailable != .NotAvailable &&   labelValues.bookingTypeAvailable != .ChartPrepared {
            availableSeatsLabel.text = "\(labelValues.bookingTypeAvailable.rawValue) - \(labelValues.numbersAvailable)"
               
            switch (labelValues.bookingTypeAvailable) {
            case .Available :
                availableSeatsLabel.textColor = .systemGreen
            case .ReservationAgainstCancellation :
                availableSeatsLabel.textColor = .systemGreen
            case .WaitingList :
                availableSeatsLabel.textColor = .orange
            default :
                availableSeatsLabel.textColor = .systemRed
            
            }
        }
        else{
            availableSeatsLabel.text = "\(labelValues.bookingTypeAvailable.rawValue)"
            availableSeatsLabel.textColor = .systemRed

        }
        
        availableSeatsLabel.font = .systemFont(ofSize: 15)
        fareLabel.text = "₹ \(labelValues.fare)"
        fareLabel.font = .systemFont(ofSize: 14)
        fareLabel.textAlignment = .right
        coachCodeLabel.text = labelValues.coachCode
        coachCodeLabel.font = .systemFont(ofSize: 14)
        
        if labelValues.bookingTypeAvailable == .ChartPrepared {
            availableSeatsLabel.font = .systemFont(ofSize: 10)
        }
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        coachCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(coachCodeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 3))
        constraints.append(coachCodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 4))
        constraints.append(coachCodeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.3))
        constraints.append(coachCodeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.3))
        
        fareLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(fareLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -3))
        constraints.append(fareLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 4))
        constraints.append(fareLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.65))
        constraints.append(fareLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.3))
        
        availableSeatsLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(availableSeatsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 3))
        constraints.append(availableSeatsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -4))
        constraints.append(availableSeatsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.95))
        constraints.append(availableSeatsLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.4))
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
