//
//  Review.swift
//  Places
//
//  Created by Ria Vora on 12/8/20.
//

import Foundation

struct Review: Codable {
    
    var id: Int
    var user_id: Int
    var place_id: Int
    var rating: Int
    var text: String
    
}
