//
//  DateSelecterTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 04/08/22.
//

import UIKit

class JourneyDateSelecterTableViewCell: UITableViewCell {

    static let identifier = "JourneyDateSelecterTableViewCell"
     var journeyDateSelector : UIDatePicker = {
         let datePicker = UIDatePicker()
         datePicker.timeZone = TimeZone(identifier: "UTC")!
         datePicker.datePickerMode = .date
         datePicker.preferredDatePickerStyle = .compact
         datePicker.tintColor = .systemGreen
         datePicker.backgroundColor = .systemBackground
         datePicker.date = Date().localDate()
         
        return datePicker
    }()
    
    var calenderImageView :UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .systemGreen
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var tomorrowDateButton : UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.setTitleColor(UIColor.systemGreen, for: .selected)
        button.backgroundColor = UIColor.systemGray6
        button.setTitle("Tomorrow", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize:10 )
        button.layer.cornerRadius = 5
        return button
    }()
    
    var dayAfterDateButton : UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        button.setTitleColor(UIColor.systemGreen, for: .selected)
        button.backgroundColor = UIColor.systemGray6
        button.setTitle("Day After", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        //button.titleLabel?.font = .systemFont(ofSize: 13)
        button.layer.cornerRadius = 5
        return button
    }()
    
   
    var delegate : JourneyDateSelecterTableViewCellDelegate? = nil
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(journeyDateSelector)
        contentView.addSubview(calenderImageView)
        contentView.addSubview(tomorrowDateButton)
        contentView.addSubview(dayAfterDateButton)
        
        setDatePickerValues()
        setConstraints()
    }
    
//    override func layoutSubviews() {
//
//        tomorrowDateButton.titleLabel?.font = .systemFont(ofSize: contentView.frame.width/30 )
//        dayAfterDateButton.titleLabel?.font = .systemFont(ofSize: contentView.frame.width/30 )
//    }
//
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDatePickerValues(){
//        let dateFormatter = DateFormatter()
//        dateFormatter.toDate(format: "yyyy-MM-dd", string: "")
//
        let fromDate = Date().localDate()
        let toDate = fromDate.getDateFor(days: 7)
        
        
        
        
        
        journeyDateSelector.minimumDate = fromDate
        journeyDateSelector.maximumDate = toDate
        journeyDateSelector.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        
        tomorrowDateButton.isHighlighted = false
        tomorrowDateButton.addTarget(self, action: #selector(tomorrowDateButtonPressed), for: .touchUpInside)
        
        dayAfterDateButton.isHighlighted = false
        dayAfterDateButton.addTarget(self, action: #selector(dayAfterDateButtonPressed), for: .touchUpInside)
    }
    
    
    @objc func tomorrowDateButtonPressed(){
        dayAfterDateButton.setTitleColor(UIColor.darkGray, for: .normal)
        tomorrowDateButton.setTitleColor(UIColor.systemGreen, for: .normal)
        journeyDateSelector.date = Date().localDate().getDateFor(days: 1)!
        delegate?.selectedDateValue(date: journeyDateSelector.date)
    }
    
    @objc func dayAfterDateButtonPressed(){
        tomorrowDateButton.setTitleColor(UIColor.darkGray, for: .normal)
        dayAfterDateButton.setTitleColor(UIColor.systemGreen, for: .normal)
        journeyDateSelector.date = Date().localDate().getDateFor(days: 2)!
        delegate?.selectedDateValue(date: journeyDateSelector.date)
    }
    
    @objc func dateChanged(){
        
        journeyDateSelector.resignFirstResponder()
        delegate?.selectedDateValue(date: journeyDateSelector.date)
        
        let tommorrowDate = Date().localDate().getDateFor(days: 1)!
        let dayAfterDate = Date().localDate().getDateFor(days: 2)!
        
        
        var  calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        let tomorrowDateComparesion : ComparisonResult = calendar.compare(tommorrowDate,
                                                                        to: journeyDateSelector.date,
                                                                        toGranularity: .day)
        let dayAfterDateComparesion : ComparisonResult = calendar.compare(dayAfterDate,
                                                                        to: journeyDateSelector.date,
                                                                        toGranularity: .day)
        
        if tomorrowDateComparesion != .orderedSame {
            tomorrowDateButton.setTitleColor(UIColor.darkGray, for: .normal)
        }
        if dayAfterDateComparesion != .orderedSame {
            dayAfterDateButton.setTitleColor(UIColor.darkGray, for: .normal)

        }
        if tomorrowDateComparesion == .orderedSame {
            tomorrowDateButton.setTitleColor(UIColor.systemGreen, for: .normal)
        }
        if dayAfterDateComparesion == .orderedSame {
           
            dayAfterDateButton.setTitleColor(UIColor.systemGreen, for: .normal)

        }
    }
    
    func setConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        calenderImageView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(calenderImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
        constraints.append(calenderImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.1))
        constraints.append(calenderImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(calenderImageView.heightAnchor.constraint(equalToConstant: 35))
        
        
        
        journeyDateSelector.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(journeyDateSelector.leftAnchor.constraint(equalTo: calenderImageView.rightAnchor,constant: 3))
//        constraints.append(journeyDateSelector.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35))
        //constraints.append(journeyDateSelector.widthAnchor.constraint(equalToConstant: 130))
        constraints.append(journeyDateSelector.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(journeyDateSelector.heightAnchor.constraint(equalToConstant:35))
        
        dayAfterDateButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(dayAfterDateButton.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10))
        constraints.append(dayAfterDateButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.17))
        constraints.append(dayAfterDateButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(dayAfterDateButton.heightAnchor.constraint(equalToConstant: 25))
        
        
        tomorrowDateButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(tomorrowDateButton.rightAnchor.constraint(equalTo: dayAfterDateButton.leftAnchor,constant: -5))
        constraints.append(tomorrowDateButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.18))
        constraints.append(tomorrowDateButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(tomorrowDateButton.heightAnchor.constraint(equalToConstant: 25))
        
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setDatePickerValues()
    }
    
    func getDate () -> Date {
        return journeyDateSelector.date
    }
    
}
