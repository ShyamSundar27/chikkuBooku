//
//  TrainRunningAndCoachDetailsTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 11/08/22.
//

import UIKit

class TrainRunningAndCoachDetailsTableViewCell: UITableViewCell {
    
    static let identifier = "TrainRunningAndCoachDetailsTableViewCell"
    
    //var trainNameAndTimeDetailsView = FromToStationDetailsView()
    
    var fromStationTimeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()

    var toStationTimeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
   
    var toStationNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    var fromStationNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    var timeDiffereneLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var fromStationTravelDayLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    var toStationTravelDayLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    
    
    
    
    
   
    
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //contentView.addSubview(trainNameAndTimeDetailsView)
        //contentView.backgroundColor = .systemBackground
        contentView.addSubview(fromStationTimeLabel)
        contentView.addSubview(toStationTimeLabel)
        contentView.addSubview(toStationNameLabel)
        contentView.addSubview(fromStationNameLabel)
        contentView.addSubview(timeDiffereneLabel)
        contentView.addSubview(fromStationTravelDayLabel)
        contentView.addSubview(toStationTravelDayLabel)
        setConstraints()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValuesOfView(fromStationNameAndCode:(code:String,name:String), toStationNameAndCode:(code:String,name:String), fromStationDepTime:Date, toStationArrTime:Date, travelStartDate:Date, travelEndDate:Date,startStationDayOfTravel:Int?,endStationDayOfTravel:Int?){
        
        
       setLabelValues(fromStationNameAndCode: fromStationNameAndCode, toStationNameAndCode: toStationNameAndCode, fromStationDepTime: fromStationDepTime, toStationArrTime: toStationArrTime, travelStartDate: travelStartDate, travelEndDate: travelEndDate,startStationDayOfTravel:startStationDayOfTravel,endStationDayOfTravel: endStationDayOfTravel )
        
        
    }
    
   private func setLabelValues(fromStationNameAndCode:(code:String,name:String), toStationNameAndCode:(code:String,name:String), fromStationDepTime:Date, toStationArrTime:Date, travelStartDate:Date,travelEndDate:Date,startStationDayOfTravel:Int?,endStationDayOfTravel:Int?){
        
        fromStationTimeLabel.text = fromStationDepTime.toString(format: "HH:mm")
        toStationTimeLabel.text = toStationArrTime.toString(format: "HH:mm")
        fromStationNameLabel.text = "\(fromStationNameAndCode.name) (\(fromStationNameAndCode.code))"
        toStationNameLabel.text = "\(toStationNameAndCode.name) (\(toStationNameAndCode.code))"
        if startStationDayOfTravel != nil && endStationDayOfTravel != nil{
            fromStationTravelDayLabel.text = "Day \(startStationDayOfTravel!)"
            toStationTravelDayLabel.text = "Day \(endStationDayOfTravel!)"
        }
        else{
            fromStationTravelDayLabel.text = travelStartDate.toString(format: "E, d MMM")
            toStationTravelDayLabel.text = travelEndDate.toString(format: "E, d MMM")
        }
        
        
        let dateFormatter = DateFormatter()
        
        
        
        let fromDateAndTimeString = "\(travelStartDate.toString (format: "yyyy-MM-dd"))T\(fromStationDepTime.toString (format: "HH:mm"))"
        
        let toDateAndTimeString = "\(travelEndDate.toString (format: "yyyy-MM-dd"))T\(toStationArrTime.toString (format: "HH:mm"))"
        
        
        print(fromDateAndTimeString,toDateAndTimeString)
        
        let fromDateAndTime = dateFormatter.toDate(format: "yyyy-MM-dd'T'HH:mm", string: fromDateAndTimeString)
        
        let toDateAndTime = dateFormatter.toDate(format: "yyyy-MM-dd'T'HH:mm", string: toDateAndTimeString)
        
    
        var hourDiff = String(Calendar.current.dateComponents([.hour,.minute], from: fromDateAndTime,to: toDateAndTime).hour!)
        
        var minDiff = String(Calendar.current.dateComponents([.hour,.minute], from: fromDateAndTime, to: toDateAndTime).minute!)
        
        
        if hourDiff.count == 1 {
            hourDiff.insert("0", at: hourDiff.startIndex)
        }
        
        if minDiff.count == 1{
            minDiff.insert("0", at: minDiff.startIndex)
        }
        
        timeDiffereneLabel.text = "---- \(hourDiff)h:\(minDiff)m ----"
        
        
        print("\(Calendar.current.dateComponents([.hour,.minute], from: fromDateAndTime, to: toDateAndTime).hour!):\(Calendar.current.dateComponents([.hour,.minute], from: fromDateAndTime, to: toDateAndTime).minute!)")
    }
    
    
    
    func setConstraints (){
        var constraints = [NSLayoutConstraint]()
        
//        trainNameAndTimeDetailsView.translatesAutoresizingMaskIntoConstraints = false
//        constraints.append(trainNameAndTimeDetailsView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -5))
//        constraints.append(trainNameAndTimeDetailsView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5))
//        constraints.append(trainNameAndTimeDetailsView.topAnchor.constraint(equalTo: contentView.topAnchor))
//        constraints.append(trainNameAndTimeDetailsView.heightAnchor.constraint(equalToConstant: 100))
//        constraints.append(trainNameAndTimeDetailsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10))
//
        
        
        fromStationTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(fromStationTimeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
  //      constraints.append(fromStationTimeLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.2))
        constraints.append(fromStationTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10))
    //    constraints.append(fromStationTimeLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
        
        timeDiffereneLabel.translatesAutoresizingMaskIntoConstraints = false
  //      constraints.append(timeDiffereneLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5))
        constraints.append(timeDiffereneLabel.centerYAnchor.constraint(equalTo: fromStationTimeLabel.centerYAnchor))
        constraints.append(timeDiffereneLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
  //      constraints.append(timeDiffereneLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
                                          
        toStationTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(toStationTimeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10))
 //       constraints.append(toStationTimeLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.2))
        constraints.append(toStationTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10))
 //       constraints.append(toStationTimeLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
                                                                        
                                                                        
        fromStationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(fromStationNameLabel.leftAnchor.constraint(equalTo: fromStationTimeLabel.leftAnchor))
       constraints.append(fromStationNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5))
        constraints.append(fromStationNameLabel.topAnchor.constraint(equalTo: fromStationTimeLabel.bottomAnchor,constant: 10))
  //      constraints.append(fromStationNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
        
         
        toStationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(toStationNameLabel.rightAnchor.constraint(equalTo: toStationTimeLabel.rightAnchor))
        constraints.append(toStationNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5))
        constraints.append(toStationNameLabel.topAnchor.constraint(equalTo: toStationTimeLabel.bottomAnchor,constant: 10))
     //   constraints.append(toStationNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
        
        fromStationTravelDayLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(fromStationTravelDayLabel.leftAnchor.constraint(equalTo: fromStationTimeLabel.leftAnchor))
   //     constraints.append(fromStationTravelDayLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5))
        constraints.append(fromStationTravelDayLabel.topAnchor.constraint(equalTo: fromStationNameLabel.bottomAnchor,constant: 10))
  //      constraints.append(fromStationTravelDayLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
        constraints.append(fromStationTravelDayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10))
        
        toStationTravelDayLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(toStationTravelDayLabel.rightAnchor.constraint(equalTo: toStationTimeLabel.rightAnchor))
   //     constraints.append(toStationTravelDayLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5))
        constraints.append(toStationTravelDayLabel.topAnchor.constraint(equalTo: toStationNameLabel.bottomAnchor,constant: 10))
    //    constraints.append(toStationTravelDayLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
        constraints.append(toStationTravelDayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10))
        
       
        
        NSLayoutConstraint.activate(constraints)
        
      
    }
    
    
    
}


