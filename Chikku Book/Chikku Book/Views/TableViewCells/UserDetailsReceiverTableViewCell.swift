//
//  UserDetailsReceiverTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 23/08/22.
//

import UIKit

class UserDetailsReceiverTableViewCell: UITableViewCell {
    
    static let identifier = "UserDetailsReceiverTableViewCell"
    
    weak var delegete : UserDetailsReceiverTableViewCellDelegate? = nil
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Name "
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    let ageLabel : UILabel = {
        let label = UILabel()
        label.text = "Age "
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    let nameTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        //textField.placeholder = "Name"
        //textField.backgroundColor = .systemGreen.withAlphaComponent(0.4)
        textField.keyboardType = .alphabet
        textField.tintColor = .systemGreen
        textField.font  = .systemFont(ofSize: 15)
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let nameErrorLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .caption2, compatibleWith: nil)
        label.textColor = .systemRed
        return label
    }()
    
    let ageTextField : UITextField = {
        
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        textField.keyboardType = .numberPad
        textField.tintColor = .systemGreen
        textField.font  = .systemFont(ofSize: 15)

        
        return textField
    }()
    
    let ageErrorLabel : UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .caption2, compatibleWith: nil)
        label.textColor = .systemRed
        return label
    }()
    
    var genderSegmentedControl : UISegmentedControl? = nil
    
    let genderLabel : UILabel = {
        let label = UILabel()
        label.text = "Gender "
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    
    
    let berthPreferenceLabel : UILabel = {
        let label = UILabel()
        label.text = "Berth Preference"
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    let preferredBerthTypeButton : UIButton = {
        
        let button = UIButton()
        button.setTitle("No Prerference", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.font = .preferredFont(forTextStyle: .caption1)
        button.setTitleColor(UIColor.systemGray, for: .normal)
        
        
        return button
    }()
    
    let nameLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray.withAlphaComponent(0.6)
        return view
    }()
    let ageLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray.withAlphaComponent(0.6)
        return view
    }()
    
    
    let downWardImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    let prefferedBerthLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray.withAlphaComponent(0.6)
        return view
    }()
    
    let addPassengerButton : UIButton = {
        let button  = UIButton()
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGreen
        button.setTitle("Add Passenger", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .footnote)
        return button
    }()
    
    let segmentedControlItems = [Gender.Male.rawValue,Gender.Female.rawValue,Gender.Trangender.rawValue]
    
    
    var myPickerView = UIPickerView()
    
    var isToBeUpdated = false
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setSegmentedControlValues()
        setSubViews()
        
        preferredBerthTypeButton.addTarget(self, action: #selector(berthButtonTapped), for: .touchUpInside)
        
        addPassengerButton.addTarget(self, action: #selector(addPassengerButtonClicked), for: .touchUpInside)
        
        preferredBerthTypeButton.isUserInteractionEnabled = true
       
        
        setConstraints()

    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setSegmentedControlValues(){
        genderSegmentedControl = UISegmentedControl(items: segmentedControlItems )
        genderSegmentedControl!.selectedSegmentTintColor = .systemGreen
        genderSegmentedControl!.selectedSegmentIndex = 0
        genderSegmentedControl!.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        
        genderSegmentedControl!.addTarget(self, action: #selector(segmentedControlTapped), for: .allEvents)
        
    }
    
    
    @objc func segmentedControlTapped(){
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        endEditing(true)
    }
    @objc func berthButtonTapped(){
        
        
        nameTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
        endEditing(true)
        delegete?.presentBerthTypeSelector()
        
       
    }
    
    @objc func addPassengerButtonClicked(){

        delegete?.nameTextFieldEndEditing(enteredText: nameTextField.text ?? "")
        delegete?.ageTextFieldEndEditing(enteredText: ageTextField.text ?? "")
        
        print("\(!nameErrorLabel.text!.isEmpty) !nameErrorLabel.text!.isEmpty")
        print("\(!ageErrorLabel.text!.isEmpty) (!ageErrorLabel.text!.isEmpty)")
        
        if !nameErrorLabel.text!.isEmpty || !ageErrorLabel.text!.isEmpty{
            print(nameErrorLabel.text as Any)
            
            print("Done")
        }
        else{
            delegete?.passengerInputValues(name: nameTextField.text!, age: Int(ageTextField.text!)!, gender: Gender(rawValue:segmentedControlItems[genderSegmentedControl!.selectedSegmentIndex])!, BerthPreference: preferredBerthTypeButton.titleLabel!.text! ,isToBeUpdated : self.isToBeUpdated )
        }
        

    }
    
    func setNameFieldError(text : String){
        nameErrorLabel.text = text
    }
    
    func setAgeFieldError(text : String)
    {
        ageErrorLabel.text = text
    }
    func setSubViews(){
        
        nameTextField.tag = 1
        ageTextField.tag = 2
        nameTextField.delegate = self
        ageTextField.delegate = self
        contentView.addSubview(nameTextField)
        contentView.addSubview(ageTextField)
        contentView.addSubview(genderSegmentedControl!)
        contentView.addSubview(preferredBerthTypeButton)

        contentView.addSubview(genderLabel)
        contentView.addSubview(berthPreferenceLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(ageErrorLabel)
        contentView.addSubview(nameErrorLabel)


        
        preferredBerthTypeButton.addSubview(downWardImageView)
        contentView.addSubview(prefferedBerthLineView)
        
        contentView.addSubview(addPassengerButton)
        
    }
    
    func setSelectedBerthType (berthType : SeatType?){
        if let  berthType = berthType {
            preferredBerthTypeButton.setTitle(berthType.rawValue, for: .normal)
        }
        
    }
    
    
    func setConstraints (){
        
        var constraints = [NSLayoutConstraint]()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(nameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 10))
        constraints.append(nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 3))
        constraints.append(nameTextField.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(nameTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -10))
        constraints.append(nameTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
        
        nameErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(nameErrorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,constant: 3))
        constraints.append(nameErrorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
        constraints.append(nameErrorLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8))

        
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(ageLabel.topAnchor.constraint(equalTo: nameErrorLabel.bottomAnchor,constant: 2))
        constraints.append(ageLabel.leftAnchor.constraint(equalTo: nameTextField.leftAnchor))
        
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor,constant: 3))
        constraints.append(ageTextField.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(ageTextField.rightAnchor.constraint(equalTo: nameTextField.rightAnchor))
        constraints.append(ageTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor))
        
        ageErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(ageErrorLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor,constant: 3))
        constraints.append(ageErrorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
    
        
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(genderLabel.topAnchor.constraint(equalTo: ageErrorLabel.bottomAnchor,constant: 10))
        constraints.append(genderLabel.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(genderLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier : 0.19))
        constraints.append(genderLabel.leftAnchor.constraint(equalTo: nameTextField.leftAnchor))
        
        genderSegmentedControl!.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(genderSegmentedControl!.centerYAnchor.constraint(equalTo: genderLabel.centerYAnchor))
        constraints.append(genderSegmentedControl!.leftAnchor.constraint(equalTo: genderLabel.rightAnchor))
  
        constraints.append(genderSegmentedControl!.heightAnchor.constraint(equalToConstant: 30))
        
        
        berthPreferenceLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(berthPreferenceLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor,constant: 10))
        constraints.append(berthPreferenceLabel.heightAnchor.constraint(equalTo: nameTextField.heightAnchor))
        constraints.append(berthPreferenceLabel.leftAnchor.constraint(equalTo: nameTextField.leftAnchor))
        
        
        
        preferredBerthTypeButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(preferredBerthTypeButton.centerYAnchor.constraint(equalTo: berthPreferenceLabel.centerYAnchor))
        constraints.append(preferredBerthTypeButton.heightAnchor.constraint(equalTo:berthPreferenceLabel.heightAnchor))
        constraints.append(preferredBerthTypeButton.rightAnchor.constraint(equalTo: nameTextField.rightAnchor))
        constraints.append(preferredBerthTypeButton.widthAnchor.constraint(equalTo: nameTextField.widthAnchor,multiplier: 0.6))
        
        downWardImageView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(downWardImageView.centerYAnchor.constraint(equalTo: berthPreferenceLabel.centerYAnchor))
        constraints.append(downWardImageView.rightAnchor.constraint(equalTo: nameTextField.rightAnchor))
        constraints.append(downWardImageView.widthAnchor.constraint(equalToConstant: 16.5))
        
        prefferedBerthLineView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(prefferedBerthLineView.heightAnchor.constraint(equalToConstant: 1))
        constraints.append(prefferedBerthLineView.bottomAnchor.constraint(equalTo: preferredBerthTypeButton.bottomAnchor))
        constraints.append(prefferedBerthLineView.rightAnchor.constraint(equalTo: nameTextField.rightAnchor))
        constraints.append(prefferedBerthLineView.widthAnchor.constraint(equalTo: preferredBerthTypeButton.widthAnchor))
        prefferedBerthLineView.alpha = 0
        
        addPassengerButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(addPassengerButton.topAnchor.constraint(equalTo: prefferedBerthLineView.bottomAnchor,constant: 20))
        constraints.append(addPassengerButton.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(addPassengerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10))
        constraints.append(addPassengerButton.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.4))
        constraints.append(addPassengerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))

                      
        NSLayoutConstraint.activate(constraints)
    }
    
    func changeButtonToUpdate (){
        addPassengerButton.setTitle("Update", for: .normal)
        isToBeUpdated = true
        
    }

    
    func setDefaultValues (name:String,age:Int,gender:Gender,berthPreference : SeatType?){
        nameTextField.text = name
        ageTextField.text = "\(age)"
        
       
        
        switch gender {
        case .Male:
            genderSegmentedControl?.selectedSegmentIndex = 0
        case .Female:
            genderSegmentedControl?.selectedSegmentIndex = 1
        case .Trangender:
            genderSegmentedControl?.selectedSegmentIndex = 2
        }
        if let berthPreference = berthPreference {
            preferredBerthTypeButton.setTitle(berthPreference.rawValue, for: .normal)
        }
        
    }
}


extension UserDetailsReceiverTableViewCell :  UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 1{
            delegete?.nameTextFieldEndEditing(enteredText: textField.text ?? "")
        }
        else {
            delegete?.ageTextFieldEndEditing(enteredText: textField.text ?? "")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            ageTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    
}



