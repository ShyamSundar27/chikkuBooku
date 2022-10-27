//
//  TrainSearchTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 04/08/22.
//

import UIKit

class SearchTrainTableViewCell: UITableViewCell,UITableViewDelegate,UITableViewDataSource{
    
    
    static let identifier = "SearchTrainTableViewCell"
    //NOT USING
    //NOT USING
    //NOT USING
    //NOT USING//NOT USING//NOT USING
    var trainSearchTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray4
        //tableView.rowHeight = UITableView.automaticDimension
        //tableView.estimatedRowHeight = 200
//
        
        return tableView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        trainSearchTableView.delegate = self
        trainSearchTableView.dataSource = self
        trainSearchTableView.register(SearchStationInputTableViewCell.self, forCellReuseIdentifier: SearchStationInputTableViewCell.identifier)
        contentView.addSubview(trainSearchTableView)
        print("Hi")
        setConstraints()
        
        
    }
    
    func viewDesigns(){
        contentView.backgroundColor = .systemBackground
        backgroundColor = .systemGray4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2);
        contentView.layer.shadowColor = UIColor.black.cgColor;
        contentView.layer.shadowRadius = 1;
        
        contentView.layer.shadowOpacity = 0.25;
        
        contentView.layer.cornerRadius = 400
        contentView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
   
    
    
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 200).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -200).isActive = true
        contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        trainSearchTableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(trainSearchTableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5))
        constraints.append(trainSearchTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50))
        constraints.append(trainSearchTableView.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20))
        constraints.append(trainSearchTableView.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -20))
        trainSearchTableView.backgroundColor = .systemBackground
        print("Setting trainsearchcell")
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchStationInputTableViewCell.identifier, for: indexPath) as! SearchStationInputTableViewCell
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        print(indexPath.row)
        if indexPath.row == 0{
            print("inside row 1")
            cell.configureTextFieldValueAndImage(defaultText: "FROM STATION", arrivalOrDepartureImage: UIImage(named: "fromStationImage")!)
            cell.stationNameTextField.font = .monospacedSystemFont(ofSize: 18, weight: .regular)
            return cell
        }
        if indexPath.row == 1{
            print("inside row 2")
            cell.configureTextFieldValueAndImage(defaultText: "TO STATION", arrivalOrDepartureImage: UIImage(named: "toStationImage")!)
            cell.stationNameTextField.font = .systemFont(ofSize: 20, weight: .medium)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("hi row height")
        return 100
    }

}
