//
//  PresentValueSelectorTableView.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 06/08/22.
//

import UIKit

class PresentValueSelectorTableView: UITableView ,UITableViewDelegate,UITableViewDataSource{
    
    var rowValues : [String] = []
    
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRowValues (rowValuesArray:[String]){
        rowValues = rowValuesArray
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = rowValues[indexPath.row]
        cell.accessoryType = .checkmark
        return cell
    }
    

    

}
