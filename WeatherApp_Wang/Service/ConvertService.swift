//
//  ConvertService.swift
//  WeatherApp_Wang
//
//  Created by Admin on 5/25/19.
//  Copyright © 2019 Jared Stone. All rights reserved.
//

import Foundation
import APTimeZones

class ConvertService {
    public static func weatherConditionSymbol(fromWeathercode: Int) -> String {
        switch fromWeathercode {
        case let x where (x >= 200 && x <= 202) || (x >= 230 && x <= 232):
            return "⛈"
        case let x where x >= 210 && x <= 211:
            return "🌩"
        case let x where x >= 212 && x <= 221:
            return "⚡️"
        case let x where x >= 300 && x <= 321:
            return "🌦"
        case let x where x >= 500 && x <= 531:
            return "🌧"
        case let x where x >= 600 && x <= 602:
            return "☃️"
        case let x where x >= 603 && x <= 622:
            return "🌨"
        case let x where x >= 701 && x <= 771:
            return "🌫"
        case let x where x == 781 || x == 900:
            return "🌪"
        case let x where x == 800:
            return "☀️"
        case let x where x == 801:
            return "🌤"
        case let x where x == 802:
            return "⛅️"
        case let x where x == 803:
            return "🌥"
        case let x where x == 804:
            return "☁️"
        case let x where x >= 952 && x <= 956 || x == 905:
            return "🌬"
        case let x where x >= 957 && x <= 961 || x == 771:
            return "💨"
        case let x where x == 901 || x == 902 || x == 962:
            return "🌀"
        case let x where x == 903:
            return "❄️"
        case let x where x == 904:
            return "🌡"
        case let x where x == 962:
            return "🌋"
        default:
            return "❓"
        }
    }
    
    public static func temperatureDescriptor(fromRawTemperature rawTemperature: Double) -> String {
        return "\(String(format:"%.02f", rawTemperature - 273.15))°C"
    }
    
    public static func localTime(coordinate: Coordinates) -> String {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .current
        dateFormatter.timeZone = location.timeZone()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let localTime = dateFormatter.string(from: Date())
        return localTime
    }
    
    public static func windDirection(degrees: Double) -> String {
        return String(format: "%.02f", degrees) + "°"
    }
    
    public static func windSpeed(windspeed: Double) -> String {
        return "\(String(format:"%.02f", windspeed)) km/h"
    }
    
}
