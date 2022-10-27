//
//  PnrEnquiryViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 14/09/22.
//

import UIKit

class PnrEnquiryViewController: UIViewController {
    
    let dbManager =  DBManager.getInstance()
    
    let pnrEnquiryTable = UITableView(frame: .zero, style: .grouped)
     
    let pnrSearchField : UITextField = {
        let textField = UITextField()
        textField.keyboardType = .phonePad
        textField.tag = Numbers.two.rawValue
        //textField.layer.cornerRadius = 5
        textField.borderStyle = .roundedRect
        textField.tintColor = .systemGreen
        textField.placeholder = "Enter PNR"
        
        return textField
    }()
    
    
    let searchButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 5
        let label = UILabel()
        label.text = "Search Pnr"
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .white
        button.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        return button
        
    }()
    
    
    var footerString = "Enter 10 digit PNR number to search"
    
    var isFooterError = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        self.title = "Pnr Enquiry"
        navigationItem.largeTitleDisplayMode = .always
        
        pnrEnquiryTable.delegate = self
        pnrEnquiryTable.dataSource = self
        
        pnrSearchField.delegate = self
        
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        view.addSubview(pnrEnquiryTable)
        
       
        
        setConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        pnrSearchField.resignFirstResponder()
        resignFirstResponder()
    }
    func setConstraints() {
        
        var constraints = [NSLayoutConstraint]()
        
        pnrEnquiryTable.separatorColor = pnrEnquiryTable.backgroundColor
        pnrEnquiryTable.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(pnrEnquiryTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20))
        constraints.append(pnrEnquiryTable.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        constraints.append(pnrEnquiryTable.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(pnrEnquiryTable.rightAnchor.constraint(equalTo: view.rightAnchor))
        //Hi

        NSLayoutConstraint.activate(constraints)
    }
    
    func setTextFieldConstraints (contentView : UIView){
        
        contentView.addSubview(pnrSearchField)
        contentView.addSubview(searchButton)
        
        searchButton.backgroundColor = .systemGreen
        pnrSearchField.backgroundColor = .systemGray4
        
        pnrSearchField.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            
            searchButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),

            searchButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),

            searchButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),

            searchButton.widthAnchor.constraint(equalToConstant: 100),
            
            pnrSearchField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),

            pnrSearchField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),

            pnrSearchField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),

            pnrSearchField.rightAnchor.constraint(equalTo: searchButton.leftAnchor, constant: -20)
            
            
        ])
        
        
        
        
    }
    
    
    @objc func searchButtonClicked() {
        
        pnrSearchField.resignFirstResponder()
        
        
        
        if !isErrorAtTextField(textField: pnrSearchField){
            
           
            
            if  let ticket = dbManager.getTicket(pnrNumber: UInt64(pnrSearchField.text!)!){
                
                let fromStationName = dbManager.getStationNamesandCodes()[ticket.fromStation]!
                
                let toStationName = dbManager.getStationNamesandCodes()[ticket.toStation]!
                
                
                let nextVc = TicketViewController(nibName: nil, bundle: nil, ticket: ticket, fromStationName: (code: ticket.fromStation, name: fromStationName), toStationName: (code: ticket.toStation, name: toStationName))
                
                
                nextVc.hidesBottomBarWhenPushed = true
                
               
                navigationController?.pushViewController(nextVc, animated: true)
           }
            
           else {
                
               let alertController = UIAlertController(title: nil, message: "PNR Not Found", preferredStyle: .alert)
               
               let okButton = UIAlertAction(title: "OK", style: .cancel)
               
               alertController.addAction(okButton)
               
               alertController.view.tintColor = .systemGreen
               
               present(alertController, animated: true)
           }
            
        }
        
        
        pnrSearchField.becomeFirstResponder()
    }
}
    
       
            
           



extension PnrEnquiryViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
       
        let contentView = cell.contentView
        
        setTextFieldConstraints(contentView: contentView)
        
        cell.selectionStyle = .none
        
        cell.backgroundColor = pnrEnquiryTable.backgroundColor
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        footerString
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Enter the PNR "
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            
            
            
            
            view.textLabel?.numberOfLines = 2
            view.textLabel?.font = .preferredFont(forTextStyle: .headline)
            view.textLabel?.textAlignment = .center
            
        }
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            
            print("hi61")
            if isFooterError {
                view.textLabel?.textColor = .systemRed
            }
            
           
            
        }
    }
    
    
    
}


extension PnrEnquiryViewController : UITextFieldDelegate {
    
    
    private func textLimit(existingText: String?, newText: String, limit: Int) -> Bool {
        
        let text = existingText ?? ""
        let isAtLimit = text.count + newText.count <= limit
        
        
        return isAtLimit
        
    }
    
    
    func isErrorAtTextField(textField: UITextField) -> Bool{
        
        
        
        if let text = textField.text{
            
            if text.isEmpty {
                
                pnrEnquiryTable.beginUpdates()
                
                isFooterError = true
                
                footerString = "Enter 10 digit pnr number to search"
                
                
                
                pnrEnquiryTable.endUpdates()
                
                pnrEnquiryTable.reloadData()
                
                pnrSearchField.becomeFirstResponder()
                
                
                return true
            }
            else if !Validator.shared.validatePNRNumber(text: textField.text!){
                 
                pnrEnquiryTable.beginUpdates()
                
                footerString = "Pnr Number Should Contain 10 Digit Numbers Only"
                
                isFooterError = true
                
                pnrEnquiryTable.endUpdates()
                
                pnrEnquiryTable.reloadData()
                
                pnrSearchField.becomeFirstResponder()
                
                return true
            }
            
            else{
                pnrEnquiryTable.beginUpdates()
                
                isFooterError = false
                
                footerString = "Enter 10 digit PNR number to search"
                
                pnrEnquiryTable.endUpdates()
                
                pnrEnquiryTable.reloadData()
                
                return false
                
            }
            
            
        }
        
        
        return true
       
    }
    
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("hi")
        
        return self.textLimit(existingText: textField.text, newText: string, limit: 10)
    }
}
