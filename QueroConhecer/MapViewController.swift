//
//  MapViewController.swift
//  QueroConhecer
//
//  Created by Ricardo Duarte on 2018-05-29.
//  Copyright © 2018 KTech. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viInfo: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showRoute(_ sender: UIButton) {
    }
    
    @IBAction func showSearchBar(_ sender: UIBarButtonItem) {
    }
    
}
