//
//  SearchStationInputsTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 20/08/22.
//

import UIKit

class SearchStationInputsTableViewCell: UITableViewCell {
    
    
    static let identifier = "SearchStationInputTableViewCell"
    
    
    weak var delegate : SearchStationInputsTableViewCellDelegate? = nil
    

    
    
    var textFieldIdentifier : String = ""
    
    var fromStationNameTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .systemBackground
        textField.keyboardType = .alphabet
        textField.textColor = .systemGray
        
        
        return textField
    }()
    
    
    var toStationNameTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .systemBackground
        textField.keyboardType = .alphabet
        textField.textColor = .systemGray
        
        
        return textField
    }()
    let imageForFromStation = UIImage(systemName: "train.side.front.car")!
    
    let imagesForToStation = UIImage(systemName: "train.side.front.car")!
    
    let fromStationImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
        
        
        return imageView
    }()
    
    let toStationImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
        
        return imageView
    }()
    
    let centerLineView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray.withAlphaComponent(0.6)
        return view
    }()
    
    
    let swapStationButton :UIButton = {
        let button = UIButton()
        button.layer.shadowOffset = CGSize(width: 0, height: 3);
        button.layer.shadowColor = UIColor.darkGray.cgColor;
        button.layer.shadowRadius = 3.0;
        button.layer.shadowOpacity = 0.45;
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
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
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setImagesToImageViews()
        fromStationNameTextField.tag = 1
        toStationNameTextField.tag = 2
        
        contentView.addSubview(fromStationNameTextField)
        contentView.addSubview(toStationNameTextField)
        contentView.addSubview(fromStationImageView)
        contentView.addSubview(toStationImageView)
        contentView.addSubview(centerLineView)
        contentView.addSubview(swapStationButton)
        
        
        swapStationButton.addSubview(upsideDownArrowImageView)
        swapStationButton.backgroundColor = .systemGreen
        bringSubviewToFront(swapStationButton)
        swapStationButton.addTarget(self, action: #selector(swapStationButtonClicked), for: .touchUpInside)
        
        fromStationImageView.contentMode = .scaleAspectFit
        toStationImageView.contentMode = .scaleAspectFit
        
        

        setConstraints()
        contentView.backgroundColor = .systemBackground
        fromStationNameTextField.delegate = self
        toStationNameTextField.delegate = self
    }
    
    
    func setImagesToImageViews(){
        fromStationImageView.image = imageForFromStation
        fromStationImageView.tintColor = .systemGreen
        
        toStationImageView.image = imagesForToStation
        toStationImageView.tintColor = .systemGreen
        toStationImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
   
    func configureTextFieldValue(fromStation:String,toStation:String){
       
        fromStationNameTextField.placeholder = "From Station"
        toStationNameTextField.placeholder = "To Station"
        
       
    
        fromStationNameTextField.font = .monospacedSystemFont(ofSize: 17, weight: .medium)
        toStationNameTextField.font = .monospacedSystemFont(ofSize: 17, weight: .medium)
        
//        fromStationNameTextField.font = .preferredFont(forTextStyle: .body)
//        toStationNameTextField.font = .preferredFont(forTextStyle: .body)
        fromStationNameTextField.text = fromStation
        toStationNameTextField.text = toStation
            
            
      
        
    }
    func setConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        centerLineView.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(centerLineView.leftAnchor.constraint(equalTo: contentView.leftAnchor))
        constraints.append(centerLineView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(centerLineView.heightAnchor.constraint(equalToConstant: 0.6))
        constraints.append(centerLineView.widthAnchor.constraint(equalTo: contentView.widthAnchor))
        
        
        fromStationNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(fromStationNameTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10))
        constraints.append(fromStationNameTextField.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5))
        constraints.append(fromStationNameTextField.bottomAnchor.constraint(equalTo: centerLineView.topAnchor))
        constraints.append(fromStationNameTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.79))
        
        fromStationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(fromStationImageView.centerYAnchor.constraint(equalTo: fromStationNameTextField.centerYAnchor))
        constraints.append(fromStationImageView.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(fromStationImageView.widthAnchor.constraint(equalToConstant: 30))
        constraints.append(fromStationImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10))
        
        
        
        
        toStationNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(toStationNameTextField.rightAnchor.constraint(equalTo: fromStationNameTextField.rightAnchor))
        constraints.append(toStationNameTextField.topAnchor.constraint(equalTo: centerLineView.bottomAnchor))
        constraints.append(toStationNameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        constraints.append(toStationNameTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.79))
        
        
        toStationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(toStationImageView.centerYAnchor.constraint(equalTo:toStationNameTextField.centerYAnchor))
        //constraints.append(toStationImageView.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(toStationImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10))
        //constraints.append(toStationImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1))
        constraints.append(toStationImageView.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(toStationImageView.widthAnchor.constraint(equalToConstant: 30))
        //constraints.append(toStationImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5))
        
       
        swapStationButton.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(swapStationButton.centerYAnchor.constraint(equalTo:centerLineView.centerYAnchor))
        constraints.append(swapStationButton.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -30))
        constraints.append(swapStationButton.heightAnchor.constraint(equalToConstant: 40))
        constraints.append(swapStationButton.widthAnchor.constraint(equalToConstant: 40))
        
        
        upsideDownArrowImageView.translatesAutoresizingMaskIntoConstraints = false

        constraints.append(upsideDownArrowImageView.centerYAnchor.constraint(equalTo: swapStationButton.centerYAnchor))
        constraints.append(upsideDownArrowImageView.centerXAnchor.constraint(equalTo: swapStationButton.centerXAnchor))
  

        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc func clicked(){
        print("button clicked")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
                   swapStationButton.layer.borderColor = UIColor.systemBackground.cgColor
               }
    }
    
    @objc func swapStationButtonClicked(){
        
        

        if !fromStationNameTextField.text!.isEmpty && !toStationNameTextField.text!.isEmpty{
            
            UIView.animate(withDuration: 0.5) { [weak self] in
                self!.upsideDownArrowImageView.transform = CGAffineTransform(rotationAngle: -(22/7))
            } completion: { [weak self] _ in
                self!.upsideDownArrowImageView.transform = CGAffineTransform(rotationAngle: .zero)
                self!.delegate?.swapButtonClicked()
            }
            
            

        }
        
       
        
    }

}

extension SearchStationInputsTableViewCell : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            delegate?.presentSearchFromStationVc()
        }
        else{
            delegate?.presentSearchToStationVc()
        }
        print("Caledd text field")
        textField.resignFirstResponder()
    }
}


