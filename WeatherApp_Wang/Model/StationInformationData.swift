//
//  StationInformationData.swift
//  WeatherApp_Wang
//
//  Created by Admin on 5/25/19.
//  Copyright © 2019 Jared Stone. All rights reserved.
//

import Foundation

struct StationInformationData: Codable {
    var city: String
    var coordinates: Coordinates
    
    enum CodingKeys: String, CodingKey {
        case city
        case coordinates = "coord"
    }
    
    init(city: String, coordinates: Coordinates) {
        self.city = city
        self.coordinates = coordinates
    }
}

struct Coordinates: Codable {
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
