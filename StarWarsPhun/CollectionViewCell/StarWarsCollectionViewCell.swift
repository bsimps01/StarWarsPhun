//
//  StarWarsTableViewCell.swift
//  StarWarsPhun
//
//  Created by Benjamin Simpson on 2/8/22.
//

import Foundation
import UIKit

class StarWarsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    static let reuseIdentifier = "StarWarsCollectionCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()
    
    private let descripLabel: UILabel = {
        let des = UILabel()
        des.textColor = .white
        des.font = .boldSystemFont(ofSize: 17)
        des.numberOfLines = 2
        return des
    }()
    
    private let dateLabel: UILabel = {
        let date = UILabel()
        date.textColor = .white
        date.font = .boldSystemFont(ofSize: 15)
        return date
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    //MARK: - Helper
    override init(frame: CGRect) {
        super.init(frame: frame)
        //add views
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(descripLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(swDetails: StarWarsDetails){
        //configures info in cell
        let imageView = UIImageView(image: swDetails.image)
        backgroundView = imageView
        titleLabel.text = swDetails.title
        dateLabel.text = swDetails.date
        locationLabel.text = swDetails.location
        descripLabel.text = swDetails.description
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Constraints for labels
        
        //date
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        //title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 31).isActive = true
        
        //loc
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        //desc
        descripLabel.translatesAutoresizingMaskIntoConstraints = false
        descripLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8).isActive = true
        descripLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24).isActive = true
        descripLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -24).isActive = true
        descripLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24).isActive = true
    }
}
