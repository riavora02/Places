//
//  AddReviewViewController.swift
//  Places
//
//  Created by Ria Vora on 12/10/20.
//

import UIKit

protocol saveReviewDelegate: class {
    func saveReview()
}

class AddReviewViewController: UIViewController {

    weak var delegate: saveReviewDelegate?
    var smallRect: UIView!
    
    var padding = 5
    var review: Review!
    
    var user: UITextView!
    var reviewText: UITextView!
    var saveButton: UIButton!
    var currentPlace: Place! 
    
    var star1: UIImageView!
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
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(toggle1(gesture:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(toggle2(gesture:)))
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(toggle3(gesture:)))
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(toggle4(gesture:)))
        let tapGestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(toggle5(gesture:)))
        
        smallRect = UIView()
        smallRect.backgroundColor = .white
        smallRect.layer.cornerRadius = 15
        view.addSubview(smallRect)
        
        user = UITextView()
        user.textColor = .darkGray
        user.text = User.current?.username
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
        reviewText.isScrollEnabled = true
        smallRect.addSubview(reviewText)
        
        star1 = UIImageView()
        star1.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate).withTintColor(.lightGray)
        star1.tintColor = UIColor.lightGray
        star1.contentMode = .scaleAspectFill
        star1.clipsToBounds = true
        star1.isUserInteractionEnabled = true
        star1.addGestureRecognizer(tapGestureRecognizer1)
        smallRect.addSubview(star1)

        star2 = UIImageView()
        star2.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate).withTintColor(.lightGray)
        star2.tintColor = UIColor.lightGray
        star2.contentMode = .scaleAspectFill
        star2.clipsToBounds = true
        star2.isUserInteractionEnabled = true
        star2.addGestureRecognizer(tapGestureRecognizer2)
        smallRect.addSubview(star2)
        
        star3 = UIImageView()
        star3.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate).withTintColor(.lightGray)
        star3.tintColor = UIColor.lightGray
        star3.contentMode = .scaleAspectFill
        star3.clipsToBounds = true
        star3.isUserInteractionEnabled = true
        star3.addGestureRecognizer(tapGestureRecognizer3)
        smallRect.addSubview(star3)
//
        star4 = UIImageView()
        star4.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate).withTintColor(.lightGray)
        star4.tintColor = UIColor.lightGray
        star4.contentMode = .scaleAspectFill
        star4.clipsToBounds = true
        star4.isUserInteractionEnabled = true
        star4.addGestureRecognizer(tapGestureRecognizer4)
        smallRect.addSubview(star4)
        
        star5 = UIImageView()
        star5.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate).withTintColor(.lightGray)
        star5.tintColor = UIColor.lightGray
        star5.contentMode = .scaleAspectFill
        star5.clipsToBounds = true
        star5.isUserInteractionEnabled = true
        star5.addGestureRecognizer(tapGestureRecognizer5)
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
        var tempRating = 0
        
        if(star1.tintColor == .systemYellow) {tempRating += 1}
        if(star2.tintColor == .systemYellow) {tempRating += 1}
        if(star3.tintColor == .systemYellow) {tempRating += 1}
        if(star4.tintColor == .systemYellow) {tempRating += 1}
        if(star5.tintColor == .systemYellow) {tempRating += 1}
        
        NetworkManager.addReview(userID: User.current!.user_id, placeID: currentPlace.id, rating: tempRating, text: reviewText.text){
            [weak self]
            valid in print("hi")
            self?.delegate?.saveReview()
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func toggle1(gesture: UITapGestureRecognizer){
        if star1.tintColor == .lightGray{
            star1.tintColor = .systemYellow
        }
        else {
            star1.tintColor = .lightGray
        }
    }
    
    @objc func toggle2(gesture: UITapGestureRecognizer){
        if star2.tintColor == .lightGray{
            star2.tintColor = .systemYellow
        }
        else {
            star2.tintColor = .lightGray
        }
    }
    
    @objc func toggle3(gesture: UITapGestureRecognizer){
        if star3.tintColor == .lightGray{
            star3.tintColor = .systemYellow
        }
        else {
            star3.tintColor = .lightGray
        }
    }
    
    @objc func toggle4(gesture: UITapGestureRecognizer){
        if star4.tintColor == .lightGray{
            star4.tintColor = .systemYellow
        }
        else {
            star4.tintColor = .lightGray
        }
    }
    
    @objc func toggle5(gesture: UITapGestureRecognizer){
        if star5.tintColor == .lightGray{
            star5.tintColor = .systemYellow
        }
        else {
            star5.tintColor = .lightGray
        }
    }

}
