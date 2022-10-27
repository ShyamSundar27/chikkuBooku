//
//  SwapButtonTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 04/08/22.
//

import UIKit

class SwapButtonTableViewCell: UITableViewCell {

    
    static let identifier = "SwapButtonTableViewCell"
    let swapStationButton :UIButton = {
        let button = UIButton()
        button.layer.shadowOffset = CGSize(width: 0, height: 2);
        button.layer.shadowColor = UIColor.black.cgColor;
        button.layer.shadowRadius = 1;
        button.layer.shadowOpacity = 0.25;
    
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = false
        //bringSubviewToFront(swapStationButton)
        addSubview(swapStationButton)
        swapStationButton.addTarget(self, action: #selector(swapButtonClicked), for: .touchUpInside)
        swapStationButton.layer.cornerRadius = 15
        setConstraints()
    }
    
    @objc func swapButtonClicked(){
        print("swapButtonClicked")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints(){
        var constraints = [NSLayoutConstraint]()

        swapStationButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(swapStationButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant:  60-20))
        constraints.append(swapStationButton.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(swapStationButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant: 290))
        constraints.append(swapStationButton.widthAnchor.constraint(equalToConstant: 40))
        swapStationButton.backgroundColor = .systemGreen
    
        NSLayoutConstraint.activate(constraints)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
