//
//  SignUpViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 16/09/22.
//

import UIKit

class SignUpViewController: UITableViewController {
    
//    let signUpPageTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let logoImageView : UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150))
        imageView.image = UIImage(named: "ChikkuBookAll")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor =  .clear
        imageView.isOpaque = false
        return imageView
    }()
    
    
   
    
    let nameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.layer.shadowOffset = CGSize(width: 0, height: 2);
        textField.layer.shadowColor = UIColor.systemGray.cgColor;
        textField.layer.shadowRadius = 2;
        textField.layer.shadowOpacity = 0.2;
        textField.tag = Numbers.one.rawValue
        textField.tintColor = .systemGreen
        textField.layer.borderColor = UIColor.systemGreen.cgColor
        textField.keyboardType = .alphabet
        textField.textContentType = .name
        textField.autocorrectionType = .no

        return textField
    }()
    
    var nameError: String? = nil
    
    let phoneTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Mobile Number"
        textField.borderStyle = .roundedRect
        textField.layer.shadowOffset = CGSize(width: 0, height: 2);
        textField.layer.shadowColor = UIColor.systemGray.cgColor;
        textField.layer.shadowRadius = 2;
        textField.layer.shadowOpacity = 0.2;
        textField.tag = Numbers.two.rawValue
        textField.tintColor = .systemGreen
        textField.keyboardType = .phonePad
        textField.autocorrectionType = .no
        


        return textField
    }()
    
    var phoneError: String? = nil
    
    let mailTextField : UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.placeholder = "Mail"
        textField.borderStyle = .roundedRect
        textField.layer.shadowOffset = CGSize(width: 0, height: 2);
        textField.layer.shadowColor = UIColor.systemGray.cgColor;
        textField.layer.shadowRadius = 2;
        textField.layer.shadowOpacity = 0.2;
        textField.tag = Numbers.three.rawValue
        textField.textContentType = .emailAddress

        textField.tintColor = .systemGreen
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no

        return textField
    }()
    
    var mailError: String? = nil
    
    let passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password "
        textField.borderStyle = .roundedRect
        textField.layer.shadowOffset = CGSize(width: 0, height: 2);
        textField.layer.shadowColor = UIColor.systemGray.cgColor;
        textField.layer.shadowRadius = 2;
        textField.layer.shadowOpacity = 0.2;
        textField.tag = Numbers.four.rawValue
        textField.tintColor = .systemGreen
        textField.textContentType = .newPassword
        textField.isSecureTextEntry = true
//        textField.keyboardType = .alphabet
        textField.textContentType = .oneTimeCode
        textField.autocorrectionType = .no
        return textField
    }()
    
    var passwordError: String? = nil
    
    let signUpButton : UIButton = {
        let button =  UIButton()
        button.backgroundColor = .systemGreen
        let label = UILabel()
        label.text = "Sign Up"
        label.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                                      
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                
        ])
        button.layer.cornerRadius = 7
        label.textColor = .white
        
        
        return button
    }()
    
    

    let doYouAlreadyHaveAnAccountLabel : UILabel = {
        let label = UILabel()
        label.text = "Do you alredy have an account ?"
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.systemGreen, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .footnote)
        return button
    }()

    let dbManager = DBManager.getInstance()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //view.addSubview(signUpPageTableView)
        tableView = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .systemBackground
        tableView.tableHeaderView = logoImageView
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .systemBackground
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.automatic

        
        nameTextField.delegate = self
        
        phoneTextField.delegate = self
        
        mailTextField.delegate = self
        
        passwordTextField.delegate = self
        
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        

        nameTextField.becomeFirstResponder()
        setConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @objc func loginButtonClicked() {
        
        let navVc = UINavigationController(rootViewController: LoginPageViewController())
        
        navVc.modalPresentationStyle = .fullScreen
        self.present(navVc, animated: true)
        
        
        
    }
    
    @objc func signUpButtonClicked () {
        
        print("hi")
        
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        mailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
       
        tableView.beginUpdates()
        
        if nameTextField.text!.isEmpty {
            nameError = "Name is Required"
        }
        if phoneTextField.text!.isEmpty {
            phoneError = "Mobile Number is Required"
        }
        
        if mailTextField.text!.isEmpty {
            mailError = "Mail is Required"
        }
        
        if passwordTextField.text!.isEmpty {
            passwordError = "Password is Required"
        }
        
        tableView.endUpdates()
        
        tableView.reloadData()
        let isNoError = (nameError == nil) && (phoneError == nil) && (mailError == nil) && (passwordError == nil)
        
        print(isNoError)
        if isNoError {
            
            let users = dbManager.getUsers()
            
            var isAccountAlreadyExists = false
            
            for user in users {
                if user.mobileNumber == UInt64(phoneTextField.text!) {
                    let alertController = UIAlertController(title: nil, message: "Mobile Number Already Exists", preferredStyle: .alert)
                        
                    let okButton = UIAlertAction(title: "OK", style: .cancel)
                        
                    alertController.addAction(okButton)
                        
                    alertController.view.tintColor = .systemGreen
                    
                    present(alertController, animated: true)
                    
                    isAccountAlreadyExists = true
                    
                    break
                }
                 
                else if user.mail == (mailTextField.text!){
                    let alertController = UIAlertController(title: nil, message: "Mail already Exists", preferredStyle: .alert)
                        
                    let okButton = UIAlertAction(title: "OK", style: .cancel)
                        
                    alertController.addAction(okButton)
                        
                    alertController.view.tintColor = .systemGreen
                        
                    present(alertController, animated: true)
                    
                    isAccountAlreadyExists = true
                    
                    break
                }
                

            
            }
            if !isAccountAlreadyExists {
                let userId = generateUserId()
                
                if nameTextField.text!.isEmpty {
                    textFieldDidEndEditing(nameTextField)
                    return
                }
                
                else if mailTextField.text!.isEmpty {
                    textFieldDidEndEditing(mailTextField)
                    return
                }
                
                else if phoneTextField.text!.isEmpty {
                    textFieldDidEndEditing(phoneTextField)
                    return
                }
                
                else if passwordTextField.text!.isEmpty {
                    textFieldDidEndEditing(passwordTextField)
                    return
                }
                

                
                
                let user = User(name: nameTextField.text!, userName: userId, mail: mailTextField.text!, mobileNumber:UInt64( phoneTextField.text!)!)
                
                UserDefaults.standard.set(user.userName, forKey: "user")
                
                dbManager.insertUserDetails(user: user, password: passwordTextField.text!)
                
                let tabBarController = UITabBarController()
                let homePageVc = UINavigationController(rootViewController: HomePageViewController())
                let myTransactionsVc = UINavigationController(rootViewController: MyBookingsViewController())
                let myProfileVc = UINavigationController(rootViewController: ProfileTabViewController())


                homePageVc.tabBarItem.image = UIImage(systemName: "house")

                myTransactionsVc.title = "My Bookings"
                myTransactionsVc.tabBarItem.image = UIImage(systemName: "note.text")

                myProfileVc.title = "My Profile"
                myProfileVc.tabBarItem.image = UIImage(systemName: "person.fill")

                tabBarController.setViewControllers([homePageVc,myTransactionsVc,myProfileVc], animated: true)
                tabBarController.tabBar.backgroundColor = .systemBackground
                let rootViewController = tabBarController

                tabBarController.tabBar.tintColor = .systemGreen
                
                tabBarController.modalPresentationStyle = .fullScreen
                
                self.present(rootViewController, animated: true)
                
                UserDefaults.standard.set(true, forKey: "isLogged")
                
                
            }
        }
        
        
  
    }
    


    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        

        
        tableView.tableHeaderView!.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(tableView.tableHeaderView!.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor))
        constraints.append(tableView.tableHeaderView!.widthAnchor.constraint(equalTo: tableView.widthAnchor))
        constraints.append(tableView.tableHeaderView!.centerXAnchor.constraint(equalTo: tableView.centerXAnchor))
        constraints.append(tableView.tableHeaderView!.heightAnchor.constraint(equalToConstant:130))
        
        tableView.tableHeaderView!.backgroundColor = .systemBackground

        
        NSLayoutConstraint.activate(constraints)
    }
    
    func getTextField (tag:Int) -> UITextField {
        
        
        switch tag {
            
        case Numbers.one.rawValue :
            return nameTextField
            
        case Numbers.two.rawValue :
            return phoneTextField
            
        case Numbers.three.rawValue :
            return mailTextField
            
        case Numbers.four.rawValue :
            return passwordTextField
            
        default:
            return UITextField()
        }
    }
    
    
    func setTextFieldConstraints (contentView:UIView,textField:UIView){
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                      
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                      
            textField.heightAnchor.constraint(equalToConstant: 50),
                                      
            textField.widthAnchor.constraint(equalTo: contentView.widthAnchor ,multiplier: 0.9)
        ])
    }
   
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 4 {
            let cell = UITableViewCell()
            
            let button = signUpButton
            
            cell.contentView.addSubview(button)
            
            cell.contentView.addSubview(loginButton)
            
            cell.contentView.addSubview(doYouAlreadyHaveAnAccountLabel)
            
            cell.backgroundColor = .systemBackground
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            loginButton.translatesAutoresizingMaskIntoConstraints = false
            
            doYouAlreadyHaveAnAccountLabel.translatesAutoresizingMaskIntoConstraints = false
            
            cell.selectionStyle = .none
            
            
            let contentView = cell.contentView
            
            
            
            NSLayoutConstraint.activate([
                
                button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                          
                button.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 10),
                                          
                button.heightAnchor.constraint(equalToConstant: 50),
                                          
                button.widthAnchor.constraint(equalTo: contentView.widthAnchor ,multiplier: 0.7),
                
                doYouAlreadyHaveAnAccountLabel.topAnchor.constraint(equalTo: button.bottomAnchor,constant: 10),
                                          
                doYouAlreadyHaveAnAccountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                          
                loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
                                          
                loginButton.centerXAnchor.constraint(equalTo: doYouAlreadyHaveAnAccountLabel.centerXAnchor),
                                          
                loginButton.topAnchor.constraint(equalTo: doYouAlreadyHaveAnAccountLabel.bottomAnchor,constant: 3),
                
                                          
//                doYouAlreadyHaveAnAccountLabel.widthAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15)
            ])
            
            return cell
        }
        
        
        let cell = UITableViewCell()
        
        let textField = getTextField(tag: indexPath.section + 1)
        
        cell.contentView.addSubview(textField)
        
        cell.backgroundColor = .systemBackground
        
        setTextFieldConstraints(contentView: cell.contentView, textField: textField)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 4 {
            return UITableView.automaticDimension
        }
        return 50
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return nameError
        case 1:
            return phoneError
        case 2:
            return mailError
        case 3:
            return passwordError
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        
        
        if let view = view as? UITableViewHeaderFooterView {

            view.textLabel?.textColor = .systemRed

        }
    }
    
    
    func generateUserId () -> String {
        let randomString = UUID().uuidString
        
        for user in dbManager.getUsers() {
            if user.userName == randomString {
                let  _ = generateUserId()
            }
        }
        
        return randomString
    }
    
   
}



extension SignUpViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag < 4{
            getTextField(tag: textField.tag + 1).becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        switch textField.tag{
        case 1:
            tableView.beginUpdates()
            
            
            if textField.text!.isEmpty {
                nameError = nil//on clicking button
            }
            else if !Validator.shared.validateName(text: textField.text!) {
                nameError = "Name Should Contain Only Alphabets in Range (3-30)"
            }
            
            else {
                nameError = nil
            }
            tableView.endUpdates()
            
            
            
            tableView.reloadSections([0], with: .none)
            
        case 2:
            tableView.beginUpdates()
            if textField.text!.isEmpty {
                phoneError = nil
            }
            else if !Validator.shared.validateMobileNumber(text: textField.text!) {
                phoneError = """
                            ✷ Mobile Number Should Contain 10 Digit Numbers Only
                            ✷ Mobile Number should start between (6-9)
                            """
            }
            else {
                phoneError = nil
            }
            tableView.endUpdates()
            
            tableView.reloadSections([1], with: .none)
            
        case 3:
            tableView.beginUpdates()
            if textField.text!.isEmpty {
                mailError = nil
            }
            else if !Validator.shared.validateMail(text: textField.text!) {
                mailError = "Enter valid Mail"
            }
            else {
                mailError = nil
            }
            tableView.endUpdates()
            
            tableView.reloadSections([2], with: .none)
        case 4:
            tableView.beginUpdates()
            if textField.text!.isEmpty {
                passwordError = nil
            }
            else if !Validator.shared.validatePassword(text: textField.text!) {
                passwordError = """
                                ✷ Password should contain atleast 8 characters
                                ✷ Password should contain atlaeat one Uppercase, Lowercase, Special character in each
                                """
            }
            else {
                passwordError = nil
            }
            tableView.endUpdates()
            
            tableView.reloadSections([3], with: .none)
        default:
            return
        }
    }
    
}
