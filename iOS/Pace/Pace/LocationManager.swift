//
//  LocationManager.swift
//
//  Created by Davide Bruzzone on 10/12/15.
//  Copyright © 2015 Davide Bruzzone. All rights reserved.
//

import UIKit

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("Location service authorization status: ", terminator: "")

        switch CLLocationManager.authorizationStatus() {
        case .Authorized:
            print("Authorized")
        case .AuthorizedWhenInUse:
            print("Authorized when in use")
        case .Denied:
            print("Denied")
        case .NotDetermined:
            print("Not determined")
        case .Restricted:
            print("Restricted")
        // default would never be executed
        }
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location manager failed with error '\(error)'")
    }

    func locationManager(manager: CLLocationManager,
                         didUpdateToLocation newLocation: CLLocation,
                         fromLocation oldLocation: CLLocation) {
        print("Latitude/longitude: \(newLocation.coordinate.latitude)/\(newLocation.coordinate.longitude)")
    }
}
