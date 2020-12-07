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
    
    var starButton: UIButton!
    var currentPlace: Place!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor(red: 208/255.0, green: 240/255.0, blue: 192/255.0, alpha: 1.0)
        setUpViews()
        setUpConstraints()

    }
    
    func setUpViews(){
        
        // Help from https://stackoverflow.com/questions/13505379/adding-rounded-corner-and-drop-shadow-to-uicollectionviewcell
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        placeCategory = UITextView()
        placeCategory.textAlignment = .center
        placeCategory.textColor = .darkGray
        placeCategory.font = UIFont.systemFont(ofSize: 14)
        
        // Helpful website for UI colors: https://www.uicolor.io/
       // placeCategory.backgroundColor = UIColor(red: 0.16, green: 0.71, blue: 0.96, alpha: 0.5)
        placeCategory.backgroundColor = UIColor(red: 208/255.0, green: 240/255.0, blue: 192/255.0, alpha: 1.0)
        placeCategory.backgroundColor = UIColor(red: 252/255.0, green: 244/255.0, blue: 163/255.0, alpha: 1.0)
        placeCategory.translatesAutoresizingMaskIntoConstraints = false
        placeCategory.isEditable = false
        placeCategory.isScrollEnabled = false
        contentView.addSubview(placeCategory)
        
        placeLocationDescription = UITextView()
        placeLocationDescription.textAlignment = .center
        placeLocationDescription.textColor = .darkGray
        placeLocationDescription.font = UIFont.systemFont(ofSize: 16)
        
        placeLocationDescription.backgroundColor = UIColor(red: 208/255.0, green: 240/255.0, blue: 192/255.0, alpha: 1.0)
        //placeLocationDescription.backgroundColor = UIColor(red: 208/255.0, green: 240/255.0, blue: 192/255.0, alpha: 1)
        placeLocationDescription.translatesAutoresizingMaskIntoConstraints = false
        placeLocationDescription.isEditable = false
        placeLocationDescription.isScrollEnabled = false
        contentView.addSubview(placeLocationDescription)
        
        starButton = UIButton()
//        if let current = currentPlace{
//            if current.isFavorite==true{
//                starButton.setImage(UIImage(named: "favoritestar2"), for: .normal)}
//            else {
//                starButton.setImage(UIImage(named: "favoritestar"), for: .normal)
//            }
//        }
        starButton.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        contentView.addSubview(starButton)
        
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
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-35)
            
        }
        
        placeLocationDescription.snp.makeConstraints{ make in
            //make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-25)
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalToSuperview()

        }
        
        starButton.snp.makeConstraints{ make in
            make.width.equalTo(25)
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-5)

        }
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(place: Place){
        currentPlace = place
        imageView.image = UIImage(named: place.imageName)
        placeCategory.text = place.category.uppercased()
        placeLocationDescription.text = place.locationDescription
        if place.isFavorite==true{
            starButton.setImage(UIImage(named: "favoritestar2"), for: .normal)}
        else {
            starButton.setImage(UIImage(named: "favoritestar"), for: .normal)
        }
    }
    
    @objc func toggleButton(){
        if currentPlace.isFavorite == true {
            
            currentPlace.isFavorite = false
            starButton.setImage(UIImage(named: "favoritestar2"), for: .normal)
        }
        else {
            currentPlace.isFavorite = true
            starButton.setImage(UIImage(named: "favoritestar"), for: .normal)
        }
    }
}
