//
//  HomePageViewController.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 04/08/22.
//

import UIKit

class HomePageViewController: UIViewController{
    
    
    

    var homePagetableView = UITableView(frame: .zero, style: .grouped)
    
    var searchTrainHeaderView = HomePageSearchTrainUIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 2.5, height: 350))
    
    var coachTypeValues : [CoachType:String] = [:]
    
    var quotaTypeValues : [QuotaType] = []
    
    var selectedCoachType : CoachType = .SleeperClass
    
    var selectedQuotaType : QuotaType = .General
    
    var selectedDateValue : Date = Date().localDate()
    
    var selectedFromStation : String? = nil
    
    var selectedToStation : String? = nil
    
    var selectedFromStationCode : String? = nil
    
    var selectedToStationCode : String? = nil
    
    let dbManager = DBManager.getInstance()
    
    var recentSearches : [( fromStationNameAndCode : (name:String,code:String), toStationNameAndCode : (name:String,code:String), coachType:CoachType ,quotaType:QuotaType,searchDate :Date)] = []
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationController?.navigationBar.backgroundColor = .systemBackground
        view.backgroundColor = .systemBackground
        title = "Chikku Book"
        
        homePagetableView.tableHeaderView = searchTrainHeaderView
        searchTrainHeaderView.delegate = self
        searchTrainHeaderView.dataSource = self
        homePagetableView.backgroundColor = .secondarySystemBackground
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)

        registerCells()
        
        view.addSubview(homePagetableView)
        
        setCoachTypeAndQuotaTypeValues()
        
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        homePagetableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        dbManager.setSeatAvailabilityChart()
        
        if !recentSearches.isEmpty{
            
            let cell = homePagetableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RecentSearchesDisplayTableViewCell
            cell.recentSearchCollectionView?.reloadData()
            
        }
        

    }
  
    @objc func rotated() {
        
        if UIDevice.current.orientation.isLandscape && UIDevice.current.userInterfaceIdiom == .pad {
            
            searchTrainHeaderView.clipsToBounds = true
            
        }
        else {
           
            searchTrainHeaderView.clipsToBounds = false
            
        }
        
    }
    
    func setConstraints(){
        
        var constraints = [NSLayoutConstraint]()
        
        homePagetableView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(homePagetableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(homePagetableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(homePagetableView.leftAnchor.constraint(equalTo: view.leftAnchor))
        constraints.append(homePagetableView.rightAnchor.constraint(equalTo: view.rightAnchor))
        homePagetableView.separatorColor = homePagetableView.backgroundColor
        
        homePagetableView.tableHeaderView!.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(homePagetableView.tableHeaderView!.topAnchor.constraint(equalTo: homePagetableView.topAnchor))
        constraints.append(homePagetableView.tableHeaderView!.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2.5))
        constraints.append(homePagetableView.tableHeaderView!.centerXAnchor.constraint(equalTo: homePagetableView.centerXAnchor))
        constraints.append(homePagetableView.tableHeaderView!.heightAnchor.constraint(equalToConstant: 350))

        NSLayoutConstraint.activate(constraints)
    }
    
    

    func registerCells(){
        homePagetableView.tag = Numbers.one.rawValue
        homePagetableView.dataSource = self
        homePagetableView.delegate = self
        
        homePagetableView.register(RecentSearchesDisplayTableViewCell.self, forCellReuseIdentifier: RecentSearchesDisplayTableViewCell.identifier)
        homePagetableView.register(OtherServicesTableViewCell.self, forCellReuseIdentifier: OtherServicesTableViewCell.identifier)
    }
    
    
    
    
    func setCoachTypeAndQuotaTypeValues(){
        for coachTypeDetail in DBManager.getInstance().coachTypeDetails{
            coachTypeValues[coachTypeDetail.type] = coachTypeDetail.coachCode
        }
        
        for quotaType in QuotaType.allCases{
            quotaTypeValues.append(quotaType)
        }
    }
    
    func setRecentValues(){
        recentSearches = dbManager.retreiveRecentSearches()
    }

}

extension HomePageViewController : UITableViewDelegate,UITableViewDataSource{
    
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        setRecentValues()
        
        if recentSearches.isEmpty{
            return 1
        }
        return 2
    }
  
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (!recentSearches.isEmpty && indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentSearchesDisplayTableViewCell.identifier, for: indexPath) as! RecentSearchesDisplayTableViewCell
            
            cell.setDefaultValues(recentSearches: recentSearches)
            cell.delegate = self
            
            cell.separatorInset = UIEdgeInsets(top: 0, left: 100000, bottom: 0, right: -100)
            cell.layoutMargins = UIEdgeInsets.zero
            cell.selectionStyle = .none
            return cell
        }
        
        if ((recentSearches.isEmpty && indexPath.section == 0  ) || (indexPath.section == 1 )){
            let cell = tableView.dequeueReusableCell(withIdentifier: OtherServicesTableViewCell.identifier, for: indexPath) as! OtherServicesTableViewCell
            cell.delegate = self
            return cell
        }
            
        let cell = UITableViewCell()
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if recentSearches.isEmpty{
            return "Other Services"
        }
        if section == 0 {
            return "Recent Searches"
        }
        

        return "Other Services"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 && indexPath.section == 0 {
            return 145
        }
        
        if indexPath.section == 1 {

            return 140
        }
        return UITableView.automaticDimension
    }
    
    

    
    
}

extension HomePageViewController : SelectorViewDataSource, SelectorViewDelegate, HomePageSearchTrainViewDelegete, HomePageSearchTrainViewDataSource, SearchStationTableViewControllerDelegate{
    
    
    
    
    func getSelectedValue(identifier: String) -> String {
        if identifier == "QuotaTypeSelector"{
            return selectedQuotaType.rawValue
        }
        else  {
            return selectedCoachType.rawValue
        }
    }
    func getSelectorValues(identifier : String) -> [String] {
        if identifier == "QuotaTypeSelector"{
            var quotaTypes = [String]()
            for quotaType in quotaTypeValues {
                quotaTypes.append(quotaType.rawValue)
            }
            return quotaTypes
        }
        else  {
            var coachTypes = [String]()
            for coachType in coachTypeValues {
                coachTypes.append("\(coachType.key.rawValue) (\(coachType.value))")
            }
            return coachTypes
        }
    }
    
    func selectedValue(selectedValue: String,identifier:String) {
        if identifier == "QuotaTypeSelector" {
            selectedQuotaType = QuotaType(rawValue: selectedValue)!
            searchTrainHeaderView.trainSearchTableView.reloadData()
        }
        
        if identifier == "CoachTypeSelector"{
            for coachType in CoachType.allCases{
                if selectedValue.contains(coachType.rawValue)
                {
                    selectedCoachType = CoachType(rawValue: coachType.rawValue)!
                    searchTrainHeaderView.trainSearchTableView.reloadData()
                }
            }
            
        }
    }
    
    func selectedDateValue(selectedDate: Date) {
        self.selectedDateValue = selectedDate
    }
    
    func swapSelectedStations() {
        
        if self.selectedFromStation != nil && self.selectedToStation != nil{
            swap(&selectedFromStationCode!, &selectedToStationCode!)
            swap(&selectedFromStation!,&selectedToStation!)
        }
        
        
    }
    
    
    
    func getQuotaTypeSelectedValue() -> String {
        return selectedQuotaType.rawValue
    }
    
    func getCoachTypeSelectedValue() -> String {
        
        return selectedCoachType.rawValue
    }
    
    
    func presentQuotaTypeSelector() {
        
        let presentVc = SelectorViewController(nibName: nil, bundle: nil, identifier: "QuotaTypeSelector")
        presentVc.title = "Quota Type"
        presentVc.dataSource = self
        presentVc.delegate = self
        let presentingNc = UINavigationController(rootViewController: presentVc)
        
        if let sheet = presentingNc.sheetPresentationController{
            sheet.detents = [.medium()]
        }
        self.present(presentingNc, animated: true)
        
       

    }
    
    func presentCoachTypeSelector() {
        
        let presentVc = SelectorViewController(nibName: nil, bundle: nil, identifier: "CoachTypeSelector")
        presentVc.title = "Coach Type"
        presentVc.dataSource = self
        presentVc.delegate = self
        let presentingNc = UINavigationController(rootViewController: presentVc)
        
        
        if let sheet = presentingNc.sheetPresentationController{
            sheet.detents = [.medium()]
        }
        self.present(presentingNc, animated: true)
    }
    
    
    
    
    
    func presentSearchFromStationVc() {
        let searchTableController = SearchStationTableViewController()
//        let searchTableController = SearchStationViewController()

        searchTableController.identifier = "From Station"
        let searchNavController = UINavigationController(rootViewController: searchTableController )
        searchNavController.modalPresentationStyle = .fullScreen
        searchTableController.delegate = self
        
        
        present(searchNavController, animated: true)
    }
    
    
    func presentSearchToStationVc() {
        let searchTableController = SearchStationTableViewController()
//        let searchTableController = SearchStationViewController()
        searchTableController.identifier = "To Station"
        let searchNavController = UINavigationController(rootViewController: searchTableController )
        searchNavController.modalPresentationStyle = .fullScreen
        searchTableController.delegate = self
        
        
        present(searchNavController, animated: true)
    }
    
    
    
    
    func getSelectedFromStationValue() -> String {
        return selectedFromStation ?? ""
    }
    
    func getSelectedToStationValue() -> String {
        return selectedToStation ?? ""
    }
    
    func selectedStationValue(identifier: String, stationName: String,stationCode:String) {
        if identifier == "From Station"{
            selectedFromStation = stationName
            selectedFromStationCode = stationCode
            
        }
        else{
            selectedToStation = stationName
            selectedToStationCode = stationCode

        }
        searchTrainHeaderView.trainSearchTableView.reloadData()
    }
    
    
    func selectedRecentSearched( fromStationNameAndCode: (name: String, code: String), toStationNameAndCode: (name: String, code: String)) {
           
        selectedFromStation = fromStationNameAndCode.name
        selectedFromStationCode = fromStationNameAndCode.code
        
        selectedToStation = toStationNameAndCode.name
        selectedToStationCode = toStationNameAndCode.code
        
        searchTrainHeaderView.trainSearchTableView.reloadData()
    }
    
    func getSelectedDateValue() -> Date {
        return selectedDateValue
    }
    
    
    func searchTrainsButtonClicked() {
        let fromStationName = selectedFromStation
        let toStationName  = selectedToStation
        
        if fromStationName != nil && toStationName != nil && fromStationName != toStationName {
            
            let currentDate = searchTrainHeaderView.getDate()
            let nextVc = TrainAvailabilityListViewController(fromStationName:(code: selectedFromStationCode!,name: selectedFromStation!), toStationName: ( code: selectedToStationCode!,name: selectedToStation!), travelDate: currentDate, quotaType: selectedQuotaType, coachType: selectedCoachType)
            
            
            nextVc.hidesBottomBarWhenPushed = true
            
            nextVc.title = "Available Trains"
            
            
            
            navigationController?.pushViewController(nextVc, animated: true)
            
            dbManager.insertRecentSearches(fromStationCode: selectedFromStationCode!, toStationCode: selectedToStationCode!, date: selectedDateValue, coachType: selectedCoachType, quotaType: selectedQuotaType,searchTime: Date.now.localDate())
            
        }
        
        else if (fromStationName == nil && toStationName == nil){
            let alertController = UIAlertController(title: nil, message: "Staion Names Cannot Be Empty!", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel)
            
            alertController.view.tintColor = .systemGreen
            
            alertController.addAction(okButton)
            
            present(alertController, animated: true)
        }
        else if (fromStationName != nil && toStationName != nil && fromStationName == toStationName){
            let alertController = UIAlertController(title: nil, message: "Staion Names Cannot Be Same!", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel)
            
            alertController.addAction(okButton)
            
            alertController.view.tintColor = .systemGreen
            
            present(alertController, animated: true)
        }
        else if(fromStationName == nil && toStationName != nil){
            let alertController = UIAlertController(title: nil, message: "From Staion Name Cannot Be Empty!", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel)
            
            alertController.addAction(okButton)
            
            alertController.view.tintColor = .systemGreen
            
            present(alertController, animated: true)
        }
        
        else {
            let alertController = UIAlertController(title: nil, message: "To Staion Name Cannot Be Empty!", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .cancel)
            
            alertController.addAction(okButton)
            
            alertController.view.tintColor = .systemGreen
            
            present(alertController, animated: true)
        }
        
    }
}

extension HomePageViewController : RecentSearchesDisplayTableViewCellDelegate {
    
    
    func selectedRecentSearchValue(recentSearch: (fromStationNameAndCode: (name: String, code: String), toStationNameAndCode: (name: String, code: String), coachType: CoachType, quotaType: QuotaType, searchDate: Date)) {
        
        
        let todayDateString = Date.now.localDate().toString(format: "dd-MM-yyyy")
        
        let searchDateString = recentSearch.searchDate.toString(format: "dd-MM-yyyy")
        
        let dateFormatter = DateFormatter()
        
        let todayDate = dateFormatter.toDate(format: "dd-MM-yyyy", string: todayDateString)
        
        let recentSearchDate = dateFormatter.toDate(format: "dd-MM-yyyy", string: searchDateString)
        
        if todayDate.compare(recentSearchDate) != .orderedDescending {
            
            selectedCoachType = recentSearch.coachType
            selectedQuotaType = recentSearch.quotaType
            selectedDateValue = recentSearch.searchDate
            selectedFromStation = recentSearch.fromStationNameAndCode.name
            selectedToStation = recentSearch.toStationNameAndCode.name
            selectedFromStationCode = recentSearch.fromStationNameAndCode.code
            selectedToStationCode = recentSearch.toStationNameAndCode.code
            searchTrainHeaderView.trainSearchTableView.reloadData()
            searchTrainsButtonClicked()
            
        }
        else {
            let alertController = UIAlertController(title: nil, message: "Date in the Search is passed . Do you want to continue with current Date ?", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Okay", style: .default, handler: {[weak self]_ in
                self!.selectedDateValue = Date.now.localDate()
                self!.searchTrainHeaderView.trainSearchTableView.reloadData()
                self!.selectedCoachType = recentSearch.coachType
                self!.selectedQuotaType = recentSearch.quotaType
                self!.selectedFromStation = recentSearch.fromStationNameAndCode.name
                self!.selectedToStation = recentSearch.toStationNameAndCode.name
                self!.selectedFromStationCode = recentSearch.fromStationNameAndCode.code
                self!.selectedToStationCode = recentSearch.toStationNameAndCode.code
                self!.searchTrainsButtonClicked()
                
                return
            })
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
            
            
            
            alertController.addAction(cancelButton)
            alertController.addAction(okButton)
            
            
            
            alertController.view.tintColor = .systemGreen
            
            present(alertController, animated: true)
        }
        
        
        
    }
    
    
}


extension HomePageViewController : OtherServicesTableViewCellDelegate {
    func otherSrevicesSelected(otherServices: OtherServices) {
        
        if otherServices == .trainSchedule{
            
            let presentVc = TrainSearchTableViewController()
            let searchNavController = UINavigationController(rootViewController: presentVc )
            searchNavController.modalPresentationStyle = .fullScreen
            
            presentVc.delegate = self
            self.present(searchNavController, animated: true)
            
        }
        
       
        else if otherServices == .pnrNumber {
            let nextVc = PnrEnquiryViewController()
            
            
            nextVc.hidesBottomBarWhenPushed = true
            
            nextVc.title = otherServices.rawValue
            
           
            
            navigationController?.pushViewController(nextVc, animated: true)
        }
        
        
        else {
            
            
             let nextVc = TicketLsitViewController()
             
             
             nextVc.hidesBottomBarWhenPushed = true
             
             nextVc.title = otherServices.rawValue
             
             
             navigationController?.pushViewController(nextVc, animated: true)
        }
        
        
    }
    
    
}

extension HomePageViewController : TrainSearchTableViewControllerDelegate {
    
    func presentTrainScheduleFor(trainNumber: Int,trainName:String) {
        
        
       
        let nextVc = TrainScheduleViewController()
        
        
        nextVc.hidesBottomBarWhenPushed = true
        
        nextVc.title = "\(trainName)"
        
        nextVc.setTrainNumber(trainNumber: trainNumber)
        
        
        navigationController?.pushViewController(nextVc, animated: true)
        
       
    }
}
