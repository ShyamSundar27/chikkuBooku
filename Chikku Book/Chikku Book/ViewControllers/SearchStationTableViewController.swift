//
//  SearchStationTableViewController.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 08/08/22.
//

import UIKit

class SearchStationTableViewController: UITableViewController {
    
    
    
    
    var identifier : String = ""
    
    var stationNames = [String:String]()
    
    var filteredStationCodes = [String]()
    
    var numberOfSections = 1
    
    weak var delegate : SearchStationTableViewControllerDelegate? = nil

    let searchController =  UISearchController()
    
    var recentData  = DBManager.getInstance().recentSearchStationsOnly()
    
    var noSearchesLabel  :UILabel = {
        let label  = UILabel()
        label.textColor = .systemGray
        return label
    }()
    
    var isRecentSearchesNotAvilable = true
    
    var isSearchBecomesFirstResponder = false
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .systemGreen
        
        self.searchController.isActive = true
        //setStationNames()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        navigationItem.titleView = searchController.searchBar
//        searchController.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search \(identifier)"
       
        
    }
    
    
    

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.dismiss(animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
//        print("didPresentSearchController")
        DispatchQueue.main.async { [weak self] in
            self!.searchController.searchBar.becomeFirstResponder()
        }
        //print("isSearchBecomesFirstResponder\(isSearchBecomesFirstResponder)")
       // tableView.reloadData()
        
        

    }
    
    
    
    func setStationNames(){
        stationNames = DBManager.getInstance().getStationNamesandCodes()
        

        //filteredStationCodes =  filteredStationCodes.sorted(by: {$0 < $1} )
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        print(isSearchBecomesFirstResponder)
        
//        if !isSearchBecomesFirstResponder{
//             return 0
//        }
        
        if section == 0  && !recentData.isEmpty{
            isRecentSearchesNotAvilable = false
            tableView.backgroundView = nil
            return recentData.count
        }
        else if !filteredStationCodes.isEmpty && section == 0{
            tableView.backgroundView = nil
            return filteredStationCodes.count
        }
        
        else{
            
            
            
            noSearchesLabel.text = "No Results Found"
            noSearchesLabel.font = .preferredFont(forTextStyle: .largeTitle)
            
            if isRecentSearchesNotAvilable && (searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty)  {
                noSearchesLabel.text = "Begin Search!"
                //noSearchesLabel.font = .preferredFont(forTextStyle: .largeTitle)
                
            }
            
            tableView.backgroundView = noSearchesLabel
            noSearchesLabel.textAlignment = .center
            noSearchesLabel.textColor = .systemGray
            var constraints = [NSLayoutConstraint]()
            
            noSearchesLabel.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(noSearchesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -100))
            constraints.append(noSearchesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
            
            NSLayoutConstraint.activate(constraints)
            return 0
                
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = "\(stationNames[stationCodes[indexPath.row]]!) (\(stationCodes[indexPath.row]))"
        print("recentData.count\(recentData.count)")
        print("f.sDcounilt\(filteredStationCodes.count)")

        
       
        
        if indexPath.section == 0  && !recentData.isEmpty{
            cell.textLabel?.text = "\(recentData[indexPath.row].fromStationNameAndCode.name)  -  \(recentData[indexPath.row].toStationNameAndCode.name)"
            return cell

        }
        
        
        cell.textLabel?.text = "\(stationNames[filteredStationCodes[indexPath.row ]]!) (\(filteredStationCodes[indexPath.row]))"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        if recentData.isEmpty{
        
              delegate?.selectedStationValue(identifier: identifier, stationName:  stationNames[filteredStationCodes[indexPath.row ]]!, stationCode :filteredStationCodes[indexPath.row ] )
        
        
        }
        
        else if filteredStationCodes.isEmpty{
            delegate?.selectedRecentSearched( fromStationNameAndCode: recentData[indexPath.row].fromStationNameAndCode, toStationNameAndCode: recentData[indexPath.row].toStationNameAndCode)
        }
        
        
        searchController.searchBar.resignFirstResponder()
        searchController.isActive = false
        self.searchController.dismiss(animated: false)
        
        
        
         // self!.isSearchBecomesFirstResponder = true
        self.dismiss(animated: true)
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0  && !recentData.isEmpty{
            return "Recent Searches"
        }
        else if !filteredStationCodes.isEmpty{
            return "Search Results"
        }
        return nil
    }
    
}

extension SearchStationTableViewController : UISearchResultsUpdating,UISearchBarDelegate,UISearchControllerDelegate {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        noSearchesLabel = UILabel()
        
        guard let text = searchController.searchBar.text else{
            
            return
        }
        if(!text.isEmpty){
            setStationNames()
            recentData.removeAll()
            numberOfSections = 1
            tableView.reloadData()
            filteredStationCodes.removeAll()
            
            
            for stationName in stationNames {
                
                if(stationName.key.localizedCaseInsensitiveContains(text)){
                    filteredStationCodes.append(stationName.key)
                }
                else if (stationName.value.localizedCaseInsensitiveContains(text)){
                    filteredStationCodes.append(stationName.key)
                }
            }
            
            filteredStationCodes =  filteredStationCodes.sorted(by: {$0 < $1} )
            
            
            
            tableView.reloadData()
        
        }
        else if(text.isEmpty){
            
            
            filteredStationCodes.removeAll()
            stationNames.removeAll()
            recentData = DBManager.getInstance().recentSearchStationsOnly()
            filteredStationCodes.removeAll()
            
            tableView.reloadData()
            filteredStationCodes =  filteredStationCodes.sorted(by: {$0 < $1} )
            
        }
        
    }
    
    
    
}

