//
//  CheckBoxTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 30/08/22.
//

import UIKit

class CheckBoxTableViewCell: UITableViewCell {
    
    static let identifier = "CheckBoxTableViewCell"
    
    
    
    let instructionLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
    
    
    var isChecked : Bool = false {
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
        contentView.addSubview(instructionLabel)
        //checkBox.backgroundColor = .label
        checkBoxImageView.image = uncheckedImage
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelValues (input : String,checkedImageName : String?,uncheckedImageName: String?){
        
        instructionLabel.text = input
        
        if !input.contains("Confirm Berth")
        {
            if let checkedImageName = checkedImageName {
                print("hi")
                checkedImage = UIImage(systemName: checkedImageName) ?? checkedImage
            }
            if let uncheckedImageName = uncheckedImageName {
                uncheckedImage = UIImage(systemName: uncheckedImageName) ?? uncheckedImage
                checkBoxImageView.image = uncheckedImage
            }
            
        }
        
      
    }
    
    func isCheckBoxChecked()->Bool{
        return isChecked
    }
    
    func swapCheck(){
        if isChecked {
            isChecked = false
        }
        else {
            isChecked = true
        }
    }
    
    func setConstraints() {
        
        
        var constraints = [NSLayoutConstraint]()
        
        
       
        
        checkBoxImageView.translatesAutoresizingMaskIntoConstraints = false
//        constraints.append(checkBoxImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5))
        constraints.append(checkBoxImageView.leftAnchor.constraint(equalTo:contentView.leftAnchor,constant: 10))
        constraints.append(checkBoxImageView.centerYAnchor.constraint(equalTo:contentView.centerYAnchor))
        constraints.append(checkBoxImageView.widthAnchor.constraint(equalToConstant: 25))
        constraints.append(checkBoxImageView.heightAnchor.constraint(equalToConstant: 25))
        
        
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(instructionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15))
        constraints.append(instructionLabel.leftAnchor.constraint(equalTo: checkBoxImageView.rightAnchor,constant: 10))
        constraints.append(instructionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15))
        constraints.append(instructionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -15))
        
        
        
        
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        print("prepareForReuse")
        super.prepareForReuse()
        checkBoxImageView.image = UIImage(systemName: "square")!
        isChecked = false
    }
}
