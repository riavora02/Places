//
//  FavoritesViewController.swift
//  Places
//
//  Created by Ria Vora on 12/5/20.
//

import UIKit

class FavoritesViewController: SearchFilterDelegateController{
    
    var favorites: [Place]! = []

    override func viewDidLoad() {
        super.viewDidLoad()

        for place in places {
            if place.isFavorite == true {
                favorites.append(place)
            }
        }
        places = favorites
        view.backgroundColor = .white
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews(){

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        layout.scrollDirection = .vertical


        placeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        placeCollectionView.backgroundColor = .white
        placeCollectionView.dataSource = self
        placeCollectionView.delegate = self
        placeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        placeCollectionView.register(PlaceCollectionViewCell.self, forCellWithReuseIdentifier: placeCellReuse)
        view.addSubview(placeCollectionView)

        let filterlayout = UICollectionViewFlowLayout()
        filterlayout.minimumInteritemSpacing = padding
        filterlayout.minimumLineSpacing = padding
        filterlayout.scrollDirection = .horizontal

        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterlayout)
        filterCollectionView.backgroundColor = .white
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        filterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        filterCollectionView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterCellReuse)
        view.addSubview(filterCollectionView)

        search = UISearchBar()
        search.delegate = self
        search.searchBarStyle = .minimal
        search.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(search)

    }

    func setUpConstraints(){
        
        search.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(50)
        }
        
        filterCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(search.snp.bottom)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(40)
        }
        
        placeCollectionView.snp.makeConstraints{ make in
            make.top.equalTo(filterCollectionView.snp.bottom).offset(padding)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-padding)
        }
       

    }
}


