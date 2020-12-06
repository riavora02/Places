//
//  ViewController.swift
//  Places
//
//  Created by Ria Vora on 12/5/20.
//

import UIKit

class ViewController: SearchFilterDelegateController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
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

        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            search.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            search.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            search.heightAnchor.constraint(equalToConstant: 50)
        ])

        NSLayoutConstraint.activate([
            filterCollectionView.topAnchor.constraint(equalTo: search.bottomAnchor, constant: padding),
            filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            filterCollectionView.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            placeCollectionView.topAnchor.constraint(equalTo: filterCollectionView.bottomAnchor, constant: padding),
            placeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            placeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            placeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])

    }
}


