//
//  ExistingPassengerSelectionTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 15/09/22.
//

import UIKit

class ExistingPassengerSelectionTableViewCell: UITableViewCell {
    
    
    
    static let identifier = "ExistingPassengerSelectionTableViewCell"
    
    let nameLabel : UILabel = {
        
        let label = UILabel()
        return label
        
    }()
    
    let ageGenderPreferenceLabel : UILabel = {
        
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemGray
        return label
    }()
    
    var checkedImage = UIImage(systemName: "checkmark.square.fill")!
    
    var uncheckedImage = UIImage(systemName: "square")!
    
    
    let checkBoxImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    
    lazy var isChecked : Bool = false {
        didSet{
            if isChecked == true {
                checkBoxImageView.image = checkedImage
            }
            
            else{
                checkBoxImageView.image = uncheckedImage
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(checkBoxImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageGenderPreferenceLabel)
        //checkBox.backgroundColor = .label
        checkBoxImageView.image = uncheckedImage
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraints () {
        
        var constraints = [NSLayoutConstraint]()
        
        checkBoxImageView.translatesAutoresizingMaskIntoConstraints = false

        constraints.append(checkBoxImageView.leftAnchor.constraint(equalTo:contentView.leftAnchor,constant: 20))
        constraints.append(checkBoxImageView.centerYAnchor.constraint(equalTo:contentView.centerYAnchor))
        constraints.append(checkBoxImageView.widthAnchor.constraint(equalToConstant: 25))
        constraints.append(checkBoxImageView.heightAnchor.constraint(equalToConstant: 25))
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(nameLabel.leftAnchor.constraint(equalTo:checkBoxImageView.rightAnchor,constant: 10))
        constraints.append(nameLabel.topAnchor.constraint(equalTo:contentView.topAnchor,constant: 15))
        
        
        ageGenderPreferenceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(ageGenderPreferenceLabel.leftAnchor.constraint(equalTo:nameLabel.leftAnchor,constant: 4))
        constraints.append(ageGenderPreferenceLabel.topAnchor.constraint(equalTo:nameLabel.bottomAnchor,constant: 5))
        constraints.append(ageGenderPreferenceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15))
        
        
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    func setLabelValues (name:String, age : Int, gender:Gender, seatPreference: SeatType? ){
        nameLabel.text = name
        
        ageGenderPreferenceLabel.text = "\(age) | \(gender.rawValue) | \(seatPreference?.rawValue ?? "No Preference")"
        
    }
    
    
    
    func isCheckBoxChecked()->Bool{
        return isChecked
    }
    
    func swapCheck(){
        
        print("swapCheck")
        
        if isChecked {
            isChecked = false
        }
        else {
            isChecked = true
        }
    }
    
    override func prepareForReuse() {

        super.prepareForReuse()
        //checkBoxImageView.image = UIImage(systemName: "square")!
        isChecked = false

    }
}
