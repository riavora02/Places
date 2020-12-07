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
    var latitude: Int?
    var longitude: Int?
    var isFavorite: Bool!
    var tag: Int!
    
    init(imageName: String, rating: Int, category: String, locationDescription: String, isFavorite: Bool, tag: Int){
        self.imageName = imageName
        self.rating = rating
        self.category = category
        self.locationDescription = locationDescription
        self.isFavorite = isFavorite
        self.tag = tag
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Place(imageName: imageName, rating: rating, category: category, locationDescription: locationDescription, isFavorite: isFavorite, tag: tag)
        return copy
    }
    
}
