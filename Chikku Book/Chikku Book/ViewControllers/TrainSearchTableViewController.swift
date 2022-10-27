//
//  TrainSearchTableViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 07/09/22.
//

import UIKit

class TrainSearchTableViewController: UITableViewController {
    
    
    var trainNamesAndNumbers = [Int:String]()
    
    var filteredTrains = [Int]()
    
    var numberOfSections = 1
    
    weak var delegate : TrainSearchTableViewControllerDelegate? = nil

    let searchController =  UISearchController()
    
    //var recentData  = DBManager.getInstance().recentSearchStationsOnly()
    
    var noSearchesLabel  :UILabel = {
        let label  = UILabel()
        label.textColor = .systemGray
        return label
    }()
    
    var isRecentSearchesNotAvilable = true
    
    var isSearchBecomesFirstResponder = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.isActive = true
        
        navigationController?.navigationBar.tintColor = .systemGreen
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        setSearchControllerValues()
        

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async { [weak self] in
            self?.searchController.searchBar.becomeFirstResponder()
        }
        
        if trainNamesAndNumbers.isEmpty{
             setTrainNumbers()
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.dismiss(animated: true)
        
    }
    
    
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if !filteredTrains.isEmpty{
            tableView.backgroundView = nil
            tableView.isScrollEnabled = true
            return filteredTrains.count
        }
        
        
        else {
            
            
            noSearchesLabel.text = "No Results Found"
            noSearchesLabel.font = .preferredFont(forTextStyle: .largeTitle)
            print("search text")
            print(searchController.searchBar.text == nil)
            print(searchController.searchBar.text!.isEmpty)
            print("search text")
            if searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty {
                
                noSearchesLabel.numberOfLines = 2
                noSearchesLabel.text = "Enter Number Or Name To Search"
                
               
            }
            
            tableView.backgroundView = noSearchesLabel
            noSearchesLabel.textAlignment = .center
            noSearchesLabel.textColor = .systemGray
            
            var constraints = [NSLayoutConstraint]()
            
            noSearchesLabel.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(noSearchesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -100))
            constraints.append(noSearchesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
            constraints.append(noSearchesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30))
            
            NSLayoutConstraint.activate(constraints)
            //tableView.isScrollEnabled = false
            return 0
            
        }
        
        
    }

    // MARK: - Navigation

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "\(filteredTrains[indexPath.row]) - \(trainNamesAndNumbers[filteredTrains[indexPath.row]]!)"
        
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.presentTrainScheduleFor(trainNumber: filteredTrains[indexPath.row],trainName: trainNamesAndNumbers[filteredTrains[indexPath.row]]!)
        
        
        searchController.searchBar.resignFirstResponder()
        self.searchController.dismiss(animated: false)
        self.dismiss(animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func setSearchControllerValues(){
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Train Number or  Name"
        searchController.searchBar.keyboardType = .namePhonePad
    }
    
    
    func setTrainNumbers(){
        
        self.trainNamesAndNumbers = DBManager.getInstance().retrieveTrainNameAndNumbers()
        
    }

}


extension TrainSearchTableViewController : UISearchControllerDelegate,UISearchBarDelegate,UISearchResultsUpdating{
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        noSearchesLabel = UILabel()
        
        
        guard let text = searchController.searchBar.text else{
            
            return
        }
        if(!text.isEmpty){
            
            filteredTrains.removeAll()
            for trainNamesAndNumber in trainNamesAndNumbers {
                let trainNumberString = String(trainNamesAndNumber.key)
                if(trainNumberString.localizedCaseInsensitiveContains(text)){
                    filteredTrains.append(trainNamesAndNumber.key)
                }
                else if (trainNamesAndNumber.value.localizedCaseInsensitiveContains(text)){
                    filteredTrains.append(trainNamesAndNumber.key)
                }
            }
            tableView.reloadData()
        }
        
        else{
            filteredTrains.removeAll()
            tableView.reloadData()
        }
        
    }
    
    
}
