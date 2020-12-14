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
class MapViewController: UIViewController {
    
    let filterCellReuse = "filterCellReuseIdentifier"
    let padding: CGFloat = 10
    
    var filterCollectionView: UICollectionView!
    var search: UISearchBar!
    
    var places: [Place] = []
    var filteredData: [Place] = []
    var filteredPlaces: [(Place,String)] = []
    
    var map: MKMapView!
    var locationmanager: CLLocationManager!


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        getPlaces()
        
        filters = [filter1, filter2, filter3, filter4]
        filteredData = places
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
        map.delegate = self
        locationmanager = CLLocationManager()
       // checkServices()
        
        let location2 = CLLocationCoordinate2D(latitude: 42.44497980660144, longitude: -76.48413325746588)
        let region = MKCoordinateRegion(center: location2, latitudinalMeters: 500, longitudinalMeters: 500)
        map.setRegion(region, animated: false)
        
        
        for place in places {
            print("initializing")
            let annotation = MKPointAnnotation()
            annotation.title = String(place.types)
            annotation.subtitle = String(place.id)
            print(place.id)
            print(annotation.subtitle!)
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lon)
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
    
    func getPlaces() {
        NetworkManager.getPlaces{place in
            self.places = place
            self.filteredData = place
            DispatchQueue.main.async {
                for place in self.places {
                    let annotation = MKPointAnnotation()
                    annotation.title = String(place.types)
                    annotation.coordinate = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lon)
                    annotation.subtitle = String(place.id)
                    print(place.id)
                    print(annotation.subtitle!)
                    self.map.addAnnotation(annotation)
                }
                print("map view")
            }
        }
    }
    
    func dataToShow() -> [Place] {
        var dataToShowPlaces: [Place] = []
        for filter in filters{
            if filter.isSelected == true {
                if filter.name == "View All"{
                    return places
                }
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
        print("place got selected!")
        let annotationView = view.annotation as! MKPointAnnotation
        let placeID = Int ((annotationView.subtitle!))
        print(placeID!)
        let placeViewController = PlaceDetailViewController(place: filteredData[placeID!])
        navigationController?.pushViewController(placeViewController, animated: true)
    }
    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
////        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
////        annotationView.backgroundColor = UIColor.purple
////        if let de = mapView.dequeueReusableAnnotationView(withIdentifier: "pin"){
////            de.tintColor = .blue
////            return de
////        }
////        return nil
//
////        let identifier = "placepin"
////        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: identifier)
////        if annotationView == nil {
////            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
////            annotationView?.canShowCallout = true
////            annotationView?.rightCalloutAccessoryView=UIButton(type: .detailDisclosure)
////            //annotationView?.backgroundColor = UIColor.purple
////        } else {
////            annotationView?.annotation = annotation
////        }
////
////        return annotationView
//    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
       // let place = view.annotation as! Place
        
       // let placeVC = PlaceDetailViewController(place: place)
       // navigationController?.pushViewController(placeVC, animated: true)
        
    }

}

extension MapViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: filterCellReuse, for: indexPath) as! FilterCollectionViewCell
        cell.configure(filter: filters[indexPath.row])
        return cell
    }
}

extension MapViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.height - padding
        let width = (filters[indexPath.row].name + "     ").size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)]).width
        return CGSize(width: width, height: size)
    }
}


extension MapViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = filters[indexPath.row]
        filter.isSelected.toggle()
        filteredData = dataToShow()
        
        for annotation in map.annotations{
            map.removeAnnotation(annotation)
        }
        
        for place in filteredData {
            let annotation = MKPointAnnotation()
            annotation.title = String(place.types)
            annotation.subtitle = String(place.id)
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lon)
            map.addAnnotation(annotation)
        }
        filterCollectionView.reloadData()
    }
}


// Set Up Search Bar: https://www.youtube.com/watch?v=wVeX68Iu43E
extension MapViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            places = dataToShow()
            for annotation in map.annotations{
                map.removeAnnotation(annotation)
            }
            
            for place in places {
                let annotation = MKPointAnnotation()
                annotation.title = String(place.types)
                annotation.subtitle = String(place.id)
                annotation.coordinate = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lon)
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
             annotation.title = String(place.types)
             annotation.subtitle = String(place.id)
             annotation.coordinate = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lon)
             map.addAnnotation(annotation)
         }
    }
}
