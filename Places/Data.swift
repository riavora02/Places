//
//  Data.swift
//  Places
//
//  Created by Ria Vora on 12/7/20.
//

import Foundation


// Data
var place1 = Place(imageName: "vending1", rating: 5, category: "Vending Machine", locationDescription: "Rhodes Hall", isFavorite: false, tag: 0, latitude: 42.44368745887105, longitude: -76.48138611513738)
var place2 = Place(imageName: "vending2", rating: 4, category: "Vending Machine", locationDescription: "Uris Hall", isFavorite: false, tag: 1, latitude: 42.44743666524334, longitude: -76.48221811513734)
var place3 = Place(imageName: "bathroom1", rating: 5, category: "Bathroom", locationDescription: "Terrace", isFavorite: false, tag: 2, latitude: 42.44637801911678, longitude: -76.48227801513728)
var place4 = Place(imageName: "bathroom2", rating: 5, category: "Bathroom", locationDescription: "Duffield Hall", isFavorite: false, tag: 3, latitude: 42.44489302399624, longitude: -76.48266435931619)
var place5 = Place(imageName: "atm1", rating: 5, category: "ATM", locationDescription: "Klarman Hall", isFavorite: false, tag: 4, latitude: 42.449229244065165, longitude: -76.48318494212269)
var place6 = Place(imageName: "atm1", rating: 5, category: "ATM", locationDescription: "Phillps Hall", isFavorite: false, tag: 5, latitude: 42.44502410128889, longitude: -76.48227883048034)

var filter1 = Filter(name: "Vending Machine", type: "item", isSelected: false)
var filter2 = Filter(name: "ATM", type: "item", isSelected: false)
var filter3 = Filter(name: "Bathroom", type: "item", isSelected: false)
var filter4 = Filter(name: "< 500ft", type: "distance", isSelected: false)
var filter5 = Filter(name: "< 1 mi", type: "distance", isSelected: false)
var filter6 = Filter(name: "< 2 mi", type: "distance", isSelected: false)

var places = [place1, place2, place3, place4, place5, place6]
var filters = [filter1, filter2, filter3, filter4, filter5, filter6]
var originalData = places
var filteredPlaces: [(place: Place, name: String)] = []
var favorites: [Place] = []


