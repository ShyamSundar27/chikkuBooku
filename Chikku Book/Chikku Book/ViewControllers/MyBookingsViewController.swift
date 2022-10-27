//
//  MyBookingsViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 12/09/22.
//

import UIKit

class MyBookingsViewController: UIViewController {
    
    
    let ticketListTable = UITableView(frame: .zero, style: .insetGrouped)
    
    var bookingsSegementedControl : UISegmentedControl? = nil
    
    var tickets = [Ticket]()

    let segementedValues = ["Completed","Upcoming","Cancelled"]
    
    let dbManager = DBManager.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "My Bookings"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .systemGreen
        
        
        
        setSegmentedControlValues()
        ticketListTable.delegate = self
        ticketListTable.dataSource = self
        regsiterCells()
        
        view.addSubview(bookingsSegementedControl!)
        view.addSubview(ticketListTable)
        setConstraints()
        
    }
    
    func regsiterCells() {
        ticketListTable.register(TicketDisplayTableViewCell.self, forCellReuseIdentifier: TicketDisplayTableViewCell.identifier)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //title = "My Bookings"
        navigationController?.navigationBar.prefersLargeTitles = true
        segmentedControlAction ()
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        title = ""
//    }
    func setSegmentedControlValues() {
        
        bookingsSegementedControl = UISegmentedControl(items: segementedValues)
        bookingsSegementedControl!.selectedSegmentIndex = 1
        //bookingsSegementedControl!.tintColor = .systemGreen
        bookingsSegementedControl!.selectedSegmentTintColor = .systemGreen
        bookingsSegementedControl!.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        bookingsSegementedControl!.addTarget(self,
                                           action: #selector(segmentedControlAction),
                                           for: .valueChanged)
        getUpcomingTicketList()
    }
    
    
    @objc func segmentedControlAction (){
        
        let value = bookingsSegementedControl!.selectedSegmentIndex
        
        switch (value) {
        case 0 :
            getCompletedTicketList()
            bookingsSegementedControl!.selectedSegmentTintColor = .systemOrange
        case 1 :
            getUpcomingTicketList()
            bookingsSegementedControl!.selectedSegmentTintColor = .systemGreen
        case 2 :
            getCancelledTicketList()
            bookingsSegementedControl!.selectedSegmentTintColor = .systemRed
            
    
        default:
            return
        }
        
    
        
        ticketListTable.reloadData()
    }
    
    
    func setConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        if let bookingsSegementedControl = bookingsSegementedControl {
            
            
            bookingsSegementedControl.translatesAutoresizingMaskIntoConstraints = false
            
            constraints.append(bookingsSegementedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5))
            constraints.append(bookingsSegementedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor))
            constraints.append(bookingsSegementedControl.widthAnchor.constraint(equalToConstant: 350))
            constraints.append(bookingsSegementedControl.heightAnchor.constraint(equalToConstant: 45))
            
            
            ticketListTable.translatesAutoresizingMaskIntoConstraints = false
            
            constraints.append(ticketListTable.topAnchor.constraint(equalTo: bookingsSegementedControl.bottomAnchor,constant: 5))
            constraints.append(ticketListTable.centerXAnchor.constraint(equalTo: view.centerXAnchor))
            constraints.append(ticketListTable.widthAnchor.constraint(equalTo: view.widthAnchor, constant:10))
            constraints.append(ticketListTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
            
        }
        
       
        
        NSLayoutConstraint.activate(constraints)
    }

    
    func getUpcomingTicketList() {
        tickets = dbManager.getUpcomingUserTickets()
    }
   
    func getCompletedTicketList() {
        tickets = dbManager.getCompletedTicketList()
    }
    
    func getCancelledTicketList () {
        tickets = dbManager.getCancelledTicketList()
    }
}

extension MyBookingsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tickets.isEmpty {
            
            let noSearchesLabel = UILabel()
            
            
            
            noSearchesLabel.text = "No \(segementedValues[bookingsSegementedControl!.selectedSegmentIndex]) Tickets Found"
            noSearchesLabel.font = .preferredFont(forTextStyle: .title1)
           
           
            
            tableView.backgroundView = noSearchesLabel
            noSearchesLabel.textAlignment = .center
            noSearchesLabel.textColor = .systemGray
            noSearchesLabel.numberOfLines = 0
            
            var constraints = [NSLayoutConstraint]()
            
            noSearchesLabel.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(noSearchesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor))
            constraints.append(noSearchesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
           // constraints.append(noSearchesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30))
            
            NSLayoutConstraint.activate(constraints)
            //tableView.isScrollEnabled = false
            return 0
        }
        ticketListTable.backgroundView = nil
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TicketDisplayTableViewCell.identifier, for: indexPath) as! TicketDisplayTableViewCell
        
        let ticket = tickets[indexPath.row]
        
        let trainName = dbManager.getTrainDetails(trainNumber: ticket.trainNumber)!.trainName
        
        let fromStationName = dbManager.getStationNamesandCodes()[ticket.fromStation]!
        
        let toStationName = dbManager.getStationNamesandCodes()[ticket.toStation]!
        
        cell.setValues(trainName: trainName, trainNumber: ticket.trainNumber, fromStationNameAndCode: (name: fromStationName, code: ticket.fromStation), toStationNameAndCode: (name: toStationName, code: ticket.toStation), pnrNumber: ticket.pnrNumber, journeyDate: ticket.startTime)
        
        if bookingsSegementedControl?.selectedSegmentIndex == 2 {
            cell.changeCellTintColor(tintColor: .systemRed)
        }
        else if bookingsSegementedControl?.selectedSegmentIndex == 0 {
            cell.changeCellTintColor(tintColor: .systemOrange)
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ticket = tickets[indexPath.row]
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let fromStationName = dbManager.getStationNamesandCodes()[ticket.fromStation]!
        
        let toStationName = dbManager.getStationNamesandCodes()[ticket.toStation]!
        
        let nextVc = TicketViewController(nibName: nil, bundle: nil, ticket: ticket, fromStationName: (code: fromStationName, name: ticket.fromStation), toStationName: (code: toStationName, name: ticket.toStation))
        
        
        
        nextVc.hidesBottomBarWhenPushed = true
        
        
        
        
        
        //self.tabBarController?.tabBar.isHidden = true
        
        navigationController?.pushViewController(nextVc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
