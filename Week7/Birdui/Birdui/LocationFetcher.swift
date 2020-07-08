//
//  LocationFetcher.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 08/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import CoreLocation
import SwiftUI

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var lastKnownLocation:CLLocationCoordinate2D?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

//    func start() {
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastKnownLocation = location.coordinate
    }
}
