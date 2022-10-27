//
//  HomePageSearchTrainUIView.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 04/08/22.
//

import UIKit

class HomePageSearchTrainUIView: UIView {

    

    weak var dataSource : HomePageSearchTrainViewDataSource? = nil
    
    weak var delegate : HomePageSearchTrainViewDelegete? = nil
    
    
    var trainSearchTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray4
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 55
        
        
        return tableView
    }()
    
    let swapStationButton :UIButton = {
        let button = UIButton()
        button.layer.shadowOffset = CGSize(width: 0, height: 3);
        button.layer.shadowColor = UIColor.darkGray.cgColor;
        button.layer.shadowRadius = 3.0;
        button.layer.shadowOpacity = 0.45;
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBackground.cgColor
    
        return button
    }()
    
    let upsideDownArrowImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.up.arrow.down")
        imageView.tintColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var buttonTopConstraintSet = false
    
    var searchTrainsButton :UIButton = {
        let button = UIButton(type: .system)
        button.layer.shadowOffset = CGSize(width: 0, height: 1);
        button.layer.shadowColor = UIColor.darkGray.cgColor;
        button.layer.shadowRadius = 3.0;
        button.layer.shadowOpacity = 0.45;
        //button.layer.borderWidth = 1
        //button.layer.borderColor = UIColor.systemGray.cgColor
        
        return button
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        trainSearchTableView.separatorColor = .systemGray
        addSubview(trainSearchTableView)
        trainSearchTableView.isScrollEnabled = false
        registerCells()
        addButtonToView()
        setViewElements()
        setConstraints()
        
    
    }
    
    
    func addButtonToView (){
        
//        trainSearchTableView.addSubview(swapStationButton)
//        
//        bringSubviewToFront(swapStationButton)
//        swapStationButton.layer.cornerRadius = 15
//        print("buttoncalled")
//        swapStationButton.addTarget(self, action: #selector(swapButtonClicked), for: .touchUpInside)
        
        
        
        // SearchTrainButton
        
        addSubview(searchTrainsButton)
        searchTrainsButton.clipsToBounds = false
        searchTrainsButton.layer.cornerRadius = 15
        searchTrainsButton.setTitle("Search Trains", for: .normal)
        searchTrainsButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        searchTrainsButton.setTitleColor(.white, for: .normal)
        searchTrainsButton.titleLabel?.font = .systemFont(ofSize: 20)
        setButtonConstraints()
    }
    
    
    
    
    
    
    func setViewElements(){
        
        
        backgroundColor = .systemBackground
        self.layer.shadowOffset = CGSize(width: 0, height: 2);
        self.layer.shadowColor = UIColor.black.cgColor;
        self.layer.shadowRadius = 2;
        self.layer.shadowOpacity = 0.2;
        self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        
    }

    override func layoutSubviews() {
        
        
        self.layer.cornerRadius = self.frame.size.width/2
    
    }
    
    
    
    func setButtonConstraints(){
        

        searchTrainsButton.backgroundColor = .systemGreen
        swapStationButton.backgroundColor = .systemGreen
       
    }
    
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()

        trainSearchTableView.translatesAutoresizingMaskIntoConstraints = false
        //constraints.append(trainSearchTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5))
        constraints.append(trainSearchTableView.heightAnchor.constraint(equalToConstant: 250))
        constraints.append(trainSearchTableView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 1/2.7))
        //constraints.append(trainSearchTableView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10))
        //constraints.append(trainSearchTableView.widthAnchor.constraint(equalTo: self.widthAnchor))
        constraints.append(trainSearchTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        trainSearchTableView.backgroundColor = .systemBackground
        
        
        searchTrainsButton.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(searchTrainsButton.topAnchor.constraint(equalTo: trainSearchTableView.bottomAnchor , constant: 5))
        constraints.append(searchTrainsButton.widthAnchor.constraint(equalTo:trainSearchTableView.widthAnchor,multiplier: 0.6))
        constraints.append(searchTrainsButton.centerXAnchor.constraint(greaterThanOrEqualTo: trainSearchTableView.centerXAnchor))
        constraints.append(searchTrainsButton.heightAnchor.constraint(equalTo:self.heightAnchor,multiplier: 0.15))
//        constraints.append(searchTrainsButton.bottomAnchor.constraint(equalTo:self.bottomAnchor,constant: -15))

        NSLayoutConstraint.activate(constraints)
    }
    
    
    func registerCells(){
        
        trainSearchTableView.delegate = self
        trainSearchTableView.dataSource = self
        trainSearchTableView.tag = Numbers.one.rawValue
        
        //trainSearchTableView.register(SearchStationInputTableViewCell.self, forCellReuseIdentifier: SearchStationInputTableViewCell.identifier)
        
        trainSearchTableView.register(JourneyDateSelecterTableViewCell.self, forCellReuseIdentifier: JourneyDateSelecterTableViewCell.identifier)
        
        trainSearchTableView.register(QuotaAndCoachTypeSelectionTableViewCell.self, forCellReuseIdentifier: QuotaAndCoachTypeSelectionTableViewCell.identifier)
        
        trainSearchTableView.register(SearchStationInputsTableViewCell.self, forCellReuseIdentifier: SearchStationInputsTableViewCell.identifier)
        

    }
    
    
    
    
    
    
    @objc func searchButtonClicked(){
        delegate?.searchTrainsButtonClicked()
    }
    

}

extension HomePageSearchTrainUIView :UITableViewDataSource,UITableViewDelegate ,QuotaTypeOrCoachTypeCellDataSource ,QuotaTypeOrCoachTypeCellDelegate, SearchStationInputsTableViewCellDelegate,JourneyDateSelecterTableViewCellDelegate{
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 2{
            let cell4 = tableView.dequeueReusableCell(withIdentifier: QuotaAndCoachTypeSelectionTableViewCell.identifier, for: indexPath) as! QuotaAndCoachTypeSelectionTableViewCell
            cell4.preservesSuperviewLayoutMargins = false
            
            cell4.delegate = self
            cell4.dataSource = self
            cell4.setLabelValues()
            cell4.separatorInset = UIEdgeInsets.zero
            cell4.layoutMargins = UIEdgeInsets.zero
            cell4.selectionStyle = .none
            return cell4
        }
        
        
        if indexPath.row == 1{
            
            let cell3 = tableView.dequeueReusableCell(withIdentifier: JourneyDateSelecterTableViewCell.identifier, for: indexPath) as! JourneyDateSelecterTableViewCell
            cell3.preservesSuperviewLayoutMargins = false
            cell3.delegate = self
            cell3.separatorInset = UIEdgeInsets.zero
            cell3.layoutMargins = UIEdgeInsets.zero
            cell3.journeyDateSelector.date = dataSource!.getSelectedDateValue()
            cell3.selectionStyle = .none
            return cell3
        }
    

        

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchStationInputsTableViewCell.identifier, for: indexPath) as! SearchStationInputsTableViewCell
            cell.configureTextFieldValue(fromStation: dataSource!.getSelectedFromStationValue(), toStation: dataSource!.getSelectedToStationValue())
            cell.delegate = self
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            cell.selectionStyle = .none
            
            return cell            
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        
        if indexPath.row == 2{
            //return self.frame.height/4
            return 90
        }
        if indexPath.row == 1{
            //return self.frame.height/7
            return 60
        }

        
        //return self.frame.height/3.5
        return 90
        
        
    }
    func getQuotaTypeSelectedValue() -> String {
        return dataSource?.getQuotaTypeSelectedValue()  ?? "General"
    }
    
    func getCoachTypeSelectedValue() -> String {
        return dataSource?.getCoachTypeSelectedValue()  ?? "Sleeper"
    }
    
    func presentQuotaTypeSelector() {
        delegate!.presentQuotaTypeSelector()
    }
    
    func presentCoachTypeSelector() {
        delegate!.presentCoachTypeSelector()

    }
    
    
    func presentSearchFromStationVc() {
        delegate?.presentSearchFromStationVc()
    }
    
    func presentSearchToStationVc() {
        delegate?.presentSearchToStationVc()
    }
    
    func selectedDateValue(date: Date) {
        delegate?.selectedDateValue(selectedDate: date)
    }
    
   
    func swapButtonClicked(){
        if !(dataSource?.getSelectedFromStationValue().isEmpty)! && !(dataSource?.getSelectedToStationValue().isEmpty)!{
            delegate?.swapSelectedStations()
            trainSearchTableView.reloadData()
        }
    }
    
    func getDate () -> Date {
        let cell  = trainSearchTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! JourneyDateSelecterTableViewCell
        return cell.getDate()
    }
}
