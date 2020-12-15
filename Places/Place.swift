//
//  Place.swift
//  Places
//
//  Created by Ria Vora on 12/6/20.
//

import Foundation

struct Place: Codable, Hashable {
    
    var id: Int
    var name: String
    var types: String
    var lat: Double
    var lon: Double
    var image_url: String 
}

struct Rating: Codable{
    var rating: Int
}

struct favoritePlace: Codable, Hashable {
    
    var name: String
    var latitude: Double
    var longitude: Double
    var types: String
    var img_url: String
}

