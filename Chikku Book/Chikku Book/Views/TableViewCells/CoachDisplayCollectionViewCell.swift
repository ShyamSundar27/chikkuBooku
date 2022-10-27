//
//  CoachDisplayCollectionViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 15/09/22.
//

import UIKit

class CoachDisplayCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "CoachDisplayCollectionViewCell"
    
    
    let coachNameLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(coachNameLabel)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2);
        contentView.layer.shadowColor = UIColor.black.cgColor;
        contentView.layer.shadowRadius = 2;
        contentView.layer.shadowOpacity = 0.2;
        
        setConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints () {
        
        var constraints = [NSLayoutConstraint]()
        
        
        coachNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(coachNameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -15))
        constraints.append(coachNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: 15))
        constraints.append(coachNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        constraints.append(coachNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    func setLabelValues(coachName : String ){
        
        coachNameLabel.text = coachName
        coachNameLabel.font = .preferredFont(forTextStyle: .largeTitle)
        coachNameLabel.textAlignment = .center
    }
}
