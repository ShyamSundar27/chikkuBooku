//
//  QuotaTypeSelectorViewController.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 06/08/22.
//

import UIKit

class SelectorViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
   
    

    var identifier :String
    
    var selectorTableView = UITableView()
     
    var rowValues = [String]()
    
    
    var selectedValue = ""
    
    weak var dataSource : SelectorViewDataSource? = nil
    
    weak var delegate : SelectorViewDelegate? = nil
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, identifier : String ) {
        self.identifier = identifier
        super.init( nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(selectorTableView)
        rowValues = dataSource!.getSelectorValues(identifier: self.identifier)
        
        for rowValue in rowValues {
            print(rowValue)
        }
        selectedValue = dataSource!.getSelectedValue(identifier: self.identifier)
        selectorTableView.delegate = self
        selectorTableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .systemRed
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .systemGreen
        selectorTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        setConstraints()
    
       
    }
    
    @objc func rightBarButtonClicked (){
        

//        dismiss(animated: false , completion: { [weak self] in
//            guard let self = self else{
//                return
//            }
//            self.delegate?.selectedValue(selectedValue: self.selectedValue, identifier: self.identifier)
//        })
        
        self.delegate?.selectedValue(selectedValue: self.selectedValue, identifier: self.identifier)
        dismiss(animated: true , completion: nil)
        
    }
    
    @objc func leftBarButtonClicked (){
        dismiss(animated: true , completion: nil)
    }
    
    
    
    func setConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        selectorTableView.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(selectorTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(selectorTableView.topAnchor.constraint(equalTo: view.topAnchor))
        constraints.append(selectorTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(selectorTableView.widthAnchor.constraint(equalTo: view.widthAnchor))
        

        
       
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(rowValues.count)
        return rowValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = rowValues[indexPath.row]
        

        if rowValues[indexPath.row] == (selectedValue){
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        
        
        cell.tintColor = .systemGreen
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedValue = rowValues[indexPath.row]
        tableView.reloadData()
    }
    

}
