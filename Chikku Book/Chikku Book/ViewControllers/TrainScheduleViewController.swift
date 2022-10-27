//
//  TrainScheduleViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 07/09/22.
//

import UIKit

class TrainScheduleViewController: UIViewController {
    
    let trainScheduleTableView = UITableView(frame: .zero, style: .plain)
    
    
    var trainNumber : Int? = nil
    
    var train : Train? = nil
    
    var daysRunningLabel : UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    var fromStationName : String = ""
    
    var toStationName : String = ""
    
    var runningDays : NSAttributedString = NSAttributedString()
    
    let dbManager = DBManager.getInstance()
    
    
     
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController!.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
        view.addSubview(trainScheduleTableView)
        trainScheduleTableView.delegate = self
        trainScheduleTableView.dataSource = self
        
        trainScheduleTableView.register(StationDetailsTableViewCell.self, forCellReuseIdentifier: "Header")
        trainScheduleTableView.register(StationDetailsTableViewCell.self, forCellReuseIdentifier: StationDetailsTableViewCell.identifier)
        
        setConstraints()
        
        

        
    }
    

    /*
    // MARK: - Navigation
    */
    
    
    func setTrainNumber(trainNumber:Int){
        
        self.trainNumber = trainNumber
        
        self.train = dbManager.getTrainDetails(trainNumber: trainNumber)!
        
        let toStationNumber = train!.stoppingList.count
        
        toStationName = dbManager.getStationNamesandCodes()[train!.stoppingList[toStationNumber - 1].stationCode]!
        
        fromStationName = dbManager.getStationNamesandCodes()[train!.stoppingList[0].stationCode]!
        
        let weekDays  = ["S ","M ","T ","W ","T ","F ","S "]
        
        let runningDays = train!.stoppingList[0].trainAvailabilityStatusOfWeek
        
        let  resultant : NSMutableAttributedString = NSMutableAttributedString()
        
        
        
        for weekDayCount in 0..<7{
            
            
            var attribute = [ NSAttributedString.Key.foregroundColor : UIColor.systemGray]
            var attributedWeekString : NSAttributedString = NSAttributedString(string: weekDays[weekDayCount], attributes: attribute)
            
            if runningDays[weekDayCount] == "1"{
                attribute = [ NSAttributedString.Key.foregroundColor : UIColor.systemGreen]
                attributedWeekString = NSAttributedString(string: weekDays[weekDayCount], attributes: attribute)
            }
            
            print(attributedWeekString)
            
            resultant.append(attributedWeekString)
            
        }
         
        self.runningDays = resultant
        
    }
    
    func setConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        trainScheduleTableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(trainScheduleTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(trainScheduleTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(trainScheduleTableView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(trainScheduleTableView.rightAnchor.constraint(equalTo: view.rightAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    

}


extension TrainScheduleViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let train = train else{
            return 0
        }
        
        if section == 0 {
            return 4
        }
        else{
            return train.stoppingList.count + 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            if indexPath.row == 0 {
                let cell = UITableViewCell()
                
                let trainNumberLabel : UILabel = {
                    
                    let label = UILabel(frame: .zero)
                    label.textColor = .systemGray
                    label.text = "\(trainNumber!)"
                    label.sizeToFit()
                    return label
                }()
                
                cell.textLabel?.text = "Train Number"
                cell.accessoryView = trainNumberLabel
                cell.selectionStyle = .none
                return cell
            }
            
            if indexPath.row == 1 {
                let cell = UITableViewCell()
               
                let sourceLabel : UILabel = {
                    
                    let label = UILabel(frame: .zero)
                    label.textColor = .systemGray
                    label.text = "\(fromStationName)"
                    label.sizeToFit()
                    return label
                }()
                
                cell.textLabel?.text = "Source Station"
                cell.accessoryView = sourceLabel
                cell.selectionStyle = .none
                return cell
            }
            
            if indexPath.row == 2{
                let cell = UITableViewCell()
                
                let destLabel : UILabel = {
                    
                    let label = UILabel(frame: .zero)
                    label.textColor = .systemGray
                    label.text = "\(toStationName)"
                    label.sizeToFit()
                    return label
                }()
                
                cell.textLabel?.text = "Destination Station"
                cell.accessoryView = destLabel
                cell.selectionStyle = .none
                return cell
            }
            
            if indexPath.row == 3 {
                let cell = UITableViewCell()
                
                let runsOnLabel : UILabel = {
                    
                    let label = UILabel(frame: .zero)
                    label.attributedText = runningDays
                    label.sizeToFit()
                    return label
                }()
                
                cell.textLabel?.text = "Runs On"
                cell.accessoryView = runsOnLabel
                cell.selectionStyle = .none
                
                return cell
                
            }
            
        }
        
        if indexPath.section == 1 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Header", for: indexPath) as! StationDetailsTableViewCell
                
                cell.setLabelValues(stationNameAndCode: "Station Name", arrTime: "Arr Time", deptTime: "Dept Time", runningDay: "Day", dist: "Dist (km)")
                cell.selectionStyle = .none
                return cell
            }
            
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: StationDetailsTableViewCell.identifier, for: indexPath) as! StationDetailsTableViewCell
                
                let station = train!.stoppingList[indexPath.row - 1]
                let stationName = dbManager.getStationNamesandCodes()[station.stationCode]!
                let stationNameAndCode = "\(stationName) - \(station.stationCode)"
                var  arrTimeString = station.arrivalTime.toString(format: "HH:mm")
                var  deptTimeString = station.departureTime.toString(format: "HH:mm")
                
                if indexPath.row == 1 {
                    arrTimeString = "   --"
                }
                if indexPath.row == train!.stoppingList.count  {
                    deptTimeString = "   --"
                }
                
                
                let distance = train!.getStationPassByDetails(stationCode: station.stationCode)!.distanceFromOrigin
                
                
                cell.setLabelValues(stationNameAndCode: stationNameAndCode, arrTime: arrTimeString, deptTime: deptTimeString, runningDay: "\(station.arrivalDayOfTheTrain)", dist: "\(distance)")
                cell.selectionStyle = .none
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Train Details"
        }
        else{
            return nil
        }
        
    }
    
    
   
    
}
