//
//  QuotaAndCoachTypeSelectionTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 05/08/22.
//

import UIKit

class QuotaAndCoachTypeSelectionTableViewCell: UITableViewCell  {
    
    

    static let identifier = "QuotaAndCoachTypeSelectionTableViewCell"
    
    weak var delegate : QuotaTypeOrCoachTypeCellDelegate? = nil
    
    weak var dataSource :QuotaTypeOrCoachTypeCellDataSource? = nil
    
    var quotaTypeButton = QuotaTypeOrCoachTypeSelectorButton()
    
    var coachTypeButton = QuotaTypeOrCoachTypeSelectorButton()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(quotaTypeButton)
        contentView.addSubview(coachTypeButton)
        
        
        
        
        coachTypeButton.backgroundColor = .systemBackground
        quotaTypeButton.backgroundColor = .systemBackground
        
        quotaTypeButton.addTarget(self, action: #selector(quotaTypeButtonPressed), for: .touchUpInside)
        coachTypeButton.addTarget(self, action: #selector(coachTypeButtonPressed), for: .touchUpInside)
        
        
        contentView.backgroundColor = .systemBackground
        
        setConstraints()
    }
    
    func setLabelValues(){
        let coachTypeButtonLowerLabel = dataSource!.getCoachTypeSelectedValue()
        
        let quotaTypeButtonLowerLabel = dataSource!.getQuotaTypeSelectedValue()
        
        coachTypeButton.setLabelValues(upperLabelText: "Coach Type", lowerLabelText: coachTypeButtonLowerLabel)
        quotaTypeButton.setLabelValues(upperLabelText: "Quota Type", lowerLabelText: quotaTypeButtonLowerLabel)
    }
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        quotaTypeButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(quotaTypeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10))
        //constraints.append(quotaTypeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        
        constraints.append(quotaTypeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10))
        constraints.append(quotaTypeButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20))
        constraints.append(quotaTypeButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4))

        
        coachTypeButton.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(coachTypeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20))
        constraints.append(coachTypeButton.centerYAnchor.constraint(equalTo: quotaTypeButton.centerYAnchor))
        constraints.append(coachTypeButton.heightAnchor.constraint(equalTo: quotaTypeButton.heightAnchor))
        constraints.append(coachTypeButton.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.4))
        
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func quotaTypeButtonPressed(){
        print ("Hi Quota Type")
        delegate!.presentQuotaTypeSelector()
    }
    
    
    
    @objc func coachTypeButtonPressed(){
        print ("Hi coach Type")
        delegate!.presentCoachTypeSelector()
    }
    
}
