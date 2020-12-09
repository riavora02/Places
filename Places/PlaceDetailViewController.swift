//
//  PlaceDetailViewController.swift
//  Places
//
//  Created by Ria Vora on 12/8/20.
//

import UIKit
import SnapKit

class PlaceDetailViewController: UIViewController {
    
    var padding = 20
    var currentPlace: Place!
    
    var image: UIImageView!
    var star1: UIImageView!
    var star2: UIImageView!
    var star3: UIImageView!
    var star4: UIImageView!
    var star5: UIImageView!
    var star6: UIImageView!
    
    var categoryName: UITextView!
    var locationDescription: UITextView!
    var notes: UITextView!
    

    init(place: Place){
        super.init(nibName: nil, bundle: nil)
        currentPlace = place
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)
        
        //Reference: https://stackoverflow.com/questions/30545663/transparent-uinavigationbar-in-swift/30545730 to make navigation bar clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
        view.backgroundColor = .white
        
        setUpViews()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setUpViews(){
        image = UIImageView()
        image.image = UIImage(named: currentPlace.imageName)
//        image.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
//        image.tintColor = .black
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        view.addSubview(image)
        
        categoryName = UITextView()
        categoryName.text = currentPlace.category
        categoryName.font = .systemFont(ofSize: 30)
        categoryName.textColor = .darkGray
        categoryName.textAlignment = .left
        categoryName.isEditable = false
        view.addSubview(categoryName)
        
        locationDescription = UITextView()
        locationDescription.text = "Location: " + currentPlace.locationDescription
        locationDescription.font = .systemFont(ofSize: 18 )
        locationDescription.textColor = .lightGray
        locationDescription.textAlignment = .left
        locationDescription.isEditable = false
        view.addSubview(locationDescription)
        
        notes = UITextView()
        notes.text = "Notes: " + currentPlace.notes
        notes.font = .systemFont(ofSize: 18)
        notes.textColor = .lightGray
        notes.textAlignment = .left
        notes.isEditable = false
        view.addSubview(notes)
        
        star1 = UIImageView()
        star1.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        if currentPlace.rating >= 1 {star1.tintColor = .systemYellow}
        else {star1.tintColor = .darkGray}
        star1.contentMode = .scaleAspectFill
        star1.clipsToBounds = true
        view.addSubview(star1)
        
        star2 = UIImageView()
        star2.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        if currentPlace.rating >= 2 {star2.tintColor = .systemYellow}
        else {star2.tintColor = .darkGray}
        star2.contentMode = .scaleAspectFill
        star2.clipsToBounds = true
        view.addSubview(star2)
        
        star3 = UIImageView()
        star3.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        if currentPlace.rating >= 3 {star3.tintColor = .systemYellow}
        else {star3.tintColor = .darkGray}
        star3.contentMode = .scaleAspectFill
        star3.clipsToBounds = true
        view.addSubview(star3)
        
        star4 = UIImageView()
        star4.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        if currentPlace.rating >= 4 {star4.tintColor = .systemYellow}
        else {star4.tintColor = .darkGray}
        star4.contentMode = .scaleAspectFill
        star4.clipsToBounds = true
        view.addSubview(star4)
        
        star5 = UIImageView()
        star5.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        if currentPlace.rating >= 5 {star5.tintColor = .systemYellow}
        else {star5.tintColor = .darkGray}
        star5.contentMode = .scaleAspectFill
        star5.clipsToBounds = true
        view.addSubview(star5)
        
        
        
    }
    
    func setUpConstraints(){
        image.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalToSuperview()
        }
        
        categoryName.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(45)
            make.top.equalTo(image.snp.bottom).offset(padding/2)
        }
        
        star1.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(padding + 5)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(categoryName.snp.bottom).offset(padding/4)
         }
        
        star2.snp.makeConstraints{ make in
            make.leading.equalTo(star1.snp.trailing).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(categoryName.snp.bottom).offset(padding/4)
         }
        
        star3.snp.makeConstraints{ make in
            make.leading.equalTo(star2.snp.trailing).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(categoryName.snp.bottom).offset(padding/4)
         }
        
        star4.snp.makeConstraints{ make in
            make.leading.equalTo(star3.snp.trailing).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(categoryName.snp.bottom).offset(padding/4)
         }
        
        star5.snp.makeConstraints{ make in
            make.leading.equalTo(star4.snp.trailing).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(categoryName.snp.bottom).offset(padding/4)
         }
        
        locationDescription.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(30)
            make.top.equalTo(categoryName.snp.bottom).offset(padding + 10)
        }
        
       notes.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(60)
            make.top.equalTo(locationDescription.snp.bottom).offset(padding/4)
        }
        

    }

}
