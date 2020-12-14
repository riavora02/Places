//
//  PlaceDetailViewController.swift
//  Places
//
//  Created by Ria Vora on 12/8/20.
//

import UIKit
import SnapKit
import Kingfisher

class PlaceDetailViewController: UIViewController {
    
    var padding = 20
    var collectionPadding: CGFloat = 10
    var currentPlace: Place!
    var rating: Int = 0
   // var currentReviews: [Review]!
    
    var image: UIImageView!
    var star1: UIImageView!
    var star2: UIImageView!
    var star3: UIImageView!
    var star4: UIImageView!
    var star5: UIImageView!
    var star6: UIImageView!
    
    var categoryName: UITextView!
    var locationDescription: UITextView!
    var reviewsCollectionView: UICollectionView!
    var reviewsTitle: UITextView!
    
    var addReviewButton: UIButton! 
    
    var reviewReuseIdentifier = "rev"
    

    init(place: Place){
        super.init(nibName: nil, bundle: nil)
        currentPlace = place
      //  currentReviews = place.reviews
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
        
        getRating()
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
        let photoURL = URL(string: currentPlace.image_url)
        image.kf.setImage(with: photoURL)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        view.addSubview(image)
        
        categoryName = UITextView()
        categoryName.text = currentPlace.types
        categoryName.font = .systemFont(ofSize: 30)
        categoryName.textColor = .darkGray
        categoryName.textAlignment = .left
        categoryName.isEditable = false
        view.addSubview(categoryName)
        
        locationDescription = UITextView()
        locationDescription.text = "Location: " + currentPlace.name
        locationDescription.font = .systemFont(ofSize: 18 )
        locationDescription.textColor = .lightGray
        locationDescription.textAlignment = .left
        locationDescription.isEditable = false
        view.addSubview(locationDescription)
        
        star1 = UIImageView()
        star1.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        if rating >= 1 {star1.tintColor = .systemYellow}
        else {star1.tintColor = .darkGray}
        star1.contentMode = .scaleAspectFill
        star1.clipsToBounds = true
        view.addSubview(star1)

        star2 = UIImageView()
        star2.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        if rating >= 2 {star2.tintColor = .systemYellow}
        else {star2.tintColor = .darkGray}
        star2.contentMode = .scaleAspectFill
        star2.clipsToBounds = true
        view.addSubview(star2)
        
        star3 = UIImageView()
        star3.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        if rating >= 3 {star3.tintColor = .systemYellow}
        else {star3.tintColor = .darkGray}
        star3.contentMode = .scaleAspectFill
        star3.clipsToBounds = true
        view.addSubview(star3)
        
        star4 = UIImageView()
        star4.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        if rating >= 4 {star4.tintColor = .systemYellow}
        else {star4.tintColor = .darkGray}
        star4.contentMode = .scaleAspectFill
        star4.clipsToBounds = true
        view.addSubview(star4)
        
        star5 = UIImageView()
        star5.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        if rating >= 5 {star5.tintColor = .systemYellow}
        else {star5.tintColor = .darkGray}
        star5.contentMode = .scaleAspectFill
        star5.clipsToBounds = true
        view.addSubview(star5)
        
        reviewsTitle = UITextView()
        reviewsTitle.text = "Reviews:"
        reviewsTitle.font = .systemFont(ofSize: 18)
        reviewsTitle.textColor = .lightGray
        reviewsTitle.textAlignment = .left
        reviewsTitle.isEditable = false
        view.addSubview(reviewsTitle)
        
        let reviewLayout = UICollectionViewFlowLayout()
        reviewLayout.minimumLineSpacing = collectionPadding
        reviewLayout.minimumInteritemSpacing = collectionPadding
        reviewLayout.scrollDirection = .vertical
        
        reviewsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: reviewLayout)
        reviewsCollectionView.backgroundColor = .white
        reviewsCollectionView.dataSource = self
        reviewsCollectionView.delegate = self
        reviewsCollectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: reviewReuseIdentifier)
        view.addSubview(reviewsCollectionView)
        
        addReviewButton = UIButton()
        addReviewButton.backgroundColor = darkBlue
        addReviewButton.setTitleColor(lightBlue, for: .normal)
        addReviewButton.layer.cornerRadius = 10
        addReviewButton.setTitle("Add Review", for: .normal)
        addReviewButton.addTarget(self, action: #selector(addReviewPopUp), for: .touchUpInside)
        view.addSubview(addReviewButton)
    
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
        
        addReviewButton.snp.makeConstraints{ make in
            make.height.equalTo(25)
            make.width.equalTo(110)
            make.top.equalTo(image.snp.bottom).offset(25)
            make.trailing.equalToSuperview().offset(-15)
         }
        
        locationDescription.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(30)
            make.top.equalTo(categoryName.snp.bottom).offset(padding + 10)
        }
        
        
//        reviewsTitle.snp.makeConstraints{ make in
//            make.leading.equalToSuperview().offset(padding)
//            make.trailing.equalToSuperview().offset(-padding)
//            make.height.equalTo(35)
//            make.top.equalTo(notes.snp.bottom)
//        }
        
        reviewsCollectionView.snp.makeConstraints{ make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(locationDescription.snp.bottom).offset(padding/2)
            make.bottom.equalToSuperview()
         }
        

    }
    
    func getRating() {
        NetworkManager.getRating(id: currentPlace.id){rating in
            self.rating = rating
            
            self.star1.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            if rating >= 5 {self.star1.tintColor = .systemYellow}
            self.star2.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            if rating >= 5 {self.star2.tintColor = .systemYellow}
            self.star3.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            if rating >= 5 {self.star3.tintColor = .systemYellow}
            self.star4.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            if rating >= 5 {self.star4.tintColor = .systemYellow}
            self.star5.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
            if rating >= 5 {self.star5.tintColor = .systemYellow}
        }
    }
    

    @objc func addReviewPopUp(){
        let addReviewViewController = AddReviewViewController()
        //self.navigationController?.pushViewController(addReviewViewController, animated: true)
        present(addReviewViewController, animated: true, completion: nil)
    }
}

extension PlaceDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // return currentReviews.count
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewsCollectionView.dequeueReusableCell(withReuseIdentifier: reviewReuseIdentifier, for: indexPath) as! ReviewCollectionViewCell
        cell.configure(review: reviews[indexPath.row])
        return cell
    }
}


extension PlaceDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.width / 4.0
        let width = collectionView.frame.width - (collectionPadding * 3.0)
        return CGSize(width: width, height: height)
        
    }
}



