//
//  fromToStationDetailsView.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 11/08/22.
//

import UIKit

class FromToStationDetailsView: UIView {

    var fromStationTimeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        //label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()

    var toStationTimeLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        //label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
   
    var toStationNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        //label.font = .systemFont(ofSize: 14)
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    var fromStationNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        //label.font = .systemFont(ofSize: 14)
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    var timeDiffereneLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        //label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    var fromStationTravelDayLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        //label.font = .systemFont(ofSize: 12, weight: .regular)
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    var toStationTravelDayLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .right
       // label.font = .systemFont(ofSize: 12, weight: .regular)
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(fromStationTimeLabel)
        addSubview(toStationTimeLabel)
        addSubview(toStationNameLabel)
        addSubview(fromStationNameLabel)
        addSubview(timeDiffereneLabel)
        addSubview(fromStationTravelDayLabel)
        addSubview(toStationTravelDayLabel)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setLabelValues(fromStationNameAndCode:(code:String,name:String), toStationNameAndCode:(code:String,name:String), fromStationDepTime:Date, toStationArrTime:Date, travelStartDate:Date,travelEndDate:Date,startStationDayOfTravel:Int?,endStationDayOfTravel:Int?){
        
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
    func setConstraints(){
        
        
        var constraints = [NSLayoutConstraint]()
        
        fromStationTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(fromStationTimeLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 5))
  //      constraints.append(fromStationTimeLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.2))
        constraints.append(fromStationTimeLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 10))
    //    constraints.append(fromStationTimeLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
        
        timeDiffereneLabel.translatesAutoresizingMaskIntoConstraints = false
  //      constraints.append(timeDiffereneLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5))
        constraints.append(timeDiffereneLabel.centerYAnchor.constraint(equalTo: fromStationTimeLabel.centerYAnchor))
        constraints.append(timeDiffereneLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor))
  //      constraints.append(timeDiffereneLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
                                          
        toStationTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(toStationTimeLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -5))
 //       constraints.append(toStationTimeLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.2))
        constraints.append(toStationTimeLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 10))
 //       constraints.append(toStationTimeLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
                                                                        
                                                                        
        fromStationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(fromStationNameLabel.leftAnchor.constraint(equalTo: fromStationTimeLabel.leftAnchor))
  //      constraints.append(fromStationNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5))
        constraints.append(fromStationNameLabel.topAnchor.constraint(equalTo: fromStationTimeLabel.bottomAnchor,constant: 10))
  //      constraints.append(fromStationNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
        
         
        toStationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(toStationNameLabel.rightAnchor.constraint(equalTo: toStationTimeLabel.rightAnchor))
    //    constraints.append(toStationNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5))
        constraints.append(toStationNameLabel.topAnchor.constraint(equalTo: toStationTimeLabel.bottomAnchor,constant: 10))
     //   constraints.append(toStationNameLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
        
        fromStationTravelDayLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(fromStationTravelDayLabel.leftAnchor.constraint(equalTo: fromStationTimeLabel.leftAnchor))
   //     constraints.append(fromStationTravelDayLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5))
        constraints.append(fromStationTravelDayLabel.topAnchor.constraint(equalTo: fromStationNameLabel.bottomAnchor,constant: 10))
  //      constraints.append(fromStationTravelDayLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
        
        toStationTravelDayLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(toStationTravelDayLabel.rightAnchor.constraint(equalTo: toStationTimeLabel.rightAnchor))
   //     constraints.append(toStationTravelDayLabel.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.5))
        constraints.append(toStationTravelDayLabel.topAnchor.constraint(equalTo: toStationNameLabel.bottomAnchor,constant: 10))
    //    constraints.append(toStationTravelDayLabel.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.25))
        
       
        
        
        NSLayoutConstraint.activate(constraints)
    }
}
