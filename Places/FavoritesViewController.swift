//
//  FavoritesViewController.swift
//  Places
//
//  Created by Ria Vora on 12/5/20.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    let placeCellReuse = "placeCellReuseIdentifier"
    let filterCellReuse = "filterCellReuseIdentifier"
    let padding: CGFloat = 10
    
    var placeCollectionView: UICollectionView!
    var filterCollectionView: UICollectionView!
    var search: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        for place in places {
            if place.isFavorite == true {
                print("getting added as favorite")
            }
        }
        
        view.backgroundColor = .white
        setUpViews()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("im about to appear")
        for place in places {
            print(place.locationDescription)
            if place.isFavorite == true && favorites.contains(where: {obj in obj.tag == place.tag}) == false{
                favorites.append(place.copy() as! Place)
                print("I got marked as fav")
            }
            if place.isFavorite == false && favorites.contains(where: {obj in obj.tag == place.tag}) == true {
                if let index = favorites.firstIndex(of: place){
                    favorites.remove(at: index)
                }
                print("Im removed")
                //favorites.remove(at: index)
                print("I got taken out marked as fav")
            }
        }
        //places = favorites
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
    
    func dataToShow() -> [Place] {
        favorites = []
        for filter in filters{
            if filter.isSelected == true {
                for place in originalData {
                    if(place.category == filter.name){
                        favorites.append(place)
                    }
                }
            }
        }
        if favorites.count == 0 {
            favorites = originalData
        }
        return favorites
    }
    
    func dataToFilter(places: [Place]) -> [(Place,String)] {
        var filteredPlacesText: [(place: Place, string: String)] = []
        for place in places {
            filteredPlacesText.append((place: place, string: place.category))
            filteredPlacesText.append((place: place, string: place.locationDescription))
        }
        return filteredPlacesText
    }
}



extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCollectionView{
            return filters.count
        }
        else {
            return favorites.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterCollectionView{
            let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuse, for: indexPath) as! FilterCollectionViewCell
            cell.configure(filter: filters[indexPath.row])
            return cell
        }
        else {
            let cell = placeCollectionView.dequeueReusableCell(withReuseIdentifier: placeCellReuse, for: indexPath) as! PlaceCollectionViewCell
            cell.configure(place: favorites[indexPath.row])
            return cell
        }
    }
    
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterCollectionView {
            let size = collectionView.frame.height - padding
            let width = (filters[indexPath.row].name + "     ").size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width
            return CGSize(width: width, height: size)
        }
        else {
            let size = (collectionView.frame.width - padding) / 2.0
            return CGSize(width: size, height: size)
        }
    }
}


extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            let filter = filters[indexPath.row]
            filter.isSelected.toggle()
            favorites = dataToShow()
            filteredPlaces = dataToFilter(places: places)
            
            filterCollectionView.reloadData()
            placeCollectionView.reloadData()
        }

        if collectionView == placeCollectionView  {
//            let place = places[indexPath.row]
//            let placeVC = PlaceViewController(place: place)
//            navigationController?.pushViewController(restaurantVC, animated: true)
            print("tapped!")
        }
    }
}


// Set Up Search Bar: https://www.youtube.com/watch?v=wVeX68Iu43E
extension FavoritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            favorites = dataToShow()
            placeCollectionView.reloadData()
            return
        }
        var placesfiltered:[Place] = []
        for (place, result) in filteredPlaces {
            if result.lowercased().contains(searchText.lowercased()) {
                placesfiltered.append(place)
            }
        }
        
        favorites = placesfiltered
        placeCollectionView.reloadData()
        
    }
}



