//
//  FareDisplayTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 02/09/22.
//

import UIKit

class FareDisplayTableViewCell: UITableViewCell {

   
    
     
    static let identifier = "FareDisplayTableViewCell"
    
    let convenienceFee : Float = 17.55
    
    var travelInsurance : Float = 0.00
    
    let baseFareNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Ticket Fare"
        label.textAlignment = .left
        return label
    }()
    
    let baseFareMultiplierLabel :  UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray
        return label
    }()
    
    let baseFarePriceLabel : UILabel = {
        let label = UILabel()
//        label.text = "Base Fare"
        label.textAlignment = .right
        label.textColor = .systemGray
        return label
    }()
    
    let travelInsuranceNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Travel Insurance "
        label.textAlignment = .left
        return label
    }()
    
    let travelInsurancePriceLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .systemGray
        return label
    }()
    
    let convenienceFeeNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Convenience Fee (Incl. of GST)"
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let convenienceFeePriceLabel : UILabel = {
        let label = UILabel()
//        label.text = "17.65"
        label.textAlignment = .right
        label.textColor = .systemGray
        return label
    }()
    
    
    let totalAmountNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Total Amount"
        label.textAlignment = .left
        
        return label
    }()
    
    let totalAmountPriceLabel : UILabel = {
        let label = UILabel()
        label.text = "Base Fare"
        label.textAlignment = .right
        label.textColor = .systemGreen
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(baseFareNameLabel)
        contentView.addSubview(baseFarePriceLabel)
        contentView.addSubview(baseFareMultiplierLabel)
        contentView.addSubview(travelInsuranceNameLabel)
        contentView.addSubview(travelInsurancePriceLabel)
        contentView.addSubview(convenienceFeeNameLabel)
        contentView.addSubview(convenienceFeePriceLabel)
        contentView.addSubview(totalAmountNameLabel)
        contentView.addSubview(totalAmountPriceLabel)
        
        setConstraints()

    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setValues(ticketFare : Float, numberOfPassengers:Int, travelInsuranceOpt:Bool){
        
        
        
        if travelInsuranceOpt {
            travelInsurance = 0.65
        }
        
        let baseFare:Float = ticketFare - travelInsurance - convenienceFee
        
        baseFarePriceLabel.text = "₹ \(String(format: "%.2f", baseFare))"
        
        baseFareMultiplierLabel.text = "\(numberOfPassengers) x \(String(format: "%.2f", baseFare/Float(numberOfPassengers)))"

        totalAmountPriceLabel.text = "₹ \(String(format: "%.2f", ticketFare))"
        travelInsurancePriceLabel.text = "₹ \(String(format: "%.2f", travelInsurance))"
        convenienceFeePriceLabel.text = "₹ \(String(format: "%.2f", convenienceFee))"
        
    }
    
    
    func setRefundValues (refundAmount : Float, numberOfPassengers:Int, travelInsuranceOpt:Bool){
        
        
                
        if travelInsuranceOpt {
            travelInsurance = 0.65
            
        }
        
        
        let ticketFare : Float = ((refundAmount + 5.25 ) * 10 )/7
        
        let serviceCharge : Float = ticketFare * 30 / 100
        
        let finalRefund = refundAmount
        
        baseFareMultiplierLabel.text = ""
        
        
        baseFarePriceLabel.text = "₹ \(String(format: "%.2f", ticketFare))"
        

        
        
        travelInsurancePriceLabel.text = "- ₹  \(String(format: "%.2f", serviceCharge))"
        travelInsuranceNameLabel.text = "Service Charge"
        travelInsurancePriceLabel.textColor = .systemRed.withAlphaComponent(0.7)
        
        convenienceFeePriceLabel.text = "- ₹ 5.25"
        convenienceFeeNameLabel.text = "Internet Fees Charge"
        convenienceFeePriceLabel.textColor = .systemRed.withAlphaComponent(0.7)
        
        
       
        totalAmountPriceLabel.text = "₹ \(String(format: "%.2f", finalRefund))"
        totalAmountNameLabel.text = "Total Refund Amount"
        
    }
    func setConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        
        baseFareNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(baseFareNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10))
        constraints.append(baseFareNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10))
        
        
        baseFarePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(baseFarePriceLabel.topAnchor.constraint(equalTo: baseFareNameLabel.topAnchor))
        constraints.append(baseFarePriceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10))
        
        baseFareMultiplierLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(baseFareMultiplierLabel.centerYAnchor.constraint(equalTo: baseFareNameLabel.centerYAnchor))
        constraints.append(baseFareMultiplierLabel.rightAnchor.constraint(equalTo: baseFarePriceLabel.leftAnchor, constant: -20))
        
        
        travelInsuranceNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(travelInsuranceNameLabel.topAnchor.constraint(equalTo: baseFareNameLabel.bottomAnchor,constant: 10))
        constraints.append(travelInsuranceNameLabel.leftAnchor.constraint(equalTo: baseFareNameLabel.leftAnchor))
        
        
        travelInsurancePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(travelInsurancePriceLabel.topAnchor.constraint(equalTo: travelInsuranceNameLabel.topAnchor))
        constraints.append(travelInsurancePriceLabel.rightAnchor.constraint(equalTo: baseFarePriceLabel.rightAnchor))
        
        
        convenienceFeeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(convenienceFeeNameLabel.topAnchor.constraint(equalTo: travelInsuranceNameLabel.bottomAnchor,constant: 10))
        constraints.append(convenienceFeeNameLabel.leftAnchor.constraint(equalTo: baseFareNameLabel.leftAnchor))
        constraints.append(convenienceFeeNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.7))
        
        
        convenienceFeePriceLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(convenienceFeePriceLabel.topAnchor.constraint(equalTo: convenienceFeeNameLabel.topAnchor))
        constraints.append(convenienceFeePriceLabel.rightAnchor.constraint(equalTo: baseFarePriceLabel.rightAnchor))
        
        
        totalAmountNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(totalAmountNameLabel.topAnchor.constraint(equalTo: convenienceFeeNameLabel.bottomAnchor,constant: 30))
        constraints.append(totalAmountNameLabel.leftAnchor.constraint(equalTo: baseFareNameLabel.leftAnchor))
        
        
        totalAmountPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(totalAmountPriceLabel.topAnchor.constraint(equalTo: totalAmountNameLabel.topAnchor))
        constraints.append(totalAmountPriceLabel.rightAnchor.constraint(equalTo: baseFarePriceLabel.rightAnchor))
        constraints.append(totalAmountPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10))
        
        
        
        NSLayoutConstraint.activate(constraints)
    }
    

}
