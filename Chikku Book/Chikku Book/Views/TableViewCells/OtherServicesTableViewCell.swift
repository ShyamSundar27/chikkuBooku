//
//  OtherServicesTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 06/09/22.
//

import UIKit

class OtherServicesTableViewCell: UITableViewCell {
    
    static let identifier = "OtherServicesTableViewCell"
        
    var otherServicesCollectionView : UICollectionView? = nil
    
    let otherServicesCollectionViewLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    weak var delegate : OtherServicesTableViewCellDelegate? = nil
    
    
    let labelValues = [OtherServices.pnrNumber, OtherServices.trainSchedule, OtherServices.cancelTicket, OtherServices.upcomingJourney]
    
    let imageValues = [UIImage(systemName: "ticket")!,UIImage(systemName: "tram.circle")!,UIImage(systemName: "xmark.square")!,UIImage(systemName: "clock.arrow.circlepath")!]
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        
        otherServicesCollectionViewLayout.itemSize = CGSize(width: 75, height: 130)
        
        
        print("height of collectionView \(contentView.frame.width)")
        
        otherServicesCollectionViewLayout.scrollDirection = .vertical
        
        otherServicesCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: otherServicesCollectionViewLayout)

        otherServicesCollectionView!.delegate = self
        otherServicesCollectionView!.dataSource = self
        otherServicesCollectionView!.register(OtherServicesCollectionViewCell.self, forCellWithReuseIdentifier: OtherServicesCollectionViewCell.identifier)
        otherServicesCollectionView!.showsHorizontalScrollIndicator = false
        //seatAvailabilityCollectionView?.backgroundColor = .secondarySystemBackground
        otherServicesCollectionView?.backgroundColor = .secondarySystemBackground
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(otherServicesCollectionView!)
        otherServicesCollectionView?.isScrollEnabled = false
        registerCells()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraints(){
        
        
        if let otherServicesCollectionView = otherServicesCollectionView {
            
            var constraints = [NSLayoutConstraint]()
            otherServicesCollectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

            otherServicesCollectionView.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(otherServicesCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor))
            constraints.append(otherServicesCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor))
            constraints.append(otherServicesCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10))
            constraints.append(otherServicesCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10 ))
            
            NSLayoutConstraint.activate(constraints)
        }
        
        
        

        
        
    }
    
    func registerCells (){
        otherServicesCollectionView!.register(OtherServicesCollectionViewCell.self, forCellWithReuseIdentifier: OtherServicesCollectionViewCell.identifier)
    }
    
}

extension OtherServicesTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OtherServicesCollectionViewCell.identifier, for: indexPath) as! OtherServicesCollectionViewCell
        cell.setValues(text: labelValues[indexPath.row].rawValue, image: imageValues[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        delegate?.otherSrevicesSelected(otherServices: labelValues[indexPath.row])
       
    }
    
    
}
