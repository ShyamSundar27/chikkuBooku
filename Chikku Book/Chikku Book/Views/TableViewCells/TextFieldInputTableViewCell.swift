//
//  PassengerMobileNumberTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 29/08/22.
//

import UIKit

class TextFieldInputTableViewCell: UITableViewCell {
    
    static let identifier = "PassengerMobileNumberTableViewCell"
    
    var nameIdentifier = ""
    
    
    
//let dataSource : MobileNumberReceiverTableViewCellDataSource? = nil
    
    weak var delegate : TextFieldInputTableViewCellDelegate? = nil
    
    let textFieldNameLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        //label.textColor = .systemGray
        return label
    }()
    let inputTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    let nameLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray.withAlphaComponent(0.6)
        return view
    }()
    
    let errorLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.numberOfLines = 0
        label.textColor = .systemRed
        return label
    }()
    
    var textFieldwidthAnchor : NSLayoutConstraint? = nil
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(textFieldNameLabel)
        contentView.addSubview(errorLabel)
        contentView.addSubview(inputTextField)
        inputTextField.addSubview(nameLineView)
        inputTextField.clipsToBounds = true

        inputTextField.delegate = self
        //errorLabel.text = "Your eTicket will be sent to \(mobileNumber)"
        self.tintColor = .systemGreen
        setConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setErrorValue (error : String){
        errorLabel.text = error
    }
    
    
    func setConstraints(){
        
        
        var constraints = [NSLayoutConstraint]()
        
        textFieldNameLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(textFieldNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15))
        constraints.append(textFieldNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(inputTextField.centerYAnchor.constraint(equalTo: textFieldNameLabel.centerYAnchor))
        constraints.append(inputTextField.leftAnchor.constraint(equalTo: textFieldNameLabel.rightAnchor,constant: 15))
//        constraints.append(inputTextField.widthAnchor.constraint(equalToConstant: 120))
        
        nameLineView.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(nameLineView.bottomAnchor.constraint(equalTo: inputTextField.bottomAnchor))
        constraints.append(nameLineView.leftAnchor.constraint(equalTo: inputTextField.leftAnchor))
        constraints.append(nameLineView.widthAnchor.constraint(equalTo: inputTextField.widthAnchor,constant: -2))
        constraints.append(nameLineView.heightAnchor.constraint(equalToConstant: 1))
        
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(errorLabel.topAnchor.constraint(equalTo: inputTextField.bottomAnchor,constant: 5))
        constraints.append(errorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5))
        constraints.append(errorLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 10))
        
        
        NSLayoutConstraint.activate(constraints)
    }
    func endEditingInNameField(){
        
        inputTextField.resignFirstResponder()
        inputTextField.endEditing(true)
        
    }
    
    
    func setTextFieldValues(labelName : String, defaultText : String, keyBoardType:UIKeyboardType,widthOfTextField : Int){
        inputTextField.text = defaultText
        textFieldNameLabel.text = labelName
        inputTextField.keyboardType = keyBoardType
        self.nameIdentifier = labelName
        
        if labelName == "Mobile Number"{
            textFieldwidthAnchor = inputTextField.widthAnchor.constraint(equalToConstant: CGFloat(150))
            textFieldwidthAnchor!.isActive = true
        }
        else if labelName == "Preffered Coach Number"{
            textFieldwidthAnchor = inputTextField.widthAnchor.constraint(equalToConstant: CGFloat(100))
            textFieldwidthAnchor!.isActive = true
        }
        
    }
    
    func textFieldValue () -> String? {
        return inputTextField.text
    }
    
}

extension TextFieldInputTableViewCell : UITextFieldDelegate
{
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        delegate?.editingEnded(enteredText: textField.text  ?? "",identifier: nameIdentifier)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        inputTextField.resignFirstResponder()
        inputTextField.endEditing(true)
    
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        delegate?.startsEditing()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        textFieldwidthAnchor!.isActive = false
    }
    
}
