//
//  AddPassengerTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 22/08/22.
//

import UIKit

class AddPassengerTableViewCell: UITableViewCell {

    static let identifier = "AddPassengerTableViewCell"
    
    var addPassengerButton = UIButton()
    
    weak var delegate : AddPassengerTableViewCellDelegate? = nil
    
    var addExistingPassengerButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setButtonValues()
        contentView.addSubview(addPassengerButton)
        contentView.addSubview(addExistingPassengerButton)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonValues(){
        
        addPassengerButton.setTitle("+ Add Passenger", for: .normal)
        addPassengerButton.setTitleColor(.systemGreen, for: .normal)
        addPassengerButton.addTarget(self, action: #selector(addPassengerButtonClicked), for: .touchUpInside)
        addExistingPassengerButton.setTitle("+ Add Existing", for: .normal)
        addExistingPassengerButton.setTitleColor(.systemGreen, for: .normal)
        addExistingPassengerButton.addTarget(self, action: #selector(addExistingPassengerButtonClicked), for: .touchUpInside)
        
        
        
        addPassengerButton.contentHorizontalAlignment = .left
        addExistingPassengerButton.contentHorizontalAlignment = .right
        
    }

    @objc func addPassengerButtonClicked () {
        print("addPassengerButtonClicked")
        delegate?.addPassengerButtonClicked()
    }
    
    @objc func addExistingPassengerButtonClicked () {
        print("addExistingPassengerButtonClicked")
        delegate?.addExistingPassengerButtonClicked()
    }
    
    func enableButtons (){
        addPassengerButton.isEnabled = true
        addPassengerButton.alpha = 1
        addExistingPassengerButton.alpha = 1
        addPassengerButton.isEnabled = true
    }
    
    func disableButtons (){
        addPassengerButton.isEnabled = false
        addPassengerButton.alpha = 0.4
        addExistingPassengerButton.alpha = 0.4
        addPassengerButton.isEnabled = false
    }
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        addPassengerButton.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints.append(addPassengerButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        //constraints.append(addPassengerButton.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.8))
        //constraints.append(addPassengerButton.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.45))
        constraints.append(addPassengerButton.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
        constraints.append(addPassengerButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5))
        constraints.append(addPassengerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5))
        
        addExistingPassengerButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        //constraints.append(addExistingPassengerButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        //constraints.append(addExistingPassengerButton.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.8))
        constraints.append(addExistingPassengerButton.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10))
        //constraints.append(addExistingPassengerButton.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.45))
        constraints.append(addExistingPassengerButton.topAnchor.constraint(equalTo: addPassengerButton.topAnchor))
        constraints.append(addPassengerButton.bottomAnchor.constraint(equalTo: addPassengerButton.bottomAnchor))

        
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    

}
