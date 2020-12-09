//
//  Place.swift
//  Places
//
//  Created by Ria Vora on 12/6/20.
//

import Foundation

class Place: Equatable, NSCopying {
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.tag == rhs.tag
    }
    
    
    var imageName: String!
    var location: String?
    var rating: Int!
    var category: String!
    var locationDescription: String!
    var latitude: Double?
    var longitude: Double?
    var isFavorite: Bool!
    var tag: Int!
    var notes: String!
    var reviews: [Review]!
    
    init(imageName: String, rating: Int, category: String, locationDescription: String, isFavorite: Bool, tag: Int){
        self.imageName = imageName
        self.rating = rating
        self.category = category
        self.locationDescription = locationDescription
        self.isFavorite = isFavorite
        self.tag = tag
    }
    
    init(imageName: String, rating: Int, category: String, locationDescription: String, isFavorite: Bool, tag: Int, latitude: Double, longitude: Double, notes: String, reviews: [Review]){
        self.imageName = imageName
        self.rating = rating
        self.category = category
        self.locationDescription = locationDescription
        self.isFavorite = isFavorite
        self.tag = tag
        self.longitude = longitude
        self.latitude = latitude
        self.notes = notes
        self.reviews = reviews
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Place(imageName: imageName, rating: rating, category: category, locationDescription: locationDescription, isFavorite: isFavorite, tag: tag)
        return copy
    }
    
}
