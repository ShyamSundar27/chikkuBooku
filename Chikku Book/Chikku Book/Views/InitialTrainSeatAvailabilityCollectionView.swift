//
//  TrainSeatAvailabilityCollectionView.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 12/08/22.
//

import UIKit

class InitialTrainSeatAvailabilityCollectionView: UIView {

    var seatAvailabilityCollectionView : UICollectionView? = nil
    
    let seatAvailabilityCollectionViewLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    
    var trainSeatAvailabilityValues : [(coachCode:String,bookingTypeAvailable:TicketAvailabilityStatus,numbersAvailable :Int,fare:Float)] = []
    
    var isValuesSet = false
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        if let seatAvailabilityCollectionView = seatAvailabilityCollectionView{
            seatAvailabilityCollectionView.reloadData()
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(trainSeatAvailabilityValues: [(coachCode:String,bookingTypeAvailable:TicketAvailabilityStatus,numbersAvailable :Int,fare:Float)]){
        self.trainSeatAvailabilityValues = trainSeatAvailabilityValues
        print ("trainSeatAvailabilityValues\(trainSeatAvailabilityValues.count)")
        
       
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("12344567890883232354")
        
        if isValuesSet != true {
            seatAvailabilityCollectionViewLayout.itemSize = CGSize(width: frame.width/3.2, height: frame.height/1.2)
            print("cllayout")
            print((width: frame.width/3.2, height: frame.height/1.2))
            seatAvailabilityCollectionViewLayout.scrollDirection = .horizontal
            seatAvailabilityCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: seatAvailabilityCollectionViewLayout)
            seatAvailabilityCollectionView!.delegate = self
            seatAvailabilityCollectionView!.dataSource = self
            seatAvailabilityCollectionView!.register(AvailabilityDisplayCollectionViewCell.self, forCellWithReuseIdentifier: AvailabilityDisplayCollectionViewCell.identifier)
            seatAvailabilityCollectionView!.showsHorizontalScrollIndicator = false
           
            
            
            isValuesSet = true
            
        }
        

        
        
        addSubview(seatAvailabilityCollectionView!)
    }
    
    
    
    
}

extension InitialTrainSeatAvailabilityCollectionView : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(trainSeatAvailabilityValues.count)
        return trainSeatAvailabilityValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvailabilityDisplayCollectionViewCell.identifier, for: indexPath) as! AvailabilityDisplayCollectionViewCell
                
        cell.backgroundColor = .systemGray6.withAlphaComponent(1)
        cell.layer.cornerRadius = 5
        cell.setLabelValues(labelValues: trainSeatAvailabilityValues[indexPath.row])
        
        
        
        return cell
    }
    
    
    
    
}


