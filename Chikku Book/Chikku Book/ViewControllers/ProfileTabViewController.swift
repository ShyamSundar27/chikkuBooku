//
//  ProfileTabViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 12/09/22.
//

import UIKit

class ProfileTabViewController: UIViewController {
    
  
    
    let profileTabelView = UITableView(frame: .zero, style: .insetGrouped)
    
    let nameAndeMailheaderView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 130))
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        return label
        
    }()
    
    let emailLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemGreen
        return label
    }()
    
    
    let dbManager = DBManager.getInstance()
    
    var user : User =   DBManager.getInstance().getUserObject()!
    
    var savedPassengers : [(name:String,age:Int,gender:Gender,berthPreference:SeatType?,passengerNumber:Int)]  = []
    
    var showSavedPassenger = false
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        profileTabelView.tableHeaderView = nameAndeMailheaderView
        
        profileTabelView.delegate = self
        profileTabelView.dataSource = self
        

        registerCells()
        setViewValues()
        view.addSubview(profileTabelView)
        
        setConstraints()
        
    }
    
    func registerCells() {
        
        profileTabelView.register(ThemeChangerTableViewCell.self, forCellReuseIdentifier: ThemeChangerTableViewCell.identifier)
        profileTabelView.register(PassengerDetailsTableViewCell.self, forCellReuseIdentifier: PassengerDetailsTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
       
    }
    
    
    func setViewValues() {
       
        
        nameAndeMailheaderView.addSubview(nameLabel)
        nameAndeMailheaderView.addSubview(emailLabel)
        
        nameAndeMailheaderView.clipsToBounds = true
        
        nameAndeMailheaderView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameAndeMailheaderView.topAnchor,constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: nameAndeMailheaderView.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10),
            emailLabel.centerXAnchor.constraint(equalTo: nameAndeMailheaderView.centerXAnchor)
        ])
        
        
        nameLabel.text = user.name
        emailLabel.text = user.mail
        
        
        
       // nameAndeMailheaderView.backgroundColor = .systemGreen
        
        
    }
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        profileTabelView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(profileTabelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(profileTabelView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(profileTabelView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(profileTabelView.rightAnchor.constraint(equalTo: view.rightAnchor))
       
        profileTabelView.tableHeaderView!.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(profileTabelView.tableHeaderView!.topAnchor.constraint(equalTo: profileTabelView.topAnchor))
        constraints.append(profileTabelView.tableHeaderView!.widthAnchor.constraint(equalTo: profileTabelView.widthAnchor))
        constraints.append(profileTabelView.tableHeaderView!.centerXAnchor.constraint(equalTo: profileTabelView.centerXAnchor))
        constraints.append(profileTabelView.tableHeaderView!.heightAnchor.constraint(equalToConstant:130))

        NSLayoutConstraint.activate(constraints)
    }

    

}

extension ProfileTabViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        if section == 1 {
            
            
            if showSavedPassenger && savedPassengers.isEmpty {
                return 3
            }
            
            else if showSavedPassenger {
                return 2 + savedPassengers.count
            }
             
            
            return 1
        }
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            
            if indexPath.row == 0{
                let cell = UITableViewCell()
               
                let sourceLabel : UILabel = {
                    
                    let label = UILabel(frame: .zero)
                    label.textColor = .systemGray
                    label.text = "\(user.mobileNumber)"
                    label.sizeToFit()
                    return label
                }()
                
                cell.textLabel?.text = "Mobile Number"
                cell.accessoryView = sourceLabel
                cell.selectionStyle = .none
                return cell
                
            }
            
            if indexPath.row == 1 {
                let cell = UITableViewCell()
               
                cell.textLabel?.text = "Edit Profile"
                cell.accessoryType = .disclosureIndicator
                cell.selectionStyle = .none
                
                return cell
            }
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let cell = UITableViewCell()
                
                let downArrow : UIImageView = {
                    
                    let imageView = UIImageView(frame: .zero)
                    imageView.image = showSavedPassenger ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
                    imageView.tintColor = .systemGreen
                    imageView.sizeToFit()
                    return imageView
                }()
               
                cell.textLabel?.text = "Saved Passengers"
                cell.accessoryView = downArrow
                cell.selectionStyle = .none
                
                return cell
            }
            
            if (savedPassengers.isEmpty && indexPath.row == 2 ) || (!savedPassengers.isEmpty && indexPath.row == savedPassengers.count + 1){
                let cell = UITableViewCell()
                cell.textLabel?.text = "+ Add Passenger"
                
                if savedPassengers.count >= 5 {
                    cell.alpha = 0.3
                    cell.isUserInteractionEnabled = false
                    cell.textLabel?.textColor = .systemGreen.withAlphaComponent(0.4)
                }
                else{
                    cell.alpha = 1
                    cell.isUserInteractionEnabled = true
                    cell.textLabel?.textColor = .systemGreen
                }
                
                cell.textLabel?.textAlignment = .center
                return cell
            }
            
            if savedPassengers.isEmpty && indexPath.row == 1{
                
                let cell = UITableViewCell()
                cell.textLabel?.text = "No Passengers Are Added"
                cell.textLabel?.textColor = .systemGray
                cell.textLabel?.textAlignment = .left
                cell.textLabel?.font = .preferredFont(forTextStyle: .footnote)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: PassengerDetailsTableViewCell.identifier, for: indexPath) as! PassengerDetailsTableViewCell
                let passenger = savedPassengers[indexPath.row - 1 ]
                cell.setLabelValues(name: passenger.name, age: passenger.age, berthPreference: passenger.berthPreference?.rawValue ?? "No Preference", gender: passenger.gender, passengerNumber: passenger.passengerNumber)
                cell.delegate = self
                return cell
            }
            
            
        }
        
        
        
        if indexPath.section == 2 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: ThemeChangerTableViewCell.identifier, for: indexPath)
               
                cell.selectionStyle = .none
                
                return cell
            }
            
            if indexPath.row == 1 {
                let cell = UITableViewCell()
                cell.textLabel?.text = "Sign Out"
                cell.textLabel?.textColor = .systemRed
                cell.textLabel?.textAlignment = .center
                return cell
            }
            
           
            
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section ==  2 {
            return nil
        }
        
        if section == 1 {
            return nil
        }
        return "Profile Info"
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
           return 50
        }
        
        return UITableView.automaticDimension
    }
    
    
    
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 && !showSavedPassenger{
           return "Add/Edit Passengers info"
        }
        
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                
//                let nextVc = EditProfileViewController()
//
//
//                nextVc.hidesBottomBarWhenPushed = true
//
//                navigationController?.navigationBar.tintColor = .systemGreen
//
//
//
//                navigationController?.pushViewController(nextVc, animated: true)
                let presentVc = EditProfileViewController()
               
                presentVc.delegete = self
               
                let presentingNc = UINavigationController(rootViewController: presentVc)
                
                presentingNc.modalPresentationStyle = .pageSheet
                
                
                
                if let sheet = presentingNc.sheetPresentationController{
                    sheet.detents = [.large()]
                }
                self.present(presentingNc, animated: true)
               
            }
        }
        
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                
                
                if savedPassengers.isEmpty {
                    
                    savedPassengers = dbManager.retrieveSavedPassenger()
                }
                
                else {
                    savedPassengers = []
                }
                showSavedPassenger = !showSavedPassenger
                profileTabelView.reloadSections([1], with: .automatic)
            }
            
            if (savedPassengers.isEmpty && indexPath.row == 2 ) || (!savedPassengers.isEmpty && indexPath.row == savedPassengers.count + 1) {
                
                
               
                let presentVc = NewPassengerAddingViewController(nibName: nil, bundle: nil, coachType: nil,isVcForUpdating: false)
                presentVc.delegate = self
                
                presentVc.title = "Add Passenger Details"
                
                let presentingNc = UINavigationController(rootViewController: presentVc)
                
                presentingNc.modalPresentationStyle = .pageSheet
                
                
                
                if let sheet = presentingNc.sheetPresentationController{
                    sheet.detents = [.medium(),.large()]
                    sheet.prefersGrabberVisible = true
                }
                self.present(presentingNc, animated: true)
                
            }
            
            if !savedPassengers.isEmpty && (indexPath.row != 0 && indexPath.row != savedPassengers.count + 1){
                
                
                let presentVc = NewPassengerAddingViewController(nibName: nil, bundle: nil, coachType: nil,isVcForUpdating: true)
                presentVc.delegate = self
                
                presentVc.title = "Add Passenger Details"
                
                let presentingNc = UINavigationController(rootViewController: presentVc)
                
                presentingNc.modalPresentationStyle = .pageSheet
                
                let passenger = savedPassengers[indexPath.row - 1 ]
                presentVc.addDefaultValues(passengerDetails: passenger)
                
                
                
                if let sheet = presentingNc.sheetPresentationController{
                    sheet.detents = [.medium(),.large()]
                    sheet.prefersGrabberVisible = true
                }
                self.present(presentingNc, animated: true)
            }
        }
        
        if indexPath.section == 2 && indexPath.row == 1 {
            UserDefaults.standard.set(false, forKey: "isLogged")
            
            UserDefaults.standard.set("", forKey: "user")
            
            let signUpPageVc = UINavigationController(rootViewController: SignUpViewController())

            signUpPageVc.modalPresentationStyle = .fullScreen
            
            self.present(signUpPageVc, animated: true)
        }
        
    }
    
}

extension ProfileTabViewController : NewPassengerAddingViewControllerDelegete {
    
    
    func passengerInputValues(name: String, age: Int, gender: Gender, berthPreference: String,isToBeUpdated:Bool,passengerNumber:Int?) {
        
        if isToBeUpdated {
            dbManager.updateSavedPassenger(name: name, age: age, gender: gender, berthPreference: SeatType(rawValue: berthPreference), passengerNumber: passengerNumber!)
        }
            
        else{
            
            dbManager.insertSavedPassenger(name: name, age: age, gender: gender, berthPreference: SeatType(rawValue: berthPreference))
            
            print("hi")
            
        }
        savedPassengers = dbManager.retrieveSavedPassenger()
        
        profileTabelView.reloadSections([1], with: .automatic)
    }
    
    
}

extension ProfileTabViewController : PassengerDetailsTableViewCellDelegate {
    
    
    func deletePassenger(passengerNumber: Int) {
        
        dbManager.deleteSavedPasseger(passengerNumber: passengerNumber)
        
        savedPassengers = dbManager.retrieveSavedPassenger()
        profileTabelView.reloadSections([1], with: .automatic)
        
    }
    
    
    
}

extension ProfileTabViewController : EditProfileViewControllerDelegete {
    
    func doneButtonPressed() {
        
        print("hi")
        
        user = dbManager.getUserObject()!
        
        nameLabel.text = user.name
        emailLabel.text = user.mail
        
        profileTabelView.reloadData()
    }
}
