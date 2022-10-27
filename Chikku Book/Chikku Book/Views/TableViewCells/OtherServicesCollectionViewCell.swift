//
//  OtherServicesCollectionViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 06/09/22.
//

import UIKit

class OtherServicesCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "OtherServicesCollectionViewCell"
    
    
    let cellView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 2);
        view.layer.shadowColor = UIColor.black.cgColor;
        view.layer.shadowRadius = 2;
        view.layer.shadowOpacity = 0.2;
        return view
    }()
    
    let cellImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemBackground
        
        return imageView
    }()
    
    let cellLabel : UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        
        contentView.addSubview(cellLabel)
        contentView.addSubview(cellView)
        cellView.addSubview(cellImageView)
        
        cellImageView.backgroundColor = .systemGreen
        contentView.backgroundColor = .secondarySystemBackground
        cellView.backgroundColor = .systemGreen
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        
        
        constraints.append(cellView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        constraints.append(cellView.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.8))
        constraints.append(cellView.heightAnchor.constraint(equalTo: cellView.widthAnchor))
        constraints.append(cellView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10))
        
        
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(cellImageView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor))
        constraints.append(cellImageView.widthAnchor.constraint(equalTo: cellView.widthAnchor,multiplier: 0.8))
        constraints.append(cellImageView.heightAnchor.constraint(equalTo: cellView.heightAnchor))
        constraints.append(cellImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor))
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(cellLabel.topAnchor.constraint(equalTo: cellView.bottomAnchor,constant:8))
        constraints.append(cellLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.9))
        constraints.append(cellLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        
    
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    func setValues (text:String,image:UIImage){
        
        
        cellLabel.text = text
        cellImageView.image = image
    }
}
