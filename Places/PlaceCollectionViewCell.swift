//
//  PlaceCollectionViewCell.swift
//  Places
//
//  Created by Ria Vora on 12/6/20.
//

import UIKit
import SnapKit
import Kingfisher

class PlaceCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var placeCategory: UITextView!
    var placeLocationDescription: UITextView!
    
    var starButton: UIImageView!
    var currentPlace: Place!
    var markedFavorite: Bool = false
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
       // contentView.backgroundColor = UIColor(red: 208/255.0, green: 240/255.0, blue: 192/255.0, alpha: 1.0)
        contentView.backgroundColor = UIColor.white
        setUpViews()
        setUpConstraints()

    }
    
    func setUpViews(){
        
        // Help from https://stackoverflow.com/questions/13505379/adding-rounded-corner-and-drop-shadow-to-uicollectionviewcell
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        placeCategory = UITextView()
        placeCategory.textAlignment = .left
        placeCategory.textColor = .darkGray
        placeCategory.font = UIFont.systemFont(ofSize: 18)
        
        // Helpful website for UI colors: https://www.uicolor.io/
       // placeCategory.backgroundColor = UIColor(red: 0.16, green: 0.71, blue: 0.96, alpha: 0.5)
        //placeCategory.backgroundColor = UIColor(red: 208/255.0, green: 240/255.0, blue: 192/255.0, alpha: 1.0)
        //placeCategory.backgroundColor = UIColor(red: 235/255.0, green: 247/255.0, blue: 251/255.0, alpha: 1.0)
        placeCategory.translatesAutoresizingMaskIntoConstraints = false
        placeCategory.isEditable = false
        placeCategory.isScrollEnabled = false
        
        placeLocationDescription = UITextView()
        placeLocationDescription.textAlignment = .left
        placeLocationDescription.textColor = .lightGray
        placeLocationDescription.font = UIFont.systemFont(ofSize: 14)
        
        //placeLocationDescription.backgroundColor = UIColor(red: 208/255.0, green: 240/255.0, blue: 192/255.0, alpha: 1.0)
        
        //placeLocationDescription.backgroundColor = UIColor(red: 235/255.0, green: 247/255.0, blue: 251/255.0, alpha: 1.0)
        placeLocationDescription.translatesAutoresizingMaskIntoConstraints = false
        placeLocationDescription.isEditable = false
        placeLocationDescription.isScrollEnabled = true
        contentView.addSubview(placeLocationDescription)
        
        contentView.addSubview(placeCategory)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggle(gesture:)))
        starButton = UIImageView()
        starButton.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate).withTintColor(.lightGray)
        starButton.tintColor = UIColor.lightGray
        starButton.contentMode = .scaleAspectFill
        starButton.clipsToBounds = true
        starButton.isUserInteractionEnabled = true
        starButton.addGestureRecognizer(tapGestureRecognizer)
        if markedFavorite == true {
            starButton.tintColor = .yellow
        }
        else {
            starButton.tintColor = .lightGray
            
        }
        contentView.addSubview(starButton)
        
    }
    
    func setUpConstraints(){
        
        imageView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.equalToSuperview()
            //make.bottom.equalToSuperview().offset(60)
            make.height.equalTo(110)
            
        }
        
        placeCategory.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalTo(imageView.snp.bottom)
            make.height.equalTo(30)
            make.width.equalToSuperview().offset(-10)
        }
        
        placeLocationDescription.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(10)
            make.width.equalToSuperview().offset(-10)
            make.top.equalTo(placeCategory.snp.bottom)
            make.bottom.equalToSuperview().offset(-5)
            //make.height.equalTo(20)

        }
        
        starButton.snp.makeConstraints{ make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-10)

        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(place: Place){
        currentPlace = place
        let photoURL = URL(string: currentPlace.image_url)
        imageView.kf.setImage(with: photoURL)
        placeCategory.text = place.types
        placeLocationDescription.text = place.name
    }
    
    @objc func toggle(gesture: UITapGestureRecognizer){
        if starButton.tintColor == .lightGray {
            NetworkManager.addFavorite(placeID: currentPlace.id){
                completion in self.starButton.tintColor = .systemYellow
            }
        }
        else {
            NetworkManager.removeFavorite(placeID: currentPlace.id){
                completion in self.starButton.tintColor = .lightGray
            }
        }
    }
}
