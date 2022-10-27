//
//  LoginPageViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 16/09/22.
//

import UIKit

class LoginPageViewController: UITableViewController {
    
    let logoImageView : UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 150))
        imageView.image = UIImage(named: "ChikkuBookAll")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor =  .clear
        imageView.isOpaque = false
        return imageView
    }()
    
    
   
    
    var passwordTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.layer.shadowOffset = CGSize(width: 0, height: 2);
        textField.layer.shadowColor = UIColor.systemGray.cgColor;
        textField.layer.shadowRadius = 2;
        textField.layer.shadowOpacity = 0.2;
        textField.tag = Numbers.two.rawValue
        textField.tintColor = .systemGreen
        textField.layer.borderColor = UIColor.systemGreen.cgColor
        textField.isSecureTextEntry = true
        textField.keyboardType = .asciiCapable
        textField.autocorrectionType = .no
        return textField
    }()
    
    var passwordError : String? = nil
    
    
    
    let mailTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Mail"
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.layer.shadowOffset = CGSize(width: 0, height: 2);
        textField.layer.shadowColor = UIColor.systemGray.cgColor;
        textField.layer.shadowRadius = 2;
        textField.layer.shadowOpacity = 0.2;
        textField.tag = Numbers.one.rawValue
        textField.tintColor = .systemGreen
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        return textField
    }()
    
    var mailError : String? = nil
    
    let loginButton : UIButton = {
        let button =  UIButton()
        button.backgroundColor = .systemGreen
        let label = UILabel()
        label.text = "Log In"
        
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
        label.text = "Do you already have an account ?"
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    let signUpButton : UIButton = {
        let button = UIButton()
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(UIColor.systemGreen, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .footnote)
        return button
    }()
    
    let dbManager = DBManager.getInstance()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView = UITableView (frame: .zero, style: .grouped)
       
        tableView.backgroundColor = .systemBackground
        tableView.tableHeaderView = logoImageView
        
        setConstraints()
        
        signUpButton.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        
        loginButton.addTarget(self, action: #selector(loginClicked), for: .touchUpInside)

    }
    
    
    
    
    @objc func signUpClicked () {
        self.dismiss(animated: true)
    }
    
    
    @objc func loginClicked() {
        
    
        if mailTextField.text!.isEmpty {
            tableView.beginUpdates()
            
            mailError = "Mail is Required"
            
            tableView.endUpdates()
            
            
            
            tableView.reloadSections([0], with: .none)
            
            return
        }
        
        else if passwordTextField.text!.isEmpty {
            tableView.beginUpdates()
            
            
           
            passwordError = "Password is Required"
            
            tableView.endUpdates()
            
            
            
            tableView.reloadSections([1], with: .none)
            
            return
        }
        
        else {
            let userName = dbManager.getUserName(mail: mailTextField.text!)
            
            if userName.isEmpty {
                let alertController = UIAlertController(title: nil, message: "Mail not regsitered", preferredStyle: .alert)
                    
                let okButton = UIAlertAction(title: "OK", style: .cancel)
                
                
                    
                alertController.addAction(okButton)
                    
                alertController.view.tintColor = .systemGreen
                
                present(alertController, animated: true)
            }
            
            else {
                let userPassword = dbManager.getPassword(userName: userName)
                
                if userPassword == passwordTextField.text! {
                    
                    UserDefaults.standard.set(true, forKey: "isLogged")
                    
                    UserDefaults.standard.set(dbManager.getUserName(mail:mailTextField.text!), forKey: "user")
                    
                    
                    
                    
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
                    
                   
                }
                
                else {
                    let alertController = UIAlertController(title: nil, message: "Enter Correct Password", preferredStyle: .alert)
                        
                    let okButton = UIAlertAction(title: "OK", style: .cancel)
                    
                    
                    alertController.addAction(okButton)
                        
                    alertController.view.tintColor = .systemGreen
                    
                    present(alertController, animated: true)
                }
            }
        }
    }
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        
        tableView.separatorColor = .systemBackground
        
        
        
        tableView.tableHeaderView!.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(tableView.tableHeaderView!.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor))
        constraints.append(tableView.tableHeaderView!.widthAnchor.constraint(equalTo: tableView.widthAnchor))
        constraints.append(tableView.tableHeaderView!.centerXAnchor.constraint(equalTo: tableView.centerXAnchor))
        constraints.append(tableView.tableHeaderView!.heightAnchor.constraint(equalToConstant:130))
        
        tableView.tableHeaderView!.backgroundColor = .systemBackground

        
        NSLayoutConstraint.activate(constraints)
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
    func getTextField (tag:Int) -> UITextField {
        
        
        switch tag {
            
        case Numbers.one.rawValue :
            return mailTextField
            
        case Numbers.two.rawValue :
            return passwordTextField
            
        default:
            return UITextField()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2{
            let cell = UITableViewCell()
            
            let button = loginButton
            
            cell.contentView.addSubview(button)
            
            cell.contentView.addSubview(signUpButton)
            
            cell.contentView.addSubview(doYouAlreadyHaveAnAccountLabel)
            
            cell.backgroundColor = .systemBackground
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            signUpButton.translatesAutoresizingMaskIntoConstraints = false
            
            doYouAlreadyHaveAnAccountLabel.translatesAutoresizingMaskIntoConstraints = false
            
            
            let contentView = cell.contentView
            
            
            
            NSLayoutConstraint.activate([
                
                button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                          
                button.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 10),
                                          
                button.heightAnchor.constraint(equalToConstant: 50),
                                          
                button.widthAnchor.constraint(equalTo: contentView.widthAnchor ,multiplier: 0.7),
                
                doYouAlreadyHaveAnAccountLabel.topAnchor.constraint(equalTo: button.bottomAnchor,constant: 10),
                                          
                doYouAlreadyHaveAnAccountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                          
                signUpButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
                                          
                signUpButton.centerXAnchor.constraint(equalTo: doYouAlreadyHaveAnAccountLabel.centerXAnchor),
                                          
                signUpButton.topAnchor.constraint(equalTo: doYouAlreadyHaveAnAccountLabel.bottomAnchor,constant: 3),
                
                                          
//                doYouAlreadyHaveAnAccountLabel.widthAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15)
            ])
            
            
            cell.selectionStyle = .none
            
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
        if indexPath.section == 2 {
            return UITableView.automaticDimension
        }
        return 65
    }
    
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return mailError
        case 1:
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
}
