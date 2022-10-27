//
//  CancelTicketViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 09/09/22.
//

import UIKit

class TicketLsitViewController: UIViewController {
    
    
    let ticketsTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var tickets :[Ticket] = []
    
    let dbManager = DBManager.getInstance()
    
    var isFirstTime = true
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        view.addSubview(ticketsTableView)
        ticketsTableView.delegate = self
        ticketsTableView.dataSource = self
        
        getTickets()
        
        registerCells()
        setConstraints()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFirstTime{
            isFirstTime = false
            return
        }
        
        getTickets()
        ticketsTableView.reloadData()
    }
    
    func getTickets() {
        
        
       tickets =  DBManager.getInstance().getUpcomingUserTickets().sorted(by: { $0.startTime.compare($1.startTime) == .orderedAscending })
    }
    
    
    
    func registerCells(){
        ticketsTableView.register(TicketDisplayTableViewCell.self, forCellReuseIdentifier: TicketDisplayTableViewCell.identifier)
    }
    func setConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        ticketsTableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(ticketsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(ticketsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(ticketsTableView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(ticketsTableView.rightAnchor.constraint(equalTo: view.rightAnchor))
        
        NSLayoutConstraint.activate(constraints)
        
    }

}


extension TicketLsitViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tickets.isEmpty {
            
            let noSearchesLabel = UILabel()
            
            
            
            noSearchesLabel.text = "No Tickets Found"
            noSearchesLabel.font = .preferredFont(forTextStyle: .largeTitle)
           
           
            
            tableView.backgroundView = noSearchesLabel
            noSearchesLabel.textAlignment = .center
            noSearchesLabel.textColor = .systemGray
            noSearchesLabel.numberOfLines = 0
            
            var constraints = [NSLayoutConstraint]()
            
            noSearchesLabel.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(noSearchesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor))
            constraints.append(noSearchesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
            constraints.append(noSearchesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30))
            
            NSLayoutConstraint.activate(constraints)
            //tableView.isScrollEnabled = false
            return 0
        }
        
        tableView.backgroundView = nil
        return tickets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: TicketDisplayTableViewCell.identifier, for: indexPath) as! TicketDisplayTableViewCell
        
        let ticket = tickets[indexPath.row]
        
        let trainName = dbManager.getTrainDetails(trainNumber: ticket.trainNumber)!.trainName
        
        let fromStationName = dbManager.getStationNamesandCodes()[ticket.fromStation]!
        
        let toStationName = dbManager.getStationNamesandCodes()[ticket.toStation]!
        
        cell.setValues(trainName: trainName, trainNumber: ticket.trainNumber, fromStationNameAndCode: (name: fromStationName, code: ticket.fromStation), toStationNameAndCode: (name: toStationName, code: ticket.toStation), pnrNumber: ticket.pnrNumber, journeyDate: ticket.startTime)
        
        
        return cell
        
    }
    
    


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let ticket = tickets[indexPath.row]
        
        let fromStationName = dbManager.getStationNamesandCodes()[ticket.fromStation]!
        
        let toStationName = dbManager.getStationNamesandCodes()[ticket.toStation]!
        
        let nextVc = TicketViewController(nibName: nil, bundle: nil, ticket: ticket, fromStationName: (code: fromStationName, name: ticket.fromStation), toStationName: (code: toStationName, name: ticket.toStation))
        
        
        
        nextVc.hidesBottomBarWhenPushed = true
        
        if self.title ==  OtherServices.cancelTicket.rawValue{
            nextVc.addBackButton()
            nextVc.addCancelButton()
        }
        
        
        
        //self.tabBarController?.tabBar.isHidden = true
        
        navigationController?.pushViewController(nextVc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        100
//    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tickets.count == 0 {
            
            return nil
        }
        
        else if self.title == OtherServices.upcomingJourney.rawValue {
            return "Upcoming Tickets"
        }
        return "Tickets"
    }
    
    
    
  
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView

        header.textLabel?.text = self.tableView(tableView, titleForHeaderInSection: section)
        header.textLabel?.font = .boldSystemFont(ofSize: 24)
        header.textLabel?.textColor = .label
        
        
    }
    
}
