//
//  PlaceDetailViewController.swift
//  Places
//
//  Created by Ria Vora on 12/8/20.
//

import UIKit

class PlaceDetailViewController: UIViewController {

    init(place: Place){
        super.init(nibName: nil, bundle: nil)
        print(place)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: false)
        view.backgroundColor = .white
        print("Hey I opened a new controller!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
