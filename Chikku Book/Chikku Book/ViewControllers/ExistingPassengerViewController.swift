//
//  ExistingPassengerViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 15/09/22.
//

import UIKit

class ExistingPassengerViewController: UIViewController {
    
    
    weak var delegate : ExistingPassengerViewControllerDelegate? = nil
    
    let existingPassengerTable = UITableView(frame: .zero,style: .insetGrouped)
    
    let passengers =  DBManager.getInstance().retrieveSavedPassenger()
    
    lazy var selectedPassengers :  [Int:Bool] = [:]
    
    
    var alreadyEnteredPassenger = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(existingPassengerTable)
        existingPassengerTable.delegate = self
        existingPassengerTable.dataSource = self
        view.backgroundColor = .systemBackground
        
        setConstraints()
        registerCells()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .systemRed
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .systemGreen

       
    }
    
    @objc func leftBarButtonClicked() {
        dismiss(animated: true , completion: nil)
    }
    
    @objc func rightBarButtonClicked() {
        
        
        var selectedPassNumbers : [Int] = []
        
        
        for passengerNumbers in selectedPassengers.keys {
            
            if selectedPassengers[passengerNumbers]! {
                selectedPassNumbers.append(passengerNumbers)
            }
        }
        
        delegate?.selectedPassengerNumbers(passengerNumbers: selectedPassNumbers)
        
    
        
        
        dismiss(animated: true , completion: nil)
    }
    
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        existingPassengerTable.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(existingPassengerTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(existingPassengerTable.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(existingPassengerTable.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(existingPassengerTable.rightAnchor.constraint(equalTo: view.rightAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func registerCells() {
        existingPassengerTable.register(ExistingPassengerSelectionTableViewCell.self, forCellReuseIdentifier: ExistingPassengerSelectionTableViewCell.identifier)
    }
    
    func setAlreadyEnteredPassenger (alreadyEnteredPassenger : Int){
        self.alreadyEnteredPassenger = alreadyEnteredPassenger
    }

    func getSelectedCount () -> Int {
        
        var selectedCount = 0
        for passenger in selectedPassengers.values {
            if passenger {
                selectedCount = selectedCount + 1
            }
        }
        
        return selectedCount
    }
    
    func setSelectedPassengers (passengerNumbers : [Int]){
        
        for passenger in passengers {
            
            if passengerNumbers.contains(passenger.passengerNumber){
                selectedPassengers[passenger.passengerNumber] = true
            }
            else {
                selectedPassengers[passenger.passengerNumber] = false
            }
            
        }
        
        print(selectedPassengers)
        
    }
    

}


extension ExistingPassengerViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(passengers.count)
        return passengers.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ExistingPassengerSelectionTableViewCell.identifier, for: indexPath) as! ExistingPassengerSelectionTableViewCell
        
        let passenger = passengers[indexPath.row]
        
        cell.setLabelValues(name: passenger.name, age: passenger.age, gender: passenger.gender, seatPreference: passenger.berthPreference)
        print(indexPath.row)
        
        //print("selected passenger\(selectedPassengers[indexPath.row])")
        if selectedPassengers[passenger.passengerNumber]!{
            cell.swapCheck()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell = tableView.cellForRow(at: indexPath) as! ExistingPassengerSelectionTableViewCell
        
        if getSelectedCount() + alreadyEnteredPassenger >= 4  && !cell.isCheckBoxChecked(){
            
            let alertController = UIAlertController(title: nil, message: "Passengers Count Can't Exceed 4 ", preferredStyle: .alert)
                
            let okButton = UIAlertAction(title: "OK", style: .cancel)
                
            alertController.addAction(okButton)
                
            alertController.view.tintColor = .systemGreen
                
            present(alertController, animated: true)
            
            

        }
        
        else{
            
            let passenger = passengers[indexPath.row]
            
            selectedPassengers[passenger.passengerNumber] =  !selectedPassengers[passenger.passengerNumber]!
            
            print(selectedPassengers)
            
            tableView.reloadData()
        }
       
       
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

