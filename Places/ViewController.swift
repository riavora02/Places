//
//  ViewController.swift
//  Places
//
//  Created by Ria Vora on 12/5/20.
//

import UIKit

class ViewController: UIViewController {
    
    let placeCellReuse = "placeCellReuseIdentifier"
    let filterCellReuse = "filterCellReuseIdentifier"
    let padding: CGFloat = 10
    
    var placeCollectionView: UICollectionView!
    var filterCollectionView: UICollectionView!
    var search: UISearchBar!
    
    var places: [Place] = []
    var filteredData: [Place] = []
    var filteredPlaces: [(Place,String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setUpViews() 
        setUpConstraints()
        getPlaces()
        
        filters = [filter1, filter2, filter3, filter4]
        filteredData = places
        filteredPlaces = dataToFilter(places: places)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
    
    func getPlaces() {
        NetworkManager.getPlaces{place in
            self.places = place
            DispatchQueue.main.async {
                self.filteredData  = self.places
                self.placeCollectionView.reloadData()
            }
        }
    }
    
    func dataToShow() -> [Place] {
        var dataToShowPlaces: [Place] = []
        for filter in filters{
            if filter.isSelected == true {
                for place in places {
                    if(place.types == filter.name){
                        dataToShowPlaces.append(place)
                    }
                }
            }
        }
        if dataToShowPlaces.count == 0 {
            return places
        }
        return dataToShowPlaces
    }
    
    func dataToFilter(places: [Place]) -> [(Place,String)] {
        var filteredPlacesText: [(place: Place, string: String)] = []
        for place in places {
            filteredPlacesText.append((place: place, string: place.types))
            filteredPlacesText.append((place: place, string: place.name))
        }
        return filteredPlacesText
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterCollectionView{
            return filters.count
        }
        else {
            return filteredData.count
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
            let filteredData = dataToShow()
            cell.configure(place: filteredData[indexPath.row])
            return cell
        }
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
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


extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            let filter = filters[indexPath.row]
            filter.isSelected.toggle()
            filteredData = dataToShow()
            filterCollectionView.reloadData()
            placeCollectionView.reloadData()
        }

        if collectionView == placeCollectionView  {
            let place = filteredData[indexPath.row]
            let placeVC = PlaceDetailViewController(place: place)
            navigationController?.pushViewController(placeVC, animated: true)
        }
    }
}


// Set Up Search Bar: https://www.youtube.com/watch?v=wVeX68Iu43E
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            filteredData = dataToShow()
            placeCollectionView.reloadData()
            return
        }
        var placesfiltered:[Place] = []
        filteredPlaces = dataToFilter(places: filteredData)
        for (place, result) in filteredPlaces {
            if result.lowercased().contains(searchText.lowercased()) {
                placesfiltered.append(place)
            }
        }
        filteredData = placesfiltered
        placeCollectionView.reloadData()
        
    }
}


