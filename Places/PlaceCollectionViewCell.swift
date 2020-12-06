//
//  PlaceCollectionViewCell.swift
//  Places
//
//  Created by Ria Vora on 12/6/20.
//

import UIKit
import SnapKit

class PlaceCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var placeCategory: UITextView!
    var placeLocationDescription: UITextView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()

    }
    
    func setUpViews(){
        
        // Help from https://stackoverflow.com/questions/13505379/adding-rounded-corner-and-drop-shadow-to-uicollectionviewcell
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 3.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        placeCategory = UITextView()
        placeCategory.textAlignment = .center
        placeCategory.textColor = .white
        placeCategory.font = UIFont.systemFont(ofSize: 14)
        
        // Helpful website for UI colors: https://www.uicolor.io/
        placeCategory.backgroundColor = UIColor(red: 0.16, green: 0.71, blue: 0.96, alpha: 0.5)
        placeCategory.translatesAutoresizingMaskIntoConstraints = false
        placeCategory.isEditable = false
        placeCategory.isScrollEnabled = false
        contentView.addSubview(placeCategory)
        
        placeLocationDescription = UITextView()
        placeLocationDescription.textAlignment = .center
        placeLocationDescription.textColor = .white
        placeLocationDescription.font = UIFont.systemFont(ofSize: 16)
        
        placeLocationDescription.backgroundColor = UIColor(red: 0.16, green: 0.71, blue: 0.96, alpha: 0.5)
        placeLocationDescription.translatesAutoresizingMaskIntoConstraints = false
        placeLocationDescription.isEditable = false
        placeLocationDescription.isScrollEnabled = false
        contentView.addSubview(placeLocationDescription)
        
    }
    
    func setUpConstraints(){
        placeCategory.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalToSuperview()
        }
        
        imageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(placeCategory.snp.bottom)
            make.bottom.equalToSuperview().offset(-40)
            
        }
        
        placeLocationDescription.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalToSuperview()

        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(place: Place){
        imageView.image = UIImage(named: place.imageName)
        placeCategory.text = place.category.uppercased()
        placeLocationDescription.text = place.locationDescription
    }
    
}
