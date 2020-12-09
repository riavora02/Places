//
//  StarView.swift
//  Places
//
//  Created by Ria Vora on 12/9/20.
//

import UIKit
import SnapKit

class StarView: UIView {

    var star1: UIImageView!
    var rating: Int!
    var currentPlace: Place!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
