//
//  SearchFilterDelegates.swift
//  Places
//
//  Created by Ria Vora on 12/6/20.
//

import UIKit

class SearchFilterDelegateController: UIViewController {

    let placeCellReuse = "placeCellReuseIdentifier"
    let filterCellReuse = "filterCellReuseIdentifier"
    let padding: CGFloat = 10
    
    var placeCollectionView: UICollectionView!
    var filterCollectionView: UICollectionView!
    var search: UISearchBar!


    var places: [Place] = []
    var originalData: [Place] = []
    var filters: [Filter] = []
    var filteredPlaces: [(place: Place, name: String)] = []
    
    // Data
    var place1 = Place(imageName: "vending1", rating: 5, category: "Vending Machine", locationDescription: "Rhodes Hall")
    var place2 = Place(imageName: "vending2", rating: 4, category: "Vending Machine", locationDescription: "Uris Hall")
    var place3 = Place(imageName: "bathroom1", rating: 5, category: "Bathroom", locationDescription: "Terrace")
    var place4 = Place(imageName: "bathroom2", rating: 5, category: "Bathroom", locationDescription: "Duffield Hall")
    var place5 = Place(imageName: "atm1", rating: 5, category: "ATM", locationDescription: "Collegetown")
    var filter1 = Filter(name: "Vending Machine", type: "item", isSelected: false)
    var filter2 = Filter(name: "ATM", type: "item", isSelected: false)
    var filter3 = Filter(name: "Bathroom", type: "item", isSelected: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = [place1, place2, place3, place4, place5]
        filters = [filter1, filter2, filter3]
        originalData = [place1, place2, place3, place4, place5]
        filteredPlaces = dataToFilter(places: places)
    }
    
    func dataToShow() -> [Place] { 
        places = []
        for filter in filters{
            if filter.isSelected == true {
                for place in originalData {
                    if(place.category == filter.name){
                        places.append(place)
                    }
                }
            }
        }
        if places.count == 0 {
            places = originalData
        }
        return places
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



extension SearchFilterDelegateController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCollectionView{
            return filters.count
        }
        else {
            return places.count
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
            cell.configure(place: places[indexPath.row])
            return cell
        }
    }
    
}

extension SearchFilterDelegateController: UICollectionViewDelegateFlowLayout{
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


extension SearchFilterDelegateController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            let filter = filters[indexPath.row]
            filter.isSelected.toggle()
            places = dataToShow()
            filteredPlaces = dataToFilter(places: places)
            
            filterCollectionView.reloadData()
            placeCollectionView.reloadData()
        }
//        TODO: Add in feature when person taps
//
//        if collectionView == placeCollectionView  {
//            let place = places[indexPath.row]
//            let placeVC = PlaceViewController(place: place)
//            navigationController?.pushViewController(restaurantVC, animated: true)
//        }
    }
}


// Set Up Search Bar: https://www.youtube.com/watch?v=wVeX68Iu43E
extension SearchFilterDelegateController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            places = dataToShow()
            placeCollectionView.reloadData()
            return
        }
        var placesfiltered:[Place] = []
        for (place, result) in filteredPlaces {
            if result.lowercased().contains(searchText.lowercased()) {
                placesfiltered.append(place)
            }
        }
        
        places = placesfiltered
        placeCollectionView.reloadData()
        
    }
}
