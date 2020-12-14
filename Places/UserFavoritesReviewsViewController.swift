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
    
    var reviewsCollectionView: UICollectionView!
    var userReviews: [Review] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        getUserReviews()
        setUpViews()
        setUpConstraints()
        
    }
    
    func setUpViews(){
        
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
    }
    
    func setUpConstraints() {
        reviewsCollectionView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview()
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

}

extension UserFavoritesReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userReviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = reviewsCollectionView.dequeueReusableCell(withReuseIdentifier: reviewReuseIdentifier, for: indexPath) as! ReviewCollectionViewCell
        cell.configure(review: userReviews[indexPath.row])
        return cell
    }
}


extension UserFavoritesReviewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.width / 4.0
        let width = collectionView.frame.width - (collectionPadding * 3.0)
        return CGSize(width: width, height: height)
        
    }
}

