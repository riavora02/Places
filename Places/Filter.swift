//
//  Filter.swift
//  rhv26_p5
//
//  Created by Ria Vora on 10/25/20.
//

import Foundation

class Filter {
    
    var name: String!
    var type: String!
    var isSelected: Bool!
    
    init(name: String!, type: String!, isSelected: Bool!) {
        self.name = name
        self.type = type
        self.isSelected = isSelected
    }
}
