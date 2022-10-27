//
//  PassengerDetailsTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 29/08/22.
//

import UIKit

class PassengerDetailsTableViewCell: UITableViewCell {

    
    static let identifier = "PassengerDetailsTableViewCell"
    
    var passengerNumber : Int? = nil
    
    
    weak var delegate : PassengerDetailsTableViewCellDelegate? = nil

//    let passengerNumberlabel : UILabel = {
//        let label = UILabel()
//        label.font = .preferredFont(forTextStyle: .callout)
//        return label
//    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        return label
    }()
    
    let genderAgeBerthLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray
        return label
    }()
    

    
    let deleteImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "trash")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemRed
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       // contentView.addSubview(passengerNumberlabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderAgeBerthLabel)
        contentView.addSubview(deleteImageView)
        
        setTapGesture()
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelValues(name:String,age:Int,berthPreference:String?,gender: Gender,passengerNumber : Int?){
        
        self.passengerNumber = passengerNumber

        
        nameLabel.textAlignment = .left
        nameLabel.text = name
        
        
        genderAgeBerthLabel.textAlignment = .left
        
        if let berthPreference = berthPreference {
            genderAgeBerthLabel.text = "\(age) years | \(gender.rawValue) | \(berthPreference)"
        }
        
        else{
            genderAgeBerthLabel.text = "\(age) years | \(gender.rawValue)"
        }
        
        
        
    }
    
    func removeDeleteButton(){
        
        deleteImageView.removeFromSuperview()
    }
    
    func setTapGesture(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deletePressed))
        deleteImageView.isUserInteractionEnabled = true
        deleteImageView.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func deletePressed(){
        print("delete")
        delegate?.deletePassenger(passengerNumber: passengerNumber!)
    }
    
    
    func setConstraints () {
        var constraints = [NSLayoutConstraint]()
        

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20))
        constraints.append(nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5))
        
        genderAgeBerthLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(genderAgeBerthLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 5))
        constraints.append(genderAgeBerthLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor,constant: 2))
        constraints.append(genderAgeBerthLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5))
        
        deleteImageView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(deleteImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5))
        constraints.append(deleteImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10))
        constraints.append(deleteImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5))
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
