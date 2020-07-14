//
//  CLLocation.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 13/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import CoreLocation

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }

    var longitude: Double {
        return self.coordinate.longitude
    }
}
