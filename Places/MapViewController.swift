//
//  MapViewController.swift
//  Places
//
//  Created by Ria Vora on 12/5/20.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

// Helpful video for map things: https://www.youtube.com/watch?v=WPpaAy73nJc

class MapViewController: SearchFilterDelegateController {
    
    var map: MKMapView!
    var locationmanager: CLLocationManager!


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
        
        map = MKMapView()
        locationmanager = CLLocationManager()
        checkServices()
        
        
        view.addSubview(map)
    
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
        
       map.snp.makeConstraints{make in
            make.top.equalTo(filterCollectionView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
       }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterCollectionView {
            let filter = filters[indexPath.row]
            filter.isSelected.toggle()
            places = dataToShow()
            filteredPlaces = dataToFilter(places: places)
            
            filterCollectionView.reloadData()
           // placeCollectionView.reloadData()
        }
    }
    
    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
        //placeCollectionView.reloadData()
        
    }
    
    func checkServices(){
        if CLLocationManager.locationServicesEnabled(){
            locationmanager.delegate = self
            locationmanager.desiredAccuracy = .greatestFiniteMagnitude
            checkAuthorization()
        }
        else {
            // TODO: Set up an alert
        }
    }
    
    
    func findCenter(){
        if let location = locationmanager.location?.coordinate{
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            map.setRegion(region, animated: false)
        }
    }
    
    func checkAuthorization(){
        switch locationmanager.authorizationStatus {
        case .authorizedWhenInUse:
            map.showsUserLocation = true
            findCenter()
        case .denied:
                break
        case .notDetermined:
                locationmanager.requestWhenInUseAuthorization()
        case .restricted:
                break
        case .authorizedAlways:
                break
        default:
            break
        }
    
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // ill be here
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
}





