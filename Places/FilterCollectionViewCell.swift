//
//  FilterCollectionViewCell.swift
//  rhv26_p5
//
//  Created by Ria Vora on 10/25/20.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    var filterLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.masksToBounds = true
        
        filterLabel = UILabel()
        filterLabel.textAlignment = .center
        filterLabel.font = UIFont.systemFont(ofSize: 16)
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(filterLabel)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            //filterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            filterLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        
    }
    
    func configure(filter: Filter){
        filterLabel.text = filter.name
        
        if filter.isSelected == false {
            filterLabel.backgroundColor = UIColor(red: 0.91, green: 0.96, blue: 0.97, alpha: 1.00)
            filterLabel.textColor = UIColor(red: 0.16, green: 0.71, blue: 0.96, alpha: 0.5)
        }
        if filter.isSelected == true {
            filterLabel.backgroundColor = UIColor(red: 0.16, green: 0.71, blue: 0.96, alpha: 0.5)
            filterLabel.textColor = UIColor(red: 0.91, green: 0.96, blue: 0.97, alpha: 1.00)
        }
        
    }
    
 
}
