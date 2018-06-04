//
//  PlaceFinderViewController.swift
//  QueroConhecer
//
//  Created by Ricardo Duarte on 2018-05-29.
//  Copyright © 2018 KTech. All rights reserved.
//

import UIKit
import MapKit

class PlaceFinderViewController: UIViewController {
    
    enum PlaceFinderMessageType {
        case error(String)
        case confirmation(String)
    }

    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet weak var viLoading: UIView!
    
    var place : Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func findCity(_ sender: UIButton) {
        //hidden the text fiels after click search button
        tfCity.resignFirstResponder()
        let address = tfCity.text!
        load(show: true)
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            self.load(show: false)
//            guard let placemark = placemarks?.first else {return}
//            print(Place.getFormattedStreetAddress(with: placemark))
            if error == nil {
                if !self.savePlace(with: (placemarks?.first)!) {
                    print("Not Ok")
                    //Show error
                    self.showMessage(type: .error("Not found any result with this name"))
                }else{
                    print("Ok")
                    self.showMessage(type: .error("Unknown error"))
                }
            }
        }
        
    }
    
    //Method to check if the search returned a valid address
    func savePlace(with placemark: CLPlacemark?) -> Bool {
        //"Recuperar" the coordinate and placemark
        guard let placemark = placemark, let coordinate = placemark.location?.coordinate else {
            return false
        }
        
        let name = placemark.name ?? placemark.country ?? "unknown place"
        let address = Place.getFormattedStreetAddress(with: placemark)
        //created place
        place = Place(name: name, latitude: coordinate.latitude, longitude: coordinate.longitude, address: address)
        //create a region on the map which will show the place you want to search
        let region = MKCoordinateRegionMakeWithDistance(coordinate, 3500, 3500)
        //show with the map
        mapView.setRegion(region, animated: true)
        
        //Alert
        self.showMessage(type: .confirmation(place.name))
        
        return true
    }
    
    func showMessage(type: PlaceFinderMessageType) {
        let title: String, message: String
        //alert need or not a confimation button
        var hasConfirmation: Bool = false
        switch type {
        case .confirmation(let name):
            title = "Location Found"
            message = "Do you want to add \(name)?"
        case .error(let errorMessage):
            title = "Error"
            message = errorMessage
        }
        //Alert creation
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("OK")
        }
        alert.addAction(confirmAction)
//        if hasConfirmation {
//            let confirmAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//              print("OK")
//            })
//            alert.addAction(confirmAction)
//        }
        present(alert, animated: true, completion: nil)
    }
    
    func load(show: Bool){
        viLoading.isHidden = !show
        
        if show{
            aiLoading.startAnimating()
        }else{
            aiLoading.stopAnimating()
        }
    }
    
    
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
