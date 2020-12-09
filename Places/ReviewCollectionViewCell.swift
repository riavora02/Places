//
//  ReviewCollectionViewCell.swift
//  Places
//
//  Created by Ria Vora on 12/9/20.
//

import UIKit
import SnapKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    var review: Review!
    
    var user: UITextView!
    var reviewText: UITextView!
    
    
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
        
    }
    
    func setUpConstraints(){
        
        user.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(10)
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
    }
    
    func configure(review: Review){
        self.review = review
        user.text = review.user
        reviewText.text = "\"\(review.review)\""
    }

    
}
