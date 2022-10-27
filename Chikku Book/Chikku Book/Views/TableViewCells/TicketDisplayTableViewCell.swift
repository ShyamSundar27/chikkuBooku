//
//  TicketDisplayTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 10/09/22.
//

import UIKit

class TicketDisplayTableViewCell: UITableViewCell {
    
    
    static let identifier = "TicketDisplayTableViewCell"
    
    
    let trainNameLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    let trainNumberLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    
    let fromStationLabel : UILabel = {
        
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    let toStationLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    let fromStationCodeLabel : UILabel = {
        
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let toStationCodeLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()

    let dateLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .center
        return label
    }()
    
    let pnrLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
  
    
    
    
    
    let trainImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wallet.pass")
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let arrowLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.text = "----->"
        label.textColor = .systemGreen
        return label
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(pnrLabel)
        contentView.addSubview(fromStationLabel)
        contentView.addSubview(toStationLabel)
        contentView.addSubview(trainNameLabel)
        contentView.addSubview(trainNumberLabel)
        contentView.addSubview(trainImageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(arrowLabel)
        contentView.addSubview(fromStationCodeLabel)
        contentView.addSubview(toStationCodeLabel)
        
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraints(){
        
        
        var constraints = [NSLayoutConstraint]()
        
        
        
        trainImageView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(trainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20))
        constraints.append(trainImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4))
        constraints.append(trainImageView.widthAnchor.constraint(equalTo: trainImageView.heightAnchor))
        constraints.append(trainImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15))
        
        
        
        trainNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(trainNameLabel.leftAnchor.constraint(equalTo: trainImageView.rightAnchor,constant:  15))
        constraints.append(trainNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15))
       
        
        
        trainNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(trainNumberLabel.leftAnchor.constraint(equalTo: trainNameLabel.rightAnchor,constant:  5))
        constraints.append(trainNumberLabel.topAnchor.constraint(equalTo: trainNameLabel.topAnchor))
        
        
        
        
        fromStationLabel.translatesAutoresizingMaskIntoConstraints =  false
        
        constraints.append(fromStationLabel.leftAnchor.constraint(equalTo: trainNameLabel.leftAnchor))
        constraints.append(fromStationLabel.topAnchor.constraint(equalTo: trainNameLabel.bottomAnchor,constant: 10))
       // constraints.append(fromStationLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.27))
        
        
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(arrowLabel.leftAnchor.constraint(equalTo: fromStationLabel.rightAnchor,constant: 10))
        constraints.append(arrowLabel.topAnchor.constraint(equalTo: fromStationLabel.topAnchor))
        
//        constraints.append(arrowImage.heightAnchor.constraint(equalToConstant: 30))
//        constraints.append(arrowImage.widthAnchor.constraint(equalToConstant: 60))
        
        
       
        
        
        toStationLabel.translatesAutoresizingMaskIntoConstraints =  false
        
        constraints.append(toStationLabel.leftAnchor.constraint(equalTo: arrowLabel.rightAnchor,constant: 10))
        constraints.append(toStationLabel.topAnchor.constraint(equalTo: fromStationLabel.topAnchor))
 //       constraints.append(toStationLabel.widthAnchor.constraint(equalTo: fromStationLabel.widthAnchor))
        
      
        fromStationCodeLabel.translatesAutoresizingMaskIntoConstraints =  false
        
        constraints.append(fromStationCodeLabel.leftAnchor.constraint(equalTo: trainNameLabel.leftAnchor))
        constraints.append(fromStationCodeLabel.topAnchor.constraint(equalTo: fromStationLabel.bottomAnchor))
        
        
        
        
        toStationCodeLabel.translatesAutoresizingMaskIntoConstraints =  false
        
        constraints.append(toStationCodeLabel.rightAnchor.constraint(equalTo: toStationLabel.rightAnchor))
        constraints.append(toStationCodeLabel.topAnchor.constraint(equalTo: toStationLabel.bottomAnchor))
//        toStationCodeLabel.backgroundColor = .systemGreen
        
        
        
        
        dateLabel.translatesAutoresizingMaskIntoConstraints =  false

        constraints.append(dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20))
        constraints.append(dateLabel.topAnchor.constraint(equalTo: trainImageView.bottomAnchor,constant: 20))

                           
        
       
        
//        dateLabel.backgroundColor = .red
        
        
        
        
        pnrLabel.translatesAutoresizingMaskIntoConstraints =  false

        constraints.append(pnrLabel.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor))
        constraints.append(pnrLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -20))
        constraints.append(pnrLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20))
        
        
        
//        dateLabel.translatesAutoresizingMaskIntoConstraints =  false
//
//        constraints.append(dateLabel.leftAnchor.constraint(equalTo: fromStationCodeLabel.rightAnchor,constant: 10))
//        constraints.append(dateLabel.centerYAnchor.constraint(equalTo: fromStationCodeLabel.centerYAnchor))
//        constraints.append(dateLabel.rightAnchor.constraint(equalTo: toStationCodeLabel.leftAnchor, constant: -10))
//        constraints.append(dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20))
//        dateLabel.textAlignment = .center
        
       
        
    
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setValues (trainName : String,trainNumber:Int, fromStationNameAndCode : (name:String , code:String),toStationNameAndCode : (name:String , code:String), pnrNumber:UInt64 , journeyDate:Date){
        
        trainNameLabel.text = "\(trainName)"
        trainNumberLabel.text = "(\(trainNumber))"
        fromStationLabel.text = "\(fromStationNameAndCode.name) "
        toStationLabel.text = "\(toStationNameAndCode.name)"
        
        fromStationCodeLabel.text = "(\(fromStationNameAndCode.code))"
        toStationCodeLabel.text = "(\(toStationNameAndCode.code)) "
        
        print("\(toStationNameAndCode.code)hi")
        
        pnrLabel.text = "PNR: \(pnrNumber)"
        dateLabel.text = "\(journeyDate.toString(format: "E, d MMM yyyy"))"
        
        
        setConstraints()
    }
    
    func changeCellTintColor (tintColor:UIColor){
        
        trainImageView.tintColor = tintColor
        arrowLabel.textColor = tintColor
    }
    
    override func prepareForReuse() {
        trainImageView.tintColor = .systemGreen
        arrowLabel.textColor = .systemGreen
    }
}
