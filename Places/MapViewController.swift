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
        
        places = [place1, place2, place3, place4, place5, place6]
        filters = [filter1, filter2, filter3, filter4, filter5, filter6]
        for place in places {
            originalData.append(place.copy() as! Place)
        }
        
        filteredPlaces = dataToFilter(places: places)
        
        setUpViews()
        setUpConstraints()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
       // map.delegate = self
        locationmanager = CLLocationManager()
        checkServices()
        
//        let annotation = MKPointAnnotation()
//        annotation.title = "test"
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 42.44497980660144, longitude: -76.48413325746588)
//        map.addAnnotation(annotation)
        
        for place in places {
            let annotation = MKPointAnnotation()
            annotation.title = String(place.locationDescription)
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude!, longitude: place.longitude!)
            let rightButton = UIButton(type: .detailDisclosure)
            map.addAnnotation(annotation)
        }
        
        
        
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
            let filtered = dataToShow()
           // filteredPlaces = dataToFilter(places: places)
            
            for annotation in map.annotations{
                map.removeAnnotation(annotation)
            }
            
            for place in filtered {
                let annotation = MKPointAnnotation()
                annotation.title = String(place.locationDescription)
                annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude!, longitude: place.longitude!)
                map.addAnnotation(annotation)
            }
            
            filterCollectionView.reloadData()
           // placeCollectionView.reloadData()
        }
    }
    
    override func dataToShow() -> [Place] {
        var dataToShowPlaces: [Place] = []
        for filter in filters{
            if filter.isSelected == true {
                for place in places {
                    if(place.category == filter.name){
                        dataToShowPlaces.append(place)
                    }
                }
            }
        }
        if dataToShowPlaces.count == 0 {
            print("hiii")
            return places
        }
        return dataToShowPlaces
    }
    
    override func dataToFilter(places: [Place]) -> [(Place,String)] {
        var filteredPlacesText: [(place: Place, string: String)] = []
        for place in places {
            filteredPlacesText.append((place: place, string: place.category))
            filteredPlacesText.append((place: place, string: place.locationDescription))
        }
        return filteredPlacesText
    }
    
    override func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            print("this is my data")
            places = dataToShow()
            print(places)
            
            for annotation in map.annotations{
                map.removeAnnotation(annotation)
            }
            
            for place in places {
                let annotation = MKPointAnnotation()
                annotation.title = String(place.locationDescription)
                annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude!, longitude: place.longitude!)
                map.addAnnotation(annotation)
            }
            return
        }
        filteredPlaces = dataToFilter(places: places)
        var placesfiltered:[Place] = []
        for (place, result) in filteredPlaces {
            if result.lowercased().contains(searchText.lowercased()) {
                placesfiltered.append(place)
            }
        }
        
        for annotation in map.annotations{
            map.removeAnnotation(annotation)
        }
        
        for place in placesfiltered {
            let annotation = MKPointAnnotation()
            annotation.title = String(place.locationDescription)
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude!, longitude: place.longitude!)
            map.addAnnotation(annotation)
        }
        
        
        
      //  places = placesfiltered
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
        if (locationmanager.location?.coordinate) != nil{
            let location2 = CLLocationCoordinate2D(latitude: 42.44497980660144, longitude: -76.48413325746588)
            let region = MKCoordinateRegion(center: location2, latitudinalMeters: 500, longitudinalMeters: 500)
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

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
//        annotationView.backgroundColor = UIColor.purple
//        if let de = mapView.dequeueReusableAnnotationView(withIdentifier: "pin"){
//            de.tintColor = .blue
//            return de
//        }
//        return nil
        
        let identifier = "placepin"
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView=UIButton(type: .detailDisclosure)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

}
