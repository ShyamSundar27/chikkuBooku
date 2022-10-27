//
//  RecentSearchCollectionViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 05/09/22.
//

import UIKit

class RecentSearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecentSearchCollectionViewCell"
    
    let fromStationLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()
    
    let toStationLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .right
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    let fromStationCodeLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .left
        return label
    }()
    
    let toStationCodeLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .right
        return label
    }()
    
    let coachTypeLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textAlignment = .left
        
        return label
    }()
    
    let quotaTypeLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textAlignment = .right
        
        return label
    }()
    
    let dateLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textAlignment = .center
        
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.addSubview(fromStationLabel)
        contentView.addSubview(toStationLabel)
        contentView.addSubview(fromStationCodeLabel)
        contentView.addSubview(toStationCodeLabel)
        contentView.addSubview(coachTypeLabel)
        contentView.addSubview(quotaTypeLabel)
        contentView.addSubview(dateLabel)
         
        setConstraints()
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 8
        
        self.layer.shadowOffset = CGSize(width: 0, height: 2);
        self.layer.shadowColor = UIColor.black.cgColor;
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.2;
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        fromStationCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(fromStationCodeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
        constraints.append(fromStationCodeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.4))
        constraints.append(fromStationCodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10))
        
        toStationCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(toStationCodeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10))
        constraints.append(toStationCodeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.4))
        constraints.append(toStationCodeLabel.centerYAnchor.constraint(equalTo: fromStationCodeLabel.centerYAnchor))
        
        fromStationLabel.translatesAutoresizingMaskIntoConstraints = false

        constraints.append(fromStationLabel.leftAnchor.constraint(equalTo: fromStationCodeLabel.leftAnchor))
        constraints.append(fromStationLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.45))

        constraints.append(fromStationLabel.topAnchor.constraint(equalTo: fromStationCodeLabel.bottomAnchor,constant: 3))
        

        toStationLabel.translatesAutoresizingMaskIntoConstraints = false

        constraints.append(toStationLabel.rightAnchor.constraint(equalTo: toStationCodeLabel.rightAnchor))
        constraints.append(toStationLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.45))
    
        constraints.append(toStationLabel.topAnchor.constraint(equalTo: toStationCodeLabel.bottomAnchor,constant: 3))

        coachTypeLabel.translatesAutoresizingMaskIntoConstraints = false

        constraints.append(coachTypeLabel.leftAnchor.constraint(equalTo: fromStationCodeLabel.leftAnchor))
        //constraints.append(coachTypeLabel.topAnchor.constraint(equalTo: toStationLabel.bottomAnchor, constant: 5))
        constraints.append(coachTypeLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: toStationLabel.bottomAnchor, multiplier: 1))
        constraints.append(coachTypeLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: fromStationLabel.bottomAnchor, multiplier: 1))
                    

        quotaTypeLabel.translatesAutoresizingMaskIntoConstraints = false

        constraints.append(quotaTypeLabel.rightAnchor.constraint(equalTo: toStationCodeLabel.rightAnchor))
        constraints.append(quotaTypeLabel.centerYAnchor.constraint(equalTo: coachTypeLabel.centerYAnchor))

        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        constraints.append(dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        constraints.append(dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10))

        
        
        
        
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setValues(recentData : ( fromStationNameAndCode : (name:String,code:String), toStationNameAndCode : (name:String,code:String), coachType:CoachType ,quotaType:QuotaType,searchDate :Date)){
        
       
        fromStationLabel.text = "\(recentData.fromStationNameAndCode.name)"
        fromStationCodeLabel.text = "\(recentData.fromStationNameAndCode.code)"
        toStationLabel.text = "\(recentData.toStationNameAndCode.name)"
        toStationCodeLabel.text = "\(recentData.toStationNameAndCode.code)"
        coachTypeLabel.text = "\(recentData.coachType.rawValue)"
        quotaTypeLabel.text = "\(recentData.quotaType.rawValue)"
        let date = recentData.searchDate.toString(format: "E, d MMM yyyy")
        dateLabel.text = "\(date)"
        
        
//        if fromStationLabel.text!.count < toStationLabel.text!.count{
//            coachTypeLabel.topAnchor.constraint(equalTo: toStationLabel.bottomAnchor, constant: 5).isActive = true
//        }
//        else if fromStationLabel.text!.count > toStationLabel.text!.count{
//            coachTypeLabel.topAnchor.constraint(equalTo: fromStationLabel.bottomAnchor, constant: 5).isActive = true
//
//        }
//
//        else{
//            coachTypeLabel.topAnchor.constraint(equalTo: toStationLabel.bottomAnchor, constant: 5).isActive = true
//        }
        
    }
    
}
