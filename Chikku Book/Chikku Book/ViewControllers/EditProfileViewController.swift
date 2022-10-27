//
//  EditProfileViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 13/09/22.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    
    
    
    
    let editProfileTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let user : User =   DBManager.getInstance().getUserObject()!
    
    weak var delegete : EditProfileViewControllerDelegete? = nil
    
    lazy var name = user.name
    
    lazy var phone  = "\(user.mobileNumber)"
    
    lazy var mail = user.mail
    
    let nameTextField : UITextField = {
        let textField = UITextField()
        textField.keyboardType = .alphabet
        textField.tag = Numbers.one.rawValue
        textField.tintColor = .systemGreen
        
        return textField
    }()
    
    let mobileTextField : UITextField = {
        let textField = UITextField()
        textField.keyboardType = .phonePad
        textField.tag = Numbers.two.rawValue
        textField.tintColor = .systemGreen
        
        return textField
    }()

    let mailTextField : UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.tag = Numbers.three.rawValue
        textField.tintColor = .systemGreen
        
        return textField
    }()
    
    
    var nameFieldErrorMessage : String? = nil
    
    var phoneFieldErrorMessage : String? = nil
    
    var mailFieldErrorMessage : String? = nil
    
    let dbManager = DBManager.getInstance()
    
    lazy var rightBarButton: UIButton = {
        let button = UIButton()

        
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
       
        button.addTarget(self, action: #selector(rightBarButtonClicked), for: .touchUpInside)
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(editProfileTableView)
        self.title = "Edit Profile"
        editProfileTableView.delegate = self
        editProfileTableView.dataSource = self
        editProfileTableView.sectionHeaderHeight = 45
        setConstraints()
        view.backgroundColor = .systemBackground
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .systemRed
        
       
        

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
        disableRightBarButton()
        
        
        navigationItem.rightBarButtonItem?.tintColor = .systemGray.withAlphaComponent(0.29)
    
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        mobileTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        mailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)
        
        
        
        
    }
    
    func setConstraints() {
        
        var constraints = [NSLayoutConstraint]()
        
        
        editProfileTableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(editProfileTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(editProfileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(editProfileTableView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(editProfileTableView.rightAnchor.constraint(equalTo: view.rightAnchor))

        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func rightBarButtonClicked (){
        
        dbManager.updateUserDetails(user: User(name: name, userName: user.userName, mail: mail, mobileNumber: UInt64(phone)!))
        
        delegete?.doneButtonPressed()
        dismiss(animated: true , completion: nil)
        
        
        
    }
    
    @objc func leftBarButtonClicked (){
        dismiss(animated: true , completion: nil)
    }
    

    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
            
            
        case Numbers.one.rawValue:
            
            
            name = textField.text!
            if textField.text != user.name {
                
                
                if textField.text!.isEmpty {
                   
                    editProfileTableView.beginUpdates()
                    nameFieldErrorMessage = "Name is Required"
                    editProfileTableView.endUpdates()
                    
                    editProfileTableView.reloadSections([0], with: .none)
                    textField.becomeFirstResponder()
                
                    disableRightBarButton()
                    return
                }
                
                
                else if Validator.shared.validateName(text: name){
                    
                    
                    if nameFieldErrorMessage != nil {
                        
                        editProfileTableView.beginUpdates()
                        nameFieldErrorMessage = nil
                        editProfileTableView.endUpdates()
                        
                        editProfileTableView.reloadSections([0], with: .none)
                        textField.becomeFirstResponder()
                    }
                    
                    if phoneFieldErrorMessage == nil && mailFieldErrorMessage == nil {
                       enableRightBarButton()
                        
                    }
                    else{
                        disableRightBarButton()
                        
                    }
                    
                }
                
                else {
                    editProfileTableView.beginUpdates()
                    
                    

                    nameFieldErrorMessage = """
                *Enter a Valid Name
                 Name Should Conatain Only Alphabets
                 Name Should have Characters between 3-30
                """
                    
                    editProfileTableView.endUpdates()
                    
                    editProfileTableView.reloadSections([0], with: .none)
                    
                    textField.becomeFirstResponder()
                    
                    disableRightBarButton()
                    

                }
                
            }
            else {
                
                
                if mobileTextField.text == "\(user.mobileNumber)" && mailTextField.text == user.mail {
                    disableRightBarButton()
                }
                else{
                    enableRightBarButton()
                }

                
                
                editProfileTableView.beginUpdates()
                nameFieldErrorMessage = nil
                editProfileTableView.endUpdates()
                
                
                editProfileTableView.reloadSections([0], with: .none)
                textField.becomeFirstResponder()
                                
                
            }
            
        case Numbers.two.rawValue:
            
            
            phone = textField.text!
            
    
            if textField.text != "\(user.mobileNumber)" {
                
                print(textField.text!.isEmpty)
                
                if textField.text!.isEmpty {
                   
                    editProfileTableView.beginUpdates()
                    
                    phoneFieldErrorMessage = "Phone Number is Required"
    
                    editProfileTableView.endUpdates()
                    
                    
                    editProfileTableView.reloadSections([1], with: .none)
                    
                    textField.becomeFirstResponder()
                
                    disableRightBarButton()
                    return
                }
                
                else if Validator.shared.validateMobileNumber(text: phone){
                    
                    if phoneFieldErrorMessage != nil {
                        
                        editProfileTableView.beginUpdates()
                        
                        phoneFieldErrorMessage = nil

                        editProfileTableView.endUpdates()
                        
                        editProfileTableView.reloadSections([1], with: .none)
                        
                        textField.becomeFirstResponder()
                    }
                    
                    if nameFieldErrorMessage == nil && mailFieldErrorMessage == nil {
                        
                       enableRightBarButton()
                        
                    }
                    else{
                        
                        disableRightBarButton()
                        
                    }
                    
                }
                else {
                    
                    
                    editProfileTableView.beginUpdates()
                    
                    

                    phoneFieldErrorMessage = """
                            ✷ Mobile Number should contain Number
                            ✷ Mobile Number should start between (6-9)
                            """
                    
                    editProfileTableView.endUpdates()
                    
                    editProfileTableView.reloadSections([1], with: .none)
                    
                    textField.becomeFirstResponder()
                    
                    disableRightBarButton()
                }
                
            }
            else {
                
                if nameTextField.text == "\(user.name)" && mailTextField.text == user.mail {
                    disableRightBarButton()
                }
                else{
                    enableRightBarButton()
                }
               
                editProfileTableView.beginUpdates()
                
                phoneFieldErrorMessage = nil
                
                editProfileTableView.endUpdates()
                
                
                editProfileTableView.reloadSections([1], with: .none)
                
                textField.becomeFirstResponder()
                
               
               
            }
            
            
        case Numbers.three.rawValue :
            
            mail = textField.text!
            
            
            if textField.text != user.mail {
                
                print(textField.text!.isEmpty)
                
                if textField.text!.isEmpty {
                   
                    editProfileTableView.beginUpdates()
                    
                    mailFieldErrorMessage = "Mail is Required"
    
                    editProfileTableView.endUpdates()
                    
                    editProfileTableView.reloadSections([2], with: .none)
                    
                    textField.becomeFirstResponder()
                
                    disableRightBarButton()
                    
                    return
                }
                
                else if Validator.shared.validateMail(text: mail){
                    
                    if mailFieldErrorMessage != nil {
                        
                        editProfileTableView.beginUpdates()
                        
                        mailFieldErrorMessage = nil

                        editProfileTableView.endUpdates()
                        
                        editProfileTableView.reloadSections([2], with: .none)
                        
                        textField.becomeFirstResponder()
                    }
                    
                    if nameFieldErrorMessage == nil && phoneFieldErrorMessage == nil {
                        
                       enableRightBarButton()
                        
                    }
                    else{
                        
                        disableRightBarButton()
                        
                    }
                    
                }
                else {
                    
                    
                    editProfileTableView.beginUpdates()
                    
                    mailFieldErrorMessage = "* Enter a Valid Mail "
                    
                    editProfileTableView.endUpdates()
                    
                    editProfileTableView.reloadSections([2], with: .none)
                    
                    textField.becomeFirstResponder()
                    
                    disableRightBarButton()
                }
                
            }
            else {
                
                if nameTextField.text == "\(user.name)" && mobileTextField.text == "\(user.mobileNumber)"  {
                    disableRightBarButton()
                }
                else{
                    enableRightBarButton()
                }
               
                editProfileTableView.beginUpdates()
                
                mailFieldErrorMessage = nil
                
                editProfileTableView.endUpdates()
                
                
                editProfileTableView.reloadSections([2], with: .none)
                
                textField.becomeFirstResponder()
                
               
               
            }
            
            
            
        default:
            return
        }
    }
}


extension EditProfileViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            
            let cell = UITableViewCell()
           
            let contentView = cell.contentView
            
            setTextFieldConstraints(contentView: contentView, textField: nameTextField)
            
            cell.selectionStyle = .none
            
            nameTextField.text = name
            
            
            
            return cell
               
        }
        
        
        if indexPath.section == 1{
            
            
            let cell = UITableViewCell()
           
            let contentView = cell.contentView
            
            setTextFieldConstraints(contentView: contentView, textField: mobileTextField)
            
            cell.selectionStyle = .none
            
            mobileTextField.text = phone
    
            return cell
               
        }
        
        
        if indexPath.section == 2 {
            
            let cell = UITableViewCell()
           
            let contentView = cell.contentView
            
           setTextFieldConstraints(contentView: contentView, textField: mailTextField)
            
            cell.selectionStyle = .none
            
            mailTextField.text = mail
           
            return cell
               
        }
       
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        print("hello")
//
//
//        let frame = tableView.frame
//        print(tableView.frame.width)
//        let height:CGFloat = 45
//
//        let editButton = UIButton()
//        editButton.tag = section
//        editButton.setTitle("Edit", for: .normal)
//        editButton.setTitleColor(.systemGreen, for: .normal)
//
//        let titleLabel = UILabel(frame: CGRect(x: 20, y: 10, width: 200, height: 30))
//
//
//
//        titleLabel.font = .preferredFont(forTextStyle: .footnote)
//        titleLabel.textColor = .systemGray
//
//
//
//        let headerView = UIView(frame: CGRect(x: 0 , y: 0, width: frame.size.width, height: height))
//
//        headerView.addSubview(editButton)
//        headerView.addSubview(titleLabel)
//
//        editButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            editButton.rightAnchor.constraint(equalTo: headerView.rightAnchor,constant: -20),
//            editButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
//            editButton.heightAnchor.constraint(equalToConstant: 30),
//            editButton.widthAnchor.constraint(equalToConstant:  60)
//
//
//        ])
//
//        if section == 0 {
//            titleLabel.text = "NAME"
//        }
//        if section == 1 {
//            titleLabel.text = "PHONE NUMBER"
//        }
//        if section == 2 {
//            titleLabel.text = "E-MAIL"
//        }
//        if section == 3 {
//            titleLabel.text = "USER NAME"
//        }
//        titleLabel.textAlignment = .left
//        editButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
//
//        return headerView
//
//    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
       // return "Name"
        
        
        if section == 0 {
            return "Name"
        }
        
        if section == 1 {
            return "Phone Number"
        }
        
        if section == 2 {
            return "E-MAIL"
        }
        
        return nil
    }
    
    
    
    func setTextFieldConstraints (contentView : UIView,textField:UITextField){
        
        contentView.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                                      
            textField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
                                      
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
                                      
            textField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
        
        
    }
    
    
    func disableRightBarButton () {
        
        rightBarButton.setTitleColor(UIColor.systemGray, for: .normal)
        rightBarButton.isUserInteractionEnabled = false
        rightBarButton.alpha = 0.4
    }
    
    func enableRightBarButton () {
        rightBarButton.setTitleColor(.systemGreen, for: .normal)
        rightBarButton.alpha = 1
        rightBarButton.isUserInteractionEnabled = true
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        
        if section == 0 {
            return nameFieldErrorMessage
        }
        
        else if section == 1 {
            return  phoneFieldErrorMessage
        }
        
        return mailFieldErrorMessage
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        
        if let view = view as? UITableViewHeaderFooterView {
            
            view.textLabel?.textColor = .systemRed
        }
        
        
    }

}


