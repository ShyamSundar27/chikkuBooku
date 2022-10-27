//
//  RemainingDaysSeatAvailabilityTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 18/08/22.
//

import UIKit

class RemainingDaysSeatAvailabilityTableViewCell: UITableViewCell {

    static let identifier = "SeatAvailabilityForRemainingDaysTableViewCell"
     
    let dateLabel = UILabel()
     
    let availableSeatsLabel = UILabel()
     
    let bookLabel = UILabel()
    
    let fareLabel = UILabel()
     
    var bookButton = UIButton()
    
    var bookingDate : Date? = nil
    
    weak var delegate : RemainingDaysSeatAvailabilityTableViewCellDelegate? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(availableSeatsLabel)
        contentView.addSubview(bookButton)
        contentView.addSubview(dateLabel)
        bookButton.addSubview(bookLabel)
        bookButton.addSubview(fareLabel)
        
        
        
        setButtonConstraints()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonConstraints(){
        //bookButton.backgroundColor = .systemGreen
        bookButton.layer.borderColor = UIColor.systemGreen.cgColor
        bookButton.backgroundColor = .systemGreen
        bookButton.layer.borderWidth = 1
        bookButton.layer.cornerRadius = 5
        bookButton.addTarget(self, action: #selector(bookButtonPressed), for: .touchUpInside)
    }
    
    
    @objc func bookButtonPressed(){
        
        print(bookingDate!.toString(format: "E, d MMM"))
        delegate?.bookingButtonPressed(bookingDate: bookingDate!)
        
    }
    
    
    func setLabelValues(remainingDateSeatAvailability : (date:Date, bookingTypeAvailable:TicketAvailabilityStatus ,numbersAvailable :Int, fare:Float)){
        
        
        bookingDate = remainingDateSeatAvailability.date
        
        let dateString =  remainingDateSeatAvailability.date.toString(format: "E, d MMM")
        
        let seatAvailabilityString = "\(remainingDateSeatAvailability.bookingTypeAvailable.rawValue) -\(remainingDateSeatAvailability.numbersAvailable)"
        
        let fareString = "₹ \(remainingDateSeatAvailability.fare)"
        
        
        print(dateString)
        print(seatAvailabilityString)
        print(fareString)
       
        dateLabel.text = dateString
        dateLabel.font = .systemFont(ofSize: 14)
        availableSeatsLabel.text = seatAvailabilityString
        availableSeatsLabel.font = .systemFont(ofSize: 14)
        bookLabel.text = "Book"
        bookLabel.textAlignment = .center
        bookLabel.font = .systemFont(ofSize: 12)
        bookLabel.textColor = .white
        fareLabel.text = fareString
        fareLabel.textAlignment = .center
        fareLabel.textColor = .white
        fareLabel.font = .systemFont(ofSize: 13)
        bookButton.isEnabled = true
        
        if remainingDateSeatAvailability.bookingTypeAvailable != .NotAvailable  &&   remainingDateSeatAvailability.bookingTypeAvailable != .ChartPrepared
        {
            availableSeatsLabel.text = "\(remainingDateSeatAvailability.bookingTypeAvailable.rawValue) - \(remainingDateSeatAvailability.numbersAvailable)"
            
            switch (remainingDateSeatAvailability.bookingTypeAvailable) {
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
            availableSeatsLabel.text = "\(remainingDateSeatAvailability.bookingTypeAvailable.rawValue)"
            availableSeatsLabel.textColor = .systemRed
            bookButton.alpha = 0.3
            bookButton.isEnabled = false
            
           
        }
        
        if remainingDateSeatAvailability.bookingTypeAvailable == .ChartPrepared {
            availableSeatsLabel.font = .systemFont(ofSize: 12)
        }
        
        
    }
    
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5))
        constraints.append(dateLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.35))
        constraints.append(dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(dateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.9))
        
        availableSeatsLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(availableSeatsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        constraints.append(availableSeatsLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.4))
        constraints.append(availableSeatsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(availableSeatsLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.9))
        
        bookButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(bookButton.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10))
        constraints.append(bookButton.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.25))
        constraints.append(bookButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(bookButton.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.8))
        
        bookLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(bookLabel.centerXAnchor.constraint(equalTo: bookButton.centerXAnchor))
        constraints.append(bookLabel.widthAnchor.constraint(equalTo: bookButton.widthAnchor,multiplier: 0.8))
        constraints.append(bookLabel.topAnchor.constraint(equalTo: bookButton.topAnchor,constant: 2))
        constraints.append(bookLabel.heightAnchor.constraint(equalTo: bookButton.heightAnchor,multiplier: 0.4))
        
        fareLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(fareLabel.centerXAnchor.constraint(equalTo: bookButton.centerXAnchor))
        constraints.append(fareLabel.widthAnchor.constraint(equalTo: bookButton.widthAnchor,multiplier: 0.8))
        constraints.append(fareLabel.topAnchor.constraint(equalTo: bookLabel.bottomAnchor))
        constraints.append(fareLabel.heightAnchor.constraint(equalTo: bookButton.heightAnchor,multiplier: 0.6))
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookButton.alpha = 1
        bookButton.isEnabled = true
    }
    
}
