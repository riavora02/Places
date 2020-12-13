//
//  Data.swift
//  Places
//
//  Created by Ria Vora on 12/7/20.
//

import Foundation
import UIKit


// Data
//var place1 = Place(imageName: "vending1", rating: 5, category: "Vending Machine", locationDescription: "Rhodes Hall", isFavorite: false, tag: 0, latitude: 42.44368745887105, longitude: -76.48138611513738, notes: "Behind conference room on 1st floor.", reviews: reviews)
//var place2 = Place(imageName: "vending2", rating: 4, category: "Vending Machine", locationDescription: "Uris Hall", isFavorite: false, tag: 1, latitude: 42.44743666524334, longitude: -76.48221811513734, notes: "Behind conference room on 1st floor.", reviews: reviews)
//var place3 = Place(imageName: "bathroom1", rating: 2, category: "Bathroom", locationDescription: "Terrace", isFavorite: false, tag: 2, latitude: 42.44637801911678, longitude: -76.48227801513728, notes: "Behind conference room on 1st floor.", reviews: reviews)
//var place4 = Place(imageName: "bathroom2", rating: 1, category: "Bathroom", locationDescription: "Duffield Hall", isFavorite: false, tag: 3, latitude: 42.44489302399624, longitude: -76.48266435931619, notes: "Behind conference room on 1st floor.", reviews: reviews)
//var place5 = Place(imageName: "atm1", rating: 4, category: "ATM", locationDescription: "Klarman Hall", isFavorite: false, tag: 4, latitude: 42.449229244065165, longitude: -76.48318494212269, notes: "Behind conference room on 1st floor.", reviews: reviews)
//var place6 = Place(imageName: "atm1", rating: 2, category: "ATM", locationDescription: "Phillps Hall", isFavorite: false, tag: 5, latitude: 42.44502410128889, longitude: -76.48227883048034, notes: "Behind conference room on 1st floor.", reviews: reviews)

var filter1 = Filter(name: "Blue", type: "item", isSelected: false)
var filter2 = Filter(name: "AllGender", type: "item", isSelected: false)
var filter3 = Filter(name: "Water", type: "item", isSelected: false)
var filter7 = Filter(name: "Blue Light Zone", type: "item", isSelected: false)
var filter4 = Filter(name: "< 500ft", type: "distance", isSelected: false)
var filter5 = Filter(name: "< 1 mi", type: "distance", isSelected: false)
var filter6 = Filter(name: "< 2 mi", type: "distance", isSelected: false)

var review1 = Review(user: "Jacob R.", review: "This was a great vending machine. A perfect place to grab a snack when I needed a study break.", rating: 4, placeTag: 1)
var review2 = Review(user: "Michelle V.", review: "This was a great vending machine. A perfect place to grab a snack when I needed a study break.", rating: 3, placeTag: 1)
var review3 = Review(user: "Sara S.", review: "This was a great vending machine. A perfect place to grab a snack when I needed a study break.", rating: 4, placeTag: 1)
var review4 = Review(user: "Thomas K.", review: "This was a great vending machine. A perfect place to grab a snack when I needed a study break.", rating: 1, placeTag: 1)
var review5 = Review(user: "Professor G.", review: "This was a great vending machine. A perfect place to grab a snack when I needed a study break.", rating: 2, placeTag: 1)

//var places = [place1, place2, place3, place4, place5, place6]
var filters = [filter1, filter2, filter3, filter4, filter5, filter6, filter7]
var reviews = [review1, review2, review3, review4, review5]
//var originalData = places
//var filteredPlaces: [(place: Place, name: String)] = []
var favorites: [Place] = []

let lightBlue = UIColor(red: 0.91, green: 0.96, blue: 0.97, alpha: 1.00) 
let darkBlue = UIColor(red: 0.16, green: 0.71, blue: 0.96, alpha: 0.5)
