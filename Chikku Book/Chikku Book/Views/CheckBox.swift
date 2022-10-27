//
//  CheckBox.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 30/08/22.
//

import UIKit

class CheckBox: UIButton {

    
    // Images
    let checkedImage = UIImage(systemName: "square")!
    
    let uncheckedImage = UIImage(systemName: "checkmark.square.fill")!
    
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
        self.tintColor = .systemGreen
        //backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }


    
        
}
