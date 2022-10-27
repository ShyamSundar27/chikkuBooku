//
//  PrefferedCoachViewController.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 15/09/22.
//

import UIKit

class PrefferedCoachViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    var coachesColletionView : UICollectionView
    
    weak var delegate : PrefferedCoachViewControllerDelegate? = nil
    
    let coachesCollectionViewLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    var numberOfCoaches =  0
    
    var coachName = ""
    
    init(){

        coachesCollectionViewLayout.scrollDirection = .vertical
        
        coachesColletionView = UICollectionView(frame: .zero, collectionViewLayout: coachesCollectionViewLayout)
        
        
        
        
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()

        coachesColletionView.showsHorizontalScrollIndicator = false
        
        view.backgroundColor = .systemBackground
        coachesColletionView.delegate = self
        coachesColletionView.dataSource = self
        view.addSubview(coachesColletionView)
        setConstraints()
        registerCells()
        coachesColletionView.isScrollEnabled = true
        coachesColletionView.showsVerticalScrollIndicator = false
        title = "Select Coach Number"
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(leftBarButtonClicked))
        navigationItem.leftBarButtonItem?.tintColor = .systemRed
        
//        registerCells()
        
        
    }
    
    
    
    
    @objc func leftBarButtonClicked() {
        self.dismiss(animated: true)
    }
    
    
    func setCoachValue (coachType : CoachType , numberOfCoaches : Int){
        
        
        coachName = DBManager.getInstance().getCoachDetails(coachType: coachType)!.coachName
        
        self.numberOfCoaches = numberOfCoaches
        
    }
    
    func setConstraints () {
        
       
            
            var constraints = [NSLayoutConstraint]()
            
            
            coachesColletionView.translatesAutoresizingMaskIntoConstraints = false
            constraints.append(coachesColletionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20))
            constraints.append(coachesColletionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30))
            constraints.append(coachesColletionView.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -60))
            constraints.append(coachesColletionView.bottomAnchor.constraint(equalTo:view.bottomAnchor,constant: -15))
            
            NSLayoutConstraint.activate(constraints)
            
       
    }
    
    func registerCells() {
        
        coachesColletionView.register(CoachDisplayCollectionViewCell.self, forCellWithReuseIdentifier: CoachDisplayCollectionViewCell.identifier)
        
    }
    

}


extension PrefferedCoachViewController{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCoaches
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoachDisplayCollectionViewCell.identifier, for: indexPath) as! CoachDisplayCollectionViewCell
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 5
        
        cell.layer.cornerRadius = 10
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 0.2
        
        cell.setLabelValues(coachName: "\(coachName)\(indexPath.row + 1)")
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width/3.9, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        delegate?.selectedCoachName(coachName: "\(coachName)\(indexPath.row + 1)")
        
        self.dismiss(animated: true)
    }
}
