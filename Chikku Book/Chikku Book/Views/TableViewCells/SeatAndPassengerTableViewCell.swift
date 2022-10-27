//
//  SeatAndPAssengerTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 05/09/22.
//

import UIKit

class SeatAndPassengerTableViewCell: UITableViewCell {
    
    
    static let identifier = "SeatAndPassengerTableViewCell"
    
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    let genderAgeLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray
        return label
    }()
    
    let ticketStatusNameLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray
        label.text = "Ticket Status"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let ticketStatusLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textAlignment = .center
        return label
    }()
    
    let seatNumberNameLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray

        label.text = "Seat Number"
        return label
    }()
    
    let seatNumberLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    let seatTypeNameLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray
        label.text = "Seat Type"
        return label
    }()
    
    let seatTypeLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    let coachTypeNameLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray

        label.text = "Coach"
        return label
    }()
    let coachTypeLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderAgeLabel)
        contentView.addSubview(seatTypeLabel)
        contentView.addSubview(seatNumberLabel)
        contentView.addSubview(coachTypeLabel)
        contentView.addSubview(ticketStatusLabel)
        contentView.addSubview(seatNumberNameLabel)
        contentView.addSubview(coachTypeNameLabel)
        contentView.addSubview(ticketStatusNameLabel)
        contentView.addSubview(seatTypeNameLabel)
                
        setConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValuesOfCell(name:String,age:Int,gender : Gender,seatNumber:Int?,seatType:SeatType?,coachName:String? ,ticketStatus:TicketBookingStatus,racOrWlNumber:Int?){
        
        nameLabel.text = name
        genderAgeLabel.text = "\(age) years | \(gender)"
        
        if let seatNumber = seatNumber{
            seatNumberLabel.text = "\(seatNumber)"
        }
        else{
            seatNumberLabel.text = " - "
        }
        
        
        
        if ticketStatus == .Cancelled{
            ticketStatusLabel.text = "\(ticketStatus.rawValue)"
            ticketStatusLabel.textColor = .systemRed
            
        }
        else if ticketStatus != .Confirmed  {
            ticketStatusLabel.text = "\(ticketStatus.rawValue)/ \(racOrWlNumber!)"
            ticketStatusLabel.textColor = .systemOrange
        }
        else{
            ticketStatusLabel.text = "\(ticketStatus.rawValue)"
            ticketStatusLabel.textColor = .systemGreen
        }
        
        
        seatTypeLabel.text = "\(seatType?.rawValue ?? " - ")"
        coachTypeLabel.text = "\(coachName ?? " - ")"
    }
    
    
    
    func setConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15))
        constraints.append(nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15))
        
        genderAgeLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(genderAgeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 2))
        constraints.append(genderAgeLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor,constant: 2))
        
        ticketStatusNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(ticketStatusNameLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor))
        constraints.append(ticketStatusNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -15))
        
        ticketStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(ticketStatusLabel.topAnchor.constraint(equalTo: ticketStatusNameLabel.bottomAnchor,constant: 5))
        constraints.append(ticketStatusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -15))
        
        coachTypeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(coachTypeNameLabel.topAnchor.constraint(equalTo: ticketStatusLabel.bottomAnchor,constant: 20))
        constraints.append(coachTypeNameLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor))
        
        seatNumberNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(seatNumberNameLabel.topAnchor.constraint(equalTo: coachTypeNameLabel.topAnchor))
        constraints.append(seatNumberNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        
        seatTypeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(seatTypeNameLabel.topAnchor.constraint(equalTo: coachTypeNameLabel.topAnchor))
        constraints.append(seatTypeNameLabel.rightAnchor.constraint(equalTo: ticketStatusLabel.rightAnchor))
        
        
        coachTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(coachTypeLabel.topAnchor.constraint(equalTo: seatNumberNameLabel.bottomAnchor,constant: 5))
        constraints.append(coachTypeLabel.centerXAnchor.constraint(equalTo: coachTypeNameLabel.centerXAnchor))
        
        seatNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(seatNumberLabel.topAnchor.constraint(equalTo: coachTypeLabel.topAnchor))
        constraints.append(seatNumberLabel.centerXAnchor.constraint(equalTo: seatNumberNameLabel.centerXAnchor))
        
        seatTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(seatTypeLabel.topAnchor.constraint(equalTo: coachTypeLabel.topAnchor))
        constraints.append(seatTypeLabel.centerXAnchor.constraint(equalTo: seatTypeNameLabel.centerXAnchor))
        constraints.append(seatTypeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15))
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
}


