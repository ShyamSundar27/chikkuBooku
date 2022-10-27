//
//  SearchStationInputTableViewCell.swift
//  Railway Reservation System
//
//  Created by shyam-pt5397 on 04/08/22.
//

import UIKit

class SearchStationInputTableViewCell: UITableViewCell {
    
    
    static let identifier = "SearchStationInputTableViewCell"
    
    
    weak var searchStationInputTableViewCellDelegate : SearchStationInputTableViewCellDelegate? = nil
    
//    weak var searchStationInputTableViewCellDataSource : SearchStationInputTableViewCellDataSource? = nil
    
    var textFieldIdentifier : String = ""
    
    var stationNameTextField : UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .systemBackground
        textField.keyboardType = .alphabet
        textField.textColor = .systemGray
        
        
        return textField
    }()
    
    
    
    let imageForFromStation = UIImage(systemName: "figure.walk")!
    
    let imagesForToStation = UIImage(systemName: "figure.walk")!
    
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setImagesToImageViews()
        contentView.addSubview(stationNameTextField)
        contentView.backgroundColor = .systemBackground
        stationNameTextField.delegate = self
    }
    func setImagesToImageViews(){
        fromStationImageView.image = imageForFromStation
        
        toStationImageView.image = imagesForToStation
        toStationImageView.transform = CGAffineTransform(scaleX: -1, y: 1)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
   
    func configureTextFieldValueAndImage(defaultText:String,arrivalOrDepartureImage:UIImage){
       
        stationNameTextField.placeholder = textFieldIdentifier
        stationNameTextField.text = defaultText
        if textFieldIdentifier == "From Station"{
            contentView.addSubview(fromStationImageView)
            setFromStationViewConstraints()
            fromStationImageView.contentMode = .scaleAspectFit
        }
        
        else{
            contentView.addSubview(toStationImageView)
            setToStationViewConstraints()
            toStationImageView.contentMode = .scaleAspectFit
        }
        
        
    }
    func setFromStationViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        fromStationImageView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(fromStationImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(fromStationImageView.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(fromStationImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10))
        constraints.append(fromStationImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1))
        
        stationNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(stationNameTextField.leftAnchor.constraint(equalTo: fromStationImageView.rightAnchor, constant: 20))
        constraints.append(stationNameTextField.centerYAnchor.constraint(equalTo: fromStationImageView.centerYAnchor))
        constraints.append(stationNameTextField.heightAnchor.constraint(equalTo: fromStationImageView.heightAnchor,constant: 20))
        constraints.append(stationNameTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.8))
        
//        constraints.append(swapStationButton.heightAnchor.constraint(equalToConstant: 40))
//        constraints.append(swapStationButton.widthAnchor.constraint(equalToConstant: 40))
//        constraints.append(swapStationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20))
//        constraints.append(swapStationButton.topAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20))

        NSLayoutConstraint.activate(constraints)
        
    }
    func setToStationViewConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        toStationImageView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(toStationImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
        constraints.append(toStationImageView.heightAnchor.constraint(equalToConstant: 30))
        constraints.append(toStationImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10))
        constraints.append(toStationImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1))
        
        stationNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(stationNameTextField.leftAnchor.constraint(equalTo: toStationImageView.rightAnchor, constant: 20))
        constraints.append(stationNameTextField.centerYAnchor.constraint(equalTo: toStationImageView.centerYAnchor))
        constraints.append(stationNameTextField.heightAnchor.constraint(equalTo: toStationImageView.heightAnchor,constant: 20))
        constraints.append(stationNameTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 0.8))
        

        
        //contentView.clipsToBounds = false
        NSLayoutConstraint.activate(constraints)
        
    }
    
    @objc func clicked(){
        print("button clicked")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

extension SearchStationInputTableViewCell : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchStationInputTableViewCellDelegate?.presentSearchStationVc(identifier: textFieldIdentifier)
        print("Caledd text field")
        stationNameTextField.resignFirstResponder()
    }
}
