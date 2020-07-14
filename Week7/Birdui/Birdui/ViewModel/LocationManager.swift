//
//  LocationManager.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 10/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {

    private let geocoder = CLGeocoder()
    private let locationManager = CLLocationManager()
    let objectWillChange = PassthroughSubject<Void, Never>()

    @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }

    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }

    override init() {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    @Published var placemark: CLPlacemark? {
        willSet { objectWillChange.send() }
    }


//    private func geocode() {
//        guard let location = self.location else { return }
//        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
//            if error == nil {
//                self.placemark = places?[0]
//            } else {
//                self.placemark = nil
//            }
//        })
//    }

    

}


extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
//        self.geocode()
    }

//    func convertLatLongToAddress(latitude:Double,longitude:Double){
//
//        let geoCoder = CLGeocoder()
//        let location = CLLocation(latitude: latitude, longitude: longitude)
//        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
//
//            // Place details
//            var placeMark: CLPlacemark!
//            placeMark = placemarks?[0]
//
//            // Location name
//            if let locationName = placeMark.location {
//                print(locationName)
//            }
//            // Street address
//            if let street = placeMark.thoroughfare {
//                print(street)
//            }
//            // City
//            if let city = placeMark.subAdministrativeArea {
//                print(city)
//            }
//            // Zip code
//            if let zip = placeMark.isoCountryCode {
//                print(zip)
//            }
//            // Country
//            if let country = placeMark.country {
//                print(country)
//            }
//        })
//
//    }
}



