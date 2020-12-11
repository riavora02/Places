//
//  AddReviewViewController.swift
//  Places
//
//  Created by Ria Vora on 12/10/20.
//

import UIKit

class AddReviewViewController: UIViewController {

    var smallRect: UIView!
    
    var padding = 5
    var review: Review!
    
    var user: UITextView!
    var reviewText: UITextView!
    var saveButton: UIButton! 
    
    var star1: UIButton!
    var star2: UIImageView!
    var star3: UIImageView!
    var star4: UIImageView!
    var star5: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews(){
        
//        self.contentView.layer.cornerRadius = 5.0
//        self.contentView.layer.masksToBounds = true
//
//        self.layer.shadowColor = UIColor.black.cgColor
//       // self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//        self.layer.shadowOffset = .zero
//        self.layer.shadowRadius = 2.0
//        self.layer.shadowOpacity = 0.3
//        self.layer.masksToBounds = false
        
        smallRect = UIView()
        smallRect.backgroundColor = .white
        smallRect.layer.cornerRadius = 15
        view.addSubview(smallRect)
        
        user = UITextView()
        user.textColor = .darkGray
        user.text = "Jacob Steve"
        user.font = .systemFont(ofSize: 18)
        user.textAlignment = .left
        user.isEditable = false
        user.isScrollEnabled = false
        smallRect.addSubview(user)
        
        reviewText = UITextView()
        reviewText.backgroundColor = UIColor(red: 0.91, green: 0.96, blue: 0.97, alpha: 1.00)
        reviewText.textColor = .lightGray
        reviewText.font = .systemFont(ofSize: 16)
        reviewText.textAlignment = .left
        reviewText.layer.cornerRadius = 10
        reviewText.text = "Add your review here: "
        reviewText.isScrollEnabled = true
        smallRect.addSubview(reviewText)
        
        star1 = UIButton()
        star1.setImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate).withTintColor(UIColor.red), for: .normal)
        star1.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        star1.contentMode = .scaleAspectFill
        star1.clipsToBounds = true
        smallRect.addSubview(star1)

        star2 = UIImageView()
        star2.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        star2.contentMode = .scaleAspectFill
        star2.clipsToBounds = true
        smallRect.addSubview(star2)
        
        star3 = UIImageView()
        star3.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        star3.contentMode = .scaleAspectFill
        star3.clipsToBounds = true
        smallRect.addSubview(star3)
        
        star4 = UIImageView()
        star4.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        star4.contentMode = .scaleAspectFill
        star4.clipsToBounds = true
        smallRect.addSubview(star4)
        
        star5 = UIImageView()
        star5.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        star5.contentMode = .scaleAspectFill
        star5.clipsToBounds = true
        smallRect.addSubview(star5)
        
        saveButton = UIButton()
        saveButton.backgroundColor = UIColor(red: 0.16, green: 0.71, blue: 0.96, alpha: 0.5)
        saveButton.setTitleColor(UIColor(red: 0.91, green: 0.96, blue: 0.97, alpha: 1.00), for: .normal)
        saveButton.layer.cornerRadius = 5
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(dismissReviewPopUp), for: .touchUpInside)
        smallRect.addSubview(saveButton)
        
    }
    
    func setUpConstraints(){
        
        smallRect.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(4.5)
            make.width.equalToSuperview().dividedBy(1.2)
            
        }
        user.snp.makeConstraints{ make in
            //make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.1)
            make.top.equalToSuperview()
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(10)
            
        }
        
        saveButton.snp.makeConstraints{ make in
            //make.centerX.equalToSuperview()
            make.width.equalTo(65)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(25)
            make.trailing.equalToSuperview().offset(-15)
            
        }
        
        
        star1.snp.makeConstraints{ make in
            //make.leading.equalTo(user.snp.trailing).offset(padding)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(user.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(padding * 3)
         }
        
        star2.snp.makeConstraints{ make in
            //make.leading.equalTo(star1.snp.trailing).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(user.snp.bottom).offset(5)
            make.leading.equalTo(star1.snp.trailing).offset(padding)

         }
        
        star3.snp.makeConstraints{ make in
           // make.leading.equalTo(star2.snp.trailing).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(user.snp.bottom).offset(5)
            make.leading.equalTo(star2.snp.trailing).offset(padding)
         }
        
        star4.snp.makeConstraints{ make in
           // make.leading.equalTo(star3.snp.trailing).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(user.snp.bottom).offset(5)
            make.leading.equalTo(star3.snp.trailing).offset(padding)
         }
        
        star5.snp.makeConstraints{ make in
           // make.leading.equalTo(star4.snp.trailing).offset(5)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.top.equalTo(user.snp.bottom).offset(5)
            make.leading.equalTo(star4.snp.trailing).offset(padding)
         }
        
        reviewText.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
           // make.width.equalToSuperview().offset(10)
            make.top.equalTo(star1.snp.bottom).offset(padding)
            make.height.equalToSuperview().dividedBy(1.75)
            make.width.equalToSuperview().dividedBy(1.1)
        }
        
    }
    
    @objc func dismissReviewPopUp(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func toggle(){

    }

}
