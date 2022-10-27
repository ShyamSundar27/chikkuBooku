//
//  TrainNameDisplayTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 09/08/22.
//

import UIKit

class TrainNameDisplayTableViewCell: UITableViewCell {
    
    
    static let identifier = "TrainNameDisplayTableViewCell"
    
    let trainNameAndNumberLabel : UILabel = {
        let label = UILabel()
        label.textAlignment =  .left
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(trainNameAndNumberLabel)
        //contentView.backgroundColor = .systemBackground

        setConstraints()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    func setTrainNameAndNumberLabelText (trainNumber:Int,trainName:String){
        trainNameAndNumberLabel.text = " \(String(trainNumber)) - \(trainName)"
    }

    func setConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        trainNameAndNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(trainNameAndNumberLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor))
        constraints.append(trainNameAndNumberLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 4))
        constraints.append(trainNameAndNumberLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10))
        constraints.append(trainNameAndNumberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10))
        
        NSLayoutConstraint.activate(constraints)

    }

}
