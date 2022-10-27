//
//  ThemeChangerTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-15059 on 13/09/22.
//

import UIKit

class ThemeChangerTableViewCell: UITableViewCell {
    
    static let identifier = "ThemeChangerTableViewCell"

    
    
    var themeSegmentedControl : UISegmentedControl? = nil
    
    let appThemeLabel : UILabel = {
        let label = UILabel()
        label.text = "App Theme"
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(appThemeLabel)
        
        
        setSegementedValues()
        contentView.addSubview(themeSegmentedControl!)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setSegementedValues() {
        
        
        themeSegmentedControl = UISegmentedControl(items: ["System","Light","Dark"])
        
        if let themeSegmentedControl = themeSegmentedControl {
            themeSegmentedControl.selectedSegmentIndex = Theme.init(rawValue: UserDefaults.standard.integer(forKey: "theme"))?.rawValue ?? 0
            
            print(" selectedSegmentIndex \(UserDefaults.standard.integer(forKey: "theme"))  ")
            //bookingsSegementedControl!.tintColor = .systemGreen
            themeSegmentedControl.selectedSegmentTintColor = .systemGreen
            themeSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
            themeSegmentedControl.addTarget(self,
                                            action: #selector(segmentedControlAction),
                                            for: .valueChanged)
        }
       
    }
    
    @objc func segmentedControlAction (){
        
        let selectedIndex = themeSegmentedControl?.selectedSegmentIndex
        
        UserDefaults.standard.set(selectedIndex, forKey: "theme")
            
        
    
        
       
    }
    
    
    func setConstraints () {
        
        var constraints = [NSLayoutConstraint]()
        
        appThemeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //constraints.append(addPassengerButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        //constraints.append(addPassengerButton.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.8))
        //constraints.append(addPassengerButton.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.45))
        constraints.append(appThemeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20))
        constraints.append(appThemeLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10))
        constraints.append(appThemeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10))
        
        themeSegmentedControl!.translatesAutoresizingMaskIntoConstraints = false
        
        
        //constraints.append(addExistingPassengerButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        //constraints.append(addExistingPassengerButton.heightAnchor.constraint(equalTo: contentView.heightAnchor,multiplier: 0.8))
        constraints.append( themeSegmentedControl!.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -20))
        //constraints.append(addExistingPassengerButton.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.45))
        constraints.append( themeSegmentedControl!.topAnchor.constraint(equalTo: appThemeLabel.topAnchor))
        constraints.append( themeSegmentedControl!.bottomAnchor.constraint(equalTo: appThemeLabel.bottomAnchor))

        
        
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
