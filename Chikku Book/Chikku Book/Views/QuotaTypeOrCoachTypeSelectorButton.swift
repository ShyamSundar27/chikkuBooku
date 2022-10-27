//
//  QuotaTypeOrCoachTypeSelectorButton.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 05/08/22.
//

import UIKit

class QuotaTypeOrCoachTypeSelectorButton: UIButton {

    var upperLabel = UILabel()
    var lowerLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(upperLabel)
        addSubview(lowerLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelValues(upperLabelText:String,lowerLabelText:String){
        upperLabel.text = upperLabelText
        lowerLabel.text = lowerLabelText
        upperLabel.font = .preferredFont(forTextStyle: .callout)
        lowerLabel.font = .preferredFont(forTextStyle: .footnote)
        upperLabel.textColor = .systemGray
        lowerLabel.textColor = .systemGreen
        upperLabel.textAlignment = .center
        lowerLabel.textAlignment = .center
        //lowerLabel.numberOfLines = 2
    }
    
    func setConstraints(){
        
        var constraints = [NSLayoutConstraint]()

        upperLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(upperLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5))
        constraints.append(upperLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor))
        constraints.append(upperLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5))
        constraints.append(upperLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5))
        
        lowerLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(lowerLabel.topAnchor.constraint(equalTo: self.centerYAnchor,constant: 5))
        constraints.append(lowerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5))
        constraints.append(lowerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5))
        constraints.append(lowerLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5))
    
        NSLayoutConstraint.activate(constraints)
        
    }
}
