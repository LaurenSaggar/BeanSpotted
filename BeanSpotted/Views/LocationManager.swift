//
//  LocationManager.swift
//  BeanSpotted
//
//  Created by Lauren Saggar on 1/18/26.
//

import SwiftUI
import CoreLocation
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // Apple's core location manager that talks to OS and hardware
    private let manager = CLLocationManager()

    // Tracks user's location and updates views observing location manager whenever location changes
    @Published var location: CLLocation?

    override init() {
        super.init()
        manager.delegate = self
        // More accuracy leads to higher battery usage
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    // Prompts user to select their location permission preferences and single location update
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
    }

    // Called by iOS when there is a location fix
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first // Triggers SwiftUI updates
    }

    // Called if location fails
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error)
    }
}
