//
//  Data.swift
//  Places
//
//  Created by Ria Vora on 12/7/20.
//

import Foundation


// Data
var place1 = Place(imageName: "vending1", rating: 5, category: "Vending Machine", locationDescription: "Rhodes Hall", isFavorite: false, tag: 0)
var place2 = Place(imageName: "vending2", rating: 4, category: "Vending Machine", locationDescription: "Uris Hall", isFavorite: false, tag: 1)
var place3 = Place(imageName: "bathroom1", rating: 5, category: "Bathroom", locationDescription: "Terrace", isFavorite: true, tag: 2)
var place4 = Place(imageName: "bathroom2", rating: 5, category: "Bathroom", locationDescription: "Duffield Hall", isFavorite: false, tag: 3)
var place5 = Place(imageName: "atm1", rating: 5, category: "ATM", locationDescription: "Collegetown", isFavorite: false, tag: 4)
var place6 = Place(imageName: "atm1", rating: 5, category: "ATM", locationDescription: "Rhodes Hall", isFavorite: false, tag: 5)

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


