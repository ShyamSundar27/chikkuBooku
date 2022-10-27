//
//  SearchStationViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 07/09/22.
//



import UIKit

class SearchStationViewController: UIViewController {
    
    
    let searchStationtable =  UITableView()
    
    var identifier : String = ""
    
    var stationNames = [String:String]()
    
    var stationCodes = [String]()
    
    var filteredStationCodes = [String]()
    
    var numberOfSections = 1
    
    weak var delegate : SearchStationTableViewControllerDelegate? = nil

    let searchController =  UISearchController()
    
    var recentData  = DBManager.getInstance().recentSearchStationsOnly()
    
    var isTableAddedToView = false
    
    var noSearchesLabel  :UILabel = {
        let label  = UILabel()
        label.textColor = .systemGray
        return label
    }()
    
    var isRecentSearchesNotAvilable = true
    
    var viewTapGesture : UITapGestureRecognizer? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationController?.navigationBar.backgroundColor = .systemBackground
        view.backgroundColor = .systemBackground
        
        self.searchController.isActive = true
        //setStationNames()
        searchStationtable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search \(identifier)"
        searchController.searchBar.becomeFirstResponder()
        
        view.addSubview(self.searchStationtable)
        setConstraints()
        
//        if !isTableAddedToView{
            
            searchStationtable.delegate = self
            searchStationtable.dataSource = self
            searchStationtable.backgroundColor = .systemBackground
            
            isTableAddedToView = true
//        }

    }
    
    
    

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.dismiss(animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
       
        
        
        DispatchQueue.main.async { [weak self] in
            self?.searchController.searchBar.becomeFirstResponder()
           
        }
       
        
        
    }
    
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        searchStationtable.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(searchStationtable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(searchStationtable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(searchStationtable.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(searchStationtable.rightAnchor.constraint(equalTo: view.rightAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
    func setStationNames(){
        stationNames = DBManager.getInstance().getStationNamesandCodes()
        for stationCode in stationNames.keys {
            stationCodes.append(stationCode)
            filteredStationCodes.append(stationCode)
            
        }

        filteredStationCodes =  filteredStationCodes.sorted(by: {$0 < $1} )
    }


    
    
}

extension SearchStationViewController : UISearchResultsUpdating,UISearchBarDelegate,UISearchControllerDelegate {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        noSearchesLabel = UILabel()
        
        guard let text = searchController.searchBar.text else{
            
            return
        }
        if(!text.isEmpty){
            
            
            setStationNames()
            recentData.removeAll()
            numberOfSections = 1
            //searchStationtable.reloadData()
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
            
            
            
            searchStationtable.reloadData()
        
        }
        else if(text.isEmpty){
            
            
            filteredStationCodes.removeAll()
            stationCodes.removeAll()
            stationNames.removeAll()
            recentData = DBManager.getInstance().recentSearchStationsOnly()
            filteredStationCodes.removeAll()
            
            searchStationtable.reloadData()
            filteredStationCodes =  filteredStationCodes.sorted(by: {$0 < $1} )
            
        }
        
    }
    
    
    
}


extension SearchStationViewController : UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        
        
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
            
            if isRecentSearchesNotAvilable {
                noSearchesLabel.text = "Begin Search!"
                noSearchesLabel.font = .preferredFont(forTextStyle: .largeTitle)
                
            }
            
            tableView.backgroundView = noSearchesLabel
            noSearchesLabel.textAlignment = .center
            noSearchesLabel.textColor = .systemGray
            var constraints = [NSLayoutConstraint]()
            
            noSearchesLabel.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(noSearchesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -100))
            constraints.append(noSearchesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
            
            NSLayoutConstraint.activate(constraints)
                
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if indexPath.section == 0  && !recentData.isEmpty{
            cell.textLabel?.text = "\(recentData[indexPath.row].fromStationNameAndCode.name)  -  \(recentData[indexPath.row].toStationNameAndCode.name)"
            return cell

        }
        
        
        cell.textLabel?.text = "\(stationNames[filteredStationCodes[indexPath.row ]]!) (\(filteredStationCodes[indexPath.row]))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        if recentData.isEmpty{
        
              delegate?.selectedStationValue(identifier: identifier, stationName:  stationNames[filteredStationCodes[indexPath.row ]]!, stationCode :filteredStationCodes[indexPath.row ] )
        
        
        }
        
        else if filteredStationCodes.isEmpty{
            delegate?.selectedRecentSearched( fromStationNameAndCode: recentData[indexPath.row].fromStationNameAndCode, toStationNameAndCode: recentData[indexPath.row].toStationNameAndCode)
        }
        
        
        searchController.searchBar.resignFirstResponder()
        searchController.isActive = false
        self.searchController.dismiss(animated: false)
        
        self.dismiss(animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0  && !recentData.isEmpty{
            return "Recent Searches"
        }
        else if !filteredStationCodes.isEmpty{
            return "Search Results"
        }
        return nil
    }
}
