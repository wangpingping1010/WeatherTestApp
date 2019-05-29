//
//  LocationService.swift
//  WeatherApp_Wang
//
//  Created by Admin on 5/25/19.
//  Copyright © 2019 Jared Stone. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: CLLocationManager, CLLocationManagerDelegate {
    public static var shared: LocationService!
    public var currentLatitude: Double?
    public var currentLongitude: Double?
    public var authorizationStatus: CLAuthorizationStatus
    
    private override init() {
        authorizationStatus = CLLocationManager.authorizationStatus()
        super.init()
    }
    
    public static func instantiateSharedInstance() {
        // initialize with example data
        shared = LocationService()
        
        LocationService.shared.delegate = LocationService.shared
        LocationService.shared.desiredAccuracy = kCLLocationAccuracyBest
        LocationService.shared.startUpdatingLocation()
    }
    
    var locationPermissionsGranted: Bool {
        return authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
    }
    
    var currentLocation: CLLocation? {
        if let latitude = currentLatitude, let longitude = currentLongitude {
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        return nil
    }
    
    // MARK: - Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
            self.currentLatitude = nil
            self.currentLongitude = nil
        }
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "kLocationAuthorizationUpdated"), object: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = manager.location?.coordinate
        if currentLongitude == nil && currentLatitude == nil {
            currentLatitude = currentLocation?.latitude
            currentLongitude = currentLocation?.longitude
            NotificationCenter.default.post(name: Notification.Name(rawValue: "kLocationDataEnabled"), object: self)
            LocationService.shared.stopUpdatingLocation()
        }
    }
}
