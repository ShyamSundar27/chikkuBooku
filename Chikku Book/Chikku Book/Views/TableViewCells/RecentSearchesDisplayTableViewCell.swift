//
//  RecentSearchesDisplayTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 05/09/22.
//

import UIKit

class RecentSearchesDisplayTableViewCell: UITableViewCell {
    
    static let identifier = "RecentSearchesDisplayTableViewCell"
    
    var recentSearchCollectionView : UICollectionView? = nil
    
    let recentSearchCollectionViewLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var recentSearchData :[( fromStationNameAndCode : (name:String,code:String), toStationNameAndCode : (name:String,code:String), coachType:CoachType ,quotaType:QuotaType,searchDate :Date)] = []
    
    
    weak var delegate : RecentSearchesDisplayTableViewCellDelegate? = nil
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = .secondarySystemBackground
        recentSearchCollectionViewLayout.itemSize = CGSize(width: 200, height: 120)
        
        recentSearchCollectionViewLayout.scrollDirection = .horizontal
        recentSearchCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: recentSearchCollectionViewLayout)

        recentSearchCollectionView!.delegate = self
        recentSearchCollectionView!.dataSource = self
        recentSearchCollectionView!.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
        recentSearchCollectionView!.showsHorizontalScrollIndicator = false
        //seatAvailabilityCollectionView?.backgroundColor = .secondarySystemBackground
        recentSearchCollectionView?.backgroundColor = .secondarySystemBackground
        contentView.addSubview(recentSearchCollectionView!)
        setConstraints()
        
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerCells(){
        recentSearchCollectionView!.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
    }
    
    func setConstraints(){
        
        if let recentSearchCollectionView = recentSearchCollectionView {
            
            var constraints = [NSLayoutConstraint]()
            recentSearchCollectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

            recentSearchCollectionView.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(recentSearchCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor))
            constraints.append(recentSearchCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor))
            constraints.append(recentSearchCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10))
            constraints.append(recentSearchCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10 ))
            
            NSLayoutConstraint.activate(constraints)
        }
    }
    
   
    
    func setDefaultValues(recentSearches : [( fromStationNameAndCode : (name:String,code:String), toStationNameAndCode : (name:String,code:String), coachType:CoachType ,quotaType:QuotaType,searchDate :Date)]){
        self.recentSearchData = recentSearches
        
        
        if recentSearchData.isEmpty {
            
            let noSearchesLabel : UILabel = {
                let label = UILabel()
                label.text = "No Recent Searches"
                label.textColor = .systemGray
                label.textAlignment = .center
                label.layer.cornerRadius = 20
                label.layer.masksToBounds = true
                return label
            }()
            
            contentView.addSubview(noSearchesLabel)
            var constraints = [NSLayoutConstraint]()
            
            noSearchesLabel.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(noSearchesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
            constraints.append(noSearchesLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
            constraints.append(noSearchesLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor,constant: -20))
            constraints.append(noSearchesLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,constant: -20))
            
            noSearchesLabel.backgroundColor = .systemBackground
            
            
            NSLayoutConstraint.activate(constraints)
            
        }
        
        
        
    }
}


extension RecentSearchesDisplayTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return recentSearchData.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as! RecentSearchCollectionViewCell
        let recentData = recentSearchData[indexPath.row]
        cell.setValues(recentData: (fromStationNameAndCode: recentData.fromStationNameAndCode, toStationNameAndCode:recentData.toStationNameAndCode, recentData.coachType, recentData.quotaType, recentData.searchDate))
        
        
        
        return cell
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.selectedRecentSearchValue(recentSearch: recentSearchData[indexPath.row])
    }

}

