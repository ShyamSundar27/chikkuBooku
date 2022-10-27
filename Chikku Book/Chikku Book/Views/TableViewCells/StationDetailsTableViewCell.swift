//
//  StationDetailsTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 07/09/22.
//

import UIKit

class StationDetailsTableViewCell: UITableViewCell {
    
    
    static let identifier = "StationDetailsTableViewCell"
    
    let stationNameAndCodeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        return label
    }()
    
   
    
    let arrTimeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        return label
    }()
    
    let depTimeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        return label
    }()
    
    let runningDayLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .subheadline)

        return label
    }()
    
    let distLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        return label
    }()
    
    var bottomAnchorConstraint : NSLayoutConstraint? = nil
    
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stationNameAndCodeLabel)
        contentView.addSubview(arrTimeLabel)
        contentView.addSubview(depTimeLabel)
        contentView.addSubview(runningDayLabel)
        contentView.addSubview(distLabel)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        stationNameAndCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(stationNameAndCodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10))
        
        constraints.append(stationNameAndCodeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20))
        constraints.append(stationNameAndCodeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.4))
        
        arrTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(arrTimeLabel.topAnchor.constraint(equalTo: stationNameAndCodeLabel.topAnchor))
//        constraints.append(arrTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5))
        constraints.append(arrTimeLabel.leftAnchor.constraint(equalTo: stationNameAndCodeLabel.rightAnchor,constant: 10))
        constraints.append(arrTimeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.13))
        
        depTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(depTimeLabel.topAnchor.constraint(equalTo: stationNameAndCodeLabel.topAnchor))
//        constraints.append(depTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5))
        constraints.append(depTimeLabel.leftAnchor.constraint(equalTo: arrTimeLabel.rightAnchor,constant: 5))
        constraints.append(depTimeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.13))
        
        runningDayLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(runningDayLabel.topAnchor.constraint(equalTo: stationNameAndCodeLabel.topAnchor))
//        constraints.append(runningDayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5))
        constraints.append(runningDayLabel.leftAnchor.constraint(equalTo: depTimeLabel.rightAnchor,constant: 10))
        constraints.append(runningDayLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.1))
        
        distLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(distLabel.topAnchor.constraint(equalTo: stationNameAndCodeLabel.topAnchor))
//        constraints.append(distLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5))
        constraints.append(distLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10))
        constraints.append(distLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.13))
        
        
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setLabelValues(stationNameAndCode : String,arrTime:String,deptTime:String,runningDay:String,dist:String){
        
        if stationNameAndCode == "Station Name"{
            bottomAnchorConstraint = depTimeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10)
            bottomAnchorConstraint!.isActive = true
            arrTimeLabel.textAlignment = .left
            depTimeLabel.textAlignment = .left
            arrTimeLabel.textColor = .systemGray
            depTimeLabel.textColor = .systemGray
            stationNameAndCodeLabel.textColor = .systemGray
            runningDayLabel.textColor = .systemGray
            distLabel.textColor = .systemGray
        }
        
        else{
            bottomAnchorConstraint = stationNameAndCodeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10)
            bottomAnchorConstraint!.isActive = true
        }
        
        stationNameAndCodeLabel.text = stationNameAndCode
        arrTimeLabel.text = arrTime
        depTimeLabel.text = deptTime
        runningDayLabel.text = runningDay
        distLabel.text = dist
        
    }
    
    
}
