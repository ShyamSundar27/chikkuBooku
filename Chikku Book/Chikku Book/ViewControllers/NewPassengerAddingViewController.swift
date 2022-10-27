//
//  NewPassengerAddingViewController.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 22/08/22.
//

import UIKit

class NewPassengerAddingViewController: UIViewController {
    
    
    
    
    let enterPassengerDetailsTableView = UITableView()
    
    var selectedBerthType : SeatType? = nil
    
    let coachType  : CoachType?
    
    let isVcForUpdating : Bool
    
    var isDefaultValuesSet : Bool = false
    
    

    var passengerDetails : (name:String,age:Int,gender:Gender,berthPreference:SeatType?,passengerNumber:Int)? = nil
    
    
    weak var delegate : NewPassengerAddingViewControllerDelegete? = nil
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?,coachType:CoachType?,isVcForUpdating:Bool) {
        
       
        self.coachType = coachType
        
        self.isVcForUpdating = isVcForUpdating
       
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        
        
        enterPassengerDetailsTableView.register(UserDetailsReceiverTableViewCell.self, forCellReuseIdentifier: UserDetailsReceiverTableViewCell.identifier)
        
        enterPassengerDetailsTableView.delegate = self
        enterPassengerDetailsTableView.dataSource = self
        
        view.addSubview(enterPassengerDetailsTableView)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .systemRed
        
      
        navigationItem.rightBarButtonItem?.tintColor = .systemGreen
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        setConstraints()
        
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    @objc func leftBarButtonClicked (){
        dismiss(animated: true , completion: nil)
    }
    
    
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        
        enterPassengerDetailsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(enterPassengerDetailsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(enterPassengerDetailsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(enterPassengerDetailsTableView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10))
        constraints.append(enterPassengerDetailsTableView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10))
        
        
        NSLayoutConstraint.activate(constraints)
    }

    
    func addDefaultValues (passengerDetails : (name:String, age:Int, gender:Gender, berthPreference:SeatType?, passengerNumber:Int)) {
        
        self.passengerDetails = passengerDetails
        
        
    }
    
   
}


extension NewPassengerAddingViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailsReceiverTableViewCell.identifier, for: indexPath) as! UserDetailsReceiverTableViewCell
        cell.setSelectedBerthType(berthType: selectedBerthType)
        cell.delegete = self
        
        if isVcForUpdating {
            
            
            if !isDefaultValuesSet{
                cell.changeButtonToUpdate()
                
                cell.setDefaultValues(name: passengerDetails!.name, age: passengerDetails!.age, gender: passengerDetails!.gender,berthPreference: passengerDetails!.berthPreference)
                
                isDefaultValuesSet = true
            }
            
           
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    
}

extension NewPassengerAddingViewController : UserDetailsReceiverTableViewCellDelegate , SelectorViewDelegate,SelectorViewDataSource{
    
    
    
    func presentBerthTypeSelector (){
        

        let vc  = SelectorViewController(nibName: nil, bundle: nil, identifier: "BerthType")
        vc.dataSource = self
        vc.delegate = self
        vc.preferredContentSize = CGSize(width: 300,height: 250)
        
        
        
        let editRadiusAlert = UIAlertController(title: "Choose Berth Preference", message: "", preferredStyle: .alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        let doneAction = UIAlertAction(title: "Done", style: .default, handler: {  _ in
            
            vc.rightBarButtonClicked()
            
            
        })
        editRadiusAlert.view.tintColor = .systemGreen
        
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        editRadiusAlert.addAction(doneAction)
        
        self.present(editRadiusAlert, animated: true)
       
        
    }
    
    func selectedValue(selectedValue: String, identifier: String) {
        
        if identifier == "BerthType"{
            
            enterPassengerDetailsTableView.beginUpdates()
            
            selectedBerthType = SeatType(rawValue: selectedValue)
            
            enterPassengerDetailsTableView.endUpdates()
            
            enterPassengerDetailsTableView.reloadData()
        }
    }
    
    func getSelectorValues(identifier: String) -> [String] {
        
        
        
        if let coachType = coachType{
            switch (coachType){
                
            case .SleeperClass:
                return ["No Preference", SeatType.Upper.rawValue, SeatType.Lower.rawValue, SeatType.Middle.rawValue, SeatType.SideLower.rawValue, SeatType.SideUpper.rawValue]
            case .SecondSeaterClass:
                return ["No Preference",SeatType.Window.rawValue,SeatType.Middle.rawValue,SeatType.Aisle.rawValue,]
            case .AirConditioned3TierClass:
                return ["No Preference", SeatType.Upper.rawValue, SeatType.Lower.rawValue, SeatType.Middle.rawValue, SeatType.SideLower.rawValue, SeatType.SideUpper.rawValue]
            case .AirConditioned2TierClass:
                return ["No Preference", SeatType.Upper.rawValue, SeatType.Lower.rawValue, SeatType.SideLower.rawValue, SeatType.SideUpper.rawValue]
            case .AirConditioned1TierClass:
                return ["No Preference", SeatType.Upper.rawValue, SeatType.Lower.rawValue]
            case .AirConditionedChaiCarClass:
                return ["No Preference", SeatType.Window.rawValue, SeatType.Middle.rawValue, SeatType.Aisle.rawValue]
            case .ExecutiveChairCarClass:
                return ["No Preference", SeatType.Window.rawValue, SeatType.Aisle.rawValue]
            }
        }
        
        else {
            return ["No Preference", SeatType.Upper.rawValue, SeatType.Lower.rawValue, SeatType.Middle.rawValue, SeatType.SideLower.rawValue, SeatType.SideUpper.rawValue ,SeatType.Window.rawValue,SeatType.Aisle.rawValue]
        }
        
    }
    
    func getSelectedValue(identifier: String) -> String {
        
        if isVcForUpdating {
            return passengerDetails?.berthPreference?.rawValue ?? "No Preference"
        }
        return selectedBerthType?.rawValue ?? "No Preference"
    }
    
    
    func nameTextFieldEndEditing(enteredText: String) {
        
        enterPassengerDetailsTableView.beginUpdates()
        
        let cell = enterPassengerDetailsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UserDetailsReceiverTableViewCell
        if enteredText.isEmpty{
            
            cell.setNameFieldError(text: "Name Cannot Be Empty")
        }
        else{
            print("inside else")
            let val = Validator.shared.validateName(text: enteredText)
            print(val)
            if !val {
                cell.setNameFieldError(text: """
                    * Enter a Valid Name
                      Name Should Conatain Only Alphabets
                      Name Should have Characters between 3-30
                    """)
                
            }
            else{
                cell.setNameFieldError(text: "")
                
              
                
            }
            
        }
        enterPassengerDetailsTableView.endUpdates()

    }
    
    func ageTextFieldEndEditing(enteredText: String) {
        enterPassengerDetailsTableView.beginUpdates()
        
        let cell = enterPassengerDetailsTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UserDetailsReceiverTableViewCell
        if enteredText.isEmpty{
            cell.setAgeFieldError(text: "Age Cannot Be Empty")
        }
        else{
            print("inside else")
            let val = Validator.shared.validateAge(text: enteredText)
            print(val)
            if !val {
                cell.setAgeFieldError(text: """
                    * Enter a Valid Age
                      Age Should be  between 7-120
                    """)
            }
            else{
                cell.setAgeFieldError(text: "")
            }
        }
        enterPassengerDetailsTableView.endUpdates()
        
        
    }
    func passengerInputValues(name: String, age: Int, gender: Gender, BerthPreference: String,isToBeUpdated:Bool) {
        print(name)
        print(age)
        print(gender)
        print(BerthPreference)
        delegate?.passengerInputValues(name: name, age: age, gender: gender, berthPreference: BerthPreference,isToBeUpdated:isToBeUpdated,passengerNumber: passengerDetails?.passengerNumber)
        self.dismiss(animated: true)
    }
}
