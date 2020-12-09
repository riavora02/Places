//
//  ReviewCollectionViewCell.swift
//  Places
//
//  Created by Ria Vora on 12/9/20.
//

import UIKit
import SnapKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    var padding = 5
    var review: Review!
    
    var user: UITextView!
    var reviewText: UITextView!
    
    var star1: UIImageView!
    var star2: UIImageView!
    var star3: UIImageView!
    var star4: UIImageView!
    var star5: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
       // self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        
        user = UITextView()
        user.textColor = .darkGray
        user.font = .systemFont(ofSize: 14)
        user.textAlignment = .left
        user.isEditable = false
        user.isScrollEnabled = false
        contentView.addSubview(user)
        
        reviewText = UITextView()
        reviewText.textColor = .lightGray
        reviewText.font = .systemFont(ofSize: 14)
        reviewText.textAlignment = .left
        reviewText.isEditable = false
        reviewText.isScrollEnabled = true
        contentView.addSubview(reviewText)
        
        star1 = UIImageView()
        star1.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        star1.contentMode = .scaleAspectFill
        star1.clipsToBounds = true
        contentView.addSubview(star1)

        star2 = UIImageView()
        star2.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        star2.contentMode = .scaleAspectFill
        star2.clipsToBounds = true
        contentView.addSubview(star2)
        
        star3 = UIImageView()
        star3.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        star3.contentMode = .scaleAspectFill
        star3.clipsToBounds = true
        contentView.addSubview(star3)
        
        star4 = UIImageView()
        star4.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        star4.contentMode = .scaleAspectFill
        star4.clipsToBounds = true
        contentView.addSubview(star4)
        
        star5 = UIImageView()
        star5.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        star5.contentMode = .scaleAspectFill
        star5.clipsToBounds = true
        contentView.addSubview(star5)
        
    }
    
    func setUpConstraints(){
        
        user.snp.makeConstraints{ make in
            //make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.top.equalToSuperview()
            make.height.equalTo(25)
            make.leading.equalToSuperview().offset(10)
            
        }
        
        reviewText.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
           // make.width.equalToSuperview().offset(10)
            make.top.equalTo(user.snp.bottom)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        star1.snp.makeConstraints{ make in
            //make.leading.equalTo(user.snp.trailing).offset(padding)
            make.height.equalTo(15)
            make.width.equalTo(15)
            make.top.equalToSuperview().offset(padding * 2)
            make.trailing.equalTo(star2.snp.leading).offset(-padding)
         }
        
        star2.snp.makeConstraints{ make in
            //make.leading.equalTo(star1.snp.trailing).offset(5)
            make.height.equalTo(15)
            make.width.equalTo(15)
            make.top.equalToSuperview().offset(padding * 2)
            make.trailing.equalTo(star3.snp.leading).offset(-padding)

         }
        
        star3.snp.makeConstraints{ make in
           // make.leading.equalTo(star2.snp.trailing).offset(5)
            make.height.equalTo(15)
            make.width.equalTo(15)
            make.top.equalToSuperview().offset(padding * 2)
            make.trailing.equalTo(star4.snp.leading).offset(-padding)
         }
        
        star4.snp.makeConstraints{ make in
           // make.leading.equalTo(star3.snp.trailing).offset(5)
            make.height.equalTo(15)
            make.width.equalTo(15)
            make.top.equalToSuperview().offset(padding * 2)
            make.trailing.equalTo(star5.snp.leading).offset(-padding)
         }
        
        star5.snp.makeConstraints{ make in
           // make.leading.equalTo(star4.snp.trailing).offset(5)
            make.height.equalTo(15)
            make.width.equalTo(15)
            make.top.equalToSuperview().offset(padding * 2)
            make.trailing.equalToSuperview().offset(-padding * 3)
         }
        
    }
    
    func configure(review: Review){
        self.review = review
        user.text = review.user
        reviewText.text = "\"\(review.review)\""
        
        if review.rating >= 1 {star1.tintColor = .systemYellow}
        else {star1.tintColor = .darkGray}
        if review.rating >= 2 {star2.tintColor = .systemYellow}
        else {star2.tintColor = .darkGray}
        if review.rating >= 3 {star3.tintColor = .systemYellow}
        else {star3.tintColor = .darkGray}
        if review.rating >= 4 {star4.tintColor = .systemYellow}
        else {star4.tintColor = .darkGray}
        if review.rating >= 5 {star5.tintColor = .systemYellow}
        else {star5.tintColor = .darkGray}
        
    }

    
}
