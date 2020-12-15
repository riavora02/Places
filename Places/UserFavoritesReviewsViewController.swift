//
//  UserFavoritesReviewsViewController.swift
//  Places
//
//  Created by Ria Vora on 12/13/20.
//

import UIKit
import SnapKit

class UserFavoritesReviewsViewController: UIViewController {
    
    var collectionPadding: CGFloat = 10
    var padding: CGFloat = 20 
    var reviewReuseIdentifier = "rev"
    var placeCellReuse = "placeCellReuse"

    
    var reviewsCollectionView: UICollectionView!
    var placeCollectionView: UICollectionView!
    var favoritesLabel: UILabel!
    var reviewsLabel: UILabel!
    var logOutButton: UIButton!
    
    var userReviews: [Review] = []
    var userFavorites: [favoritePlace] = []
    var userFavoritesConverted: [Place] = []
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        super.viewDidLoad()
        
        setUpViews()
        setUpConstraints()
        getUserReviews()
        getUserFavorites()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUserReviews()
        getUserFavorites()
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews(){
        
        favoritesLabel = UILabel()
        favoritesLabel.text = "Favorite Places"
        favoritesLabel.backgroundColor = lightBlue
        favoritesLabel.textColor = darkBlue
        favoritesLabel.layer.masksToBounds = true
        favoritesLabel.layer.cornerRadius = 10
        favoritesLabel.textAlignment = .center
        view.addSubview(favoritesLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = collectionPadding
        layout.minimumLineSpacing = collectionPadding
        layout.scrollDirection = .horizontal

        placeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        placeCollectionView.backgroundColor = .white
        placeCollectionView.dataSource = self
        placeCollectionView.delegate = self
        placeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        placeCollectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: placeCellReuse)
        view.addSubview(placeCollectionView)
        
        reviewsLabel = UILabel()
        reviewsLabel.text = "Your Reviews"
        reviewsLabel.backgroundColor = lightBlue
        reviewsLabel.textColor = darkBlue
        reviewsLabel.layer.masksToBounds = true
        reviewsLabel.layer.cornerRadius = 10
        reviewsLabel.textAlignment = .center
        view.addSubview(reviewsLabel)
        
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
        
        logOutButton = UIButton()
        logOutButton.setTitle("Sign Out", for: .normal)
        logOutButton.backgroundColor = UIColor(red: 255/255.0, green: 192/255.0, blue: 203/255.0, alpha: 1.0)
        logOutButton.setTitleColor(.white, for: .normal)
        logOutButton.layer.masksToBounds = true
        logOutButton.layer.cornerRadius = 10
        logOutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.addSubview(logOutButton)
    
    }
    
    func setUpConstraints() {
        
        favoritesLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.height.equalTo(30)
            make.width.equalToSuperview().dividedBy(1.2)
        }
        
        placeCollectionView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(favoritesLabel.snp.bottom).offset(20)
            make.height.equalToSuperview().dividedBy(4.5)
            make.width.equalToSuperview().dividedBy(1.05)
        }
        
        reviewsLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(placeCollectionView.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalToSuperview().dividedBy(1.2)
        }
        
        reviewsCollectionView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(reviewsLabel.snp.bottom).offset(20)
            make.height.equalToSuperview().dividedBy(2.4)
            make.width.equalToSuperview()
        }
        
        logOutButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(reviewsCollectionView.snp.bottom).offset(20)
            make.height.equalTo(25)
            make.width.equalToSuperview().dividedBy(1.2)
        }
    }
    
    func getUserReviews(){
        NetworkManager.getUserReviews{ reviews in
            print("got to the users")
            self.userReviews = reviews
            print(reviews)
            self.reviewsCollectionView.reloadData()
        }
    }
    
    func getUserFavorites(){
        NetworkManager.getUserFavorites{ favorites in
            self.userFavorites = favorites
            self.convert()
            self.placeCollectionView.reloadData()
        }
    }
    
    func convert(){
        userFavoritesConverted = []
        var count = 0
        for originalPlace in userFavorites {
            let tempPlace = Place(id: count, name: originalPlace.name, types: originalPlace.types, lat: originalPlace.latitude, lon: originalPlace.longitude, image_url: originalPlace.img_url)
            userFavoritesConverted.append(tempPlace)
            count += 1
        }
    }
    
    @objc func logout(){
        let signUpVC = UserViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }

}

extension UserFavoritesReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == placeCollectionView{
            return userFavoritesConverted.count
        }
        else {
            return userReviews.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == reviewsCollectionView{
            let cell = reviewsCollectionView.dequeueReusableCell(withReuseIdentifier: reviewReuseIdentifier, for: indexPath) as! ReviewCollectionViewCell
            cell.configure(review: userReviews[indexPath.row])
            return cell
        } else {
            let cell = placeCollectionView.dequeueReusableCell(withReuseIdentifier: placeCellReuse, for: indexPath) as! PlaceCollectionViewCell
            cell.configure(place: userFavoritesConverted[indexPath.row], markedFavorite: true)
            return cell
        }
        
    }
}


extension UserFavoritesReviewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == reviewsCollectionView  {
            let height = collectionView.frame.width / 3.8
            let width = collectionView.frame.width - (collectionPadding * 3.0)
            return CGSize(width: width, height: height)
        } else {
            let height = collectionView.frame.height - 5
            return CGSize(width: height, height: height)
        }
        
    }
}

