//
//  WeatherModel.swift
//  Clima
//
//  Created by Юрий Федоров on 12.04.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let feelsLike: Double
    let windSpeed: Double
    let windDeg: Double
    let sunrise: Double
    let sunset: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var tempMinString: String {
        return String(format: "%.1f", tempMin)
    }
    
    var tempMaxString: String {
        return String(format: "%.1f", tempMax)
    }
    
    var feelsLikeString: String {
        return String(format: "%.1f", feelsLike)
    }
    
    var humidityString: String {
        return String(humidity)
    }
    
    var pressureString: String {
        let pressureMmHg = Double(pressure) * 0.75
        return String(pressureMmHg.rounded())
    }
    
    var windSpeedString: String {
        return String(format: "%.0f", windSpeed)
    }
    
    var windDegString: String {
        
        switch windDeg {
        case 0..<22.5:
            return "⬆️ N"
        case 337.5...360:
            return "⬆️ N"
        case 22.5..<67.5:
            return "↗️ NE"
        case 67.5..<112.5:
            return "➡️ E"
        case 112.5..<157.5:
            return "↘️ SE"
        case 157.5..<202.5:
            return "⬇️ S"
        case 202.5..<247.5:
            return "↙️ SW"
        case 247.5..<292.5:
            return "⬅️ W"
        case 292.5..<337.5:
            return "↖️ NW"
        default:
            break
        }
        
        
        
        
        
        
        
        return String(format: "%.0f", windDeg)
    }
    
    
    var conditionName: String {
        switch conditionId {
        case 200...299:
            return "cloud.bolt.rain"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "cloud.snow"
        case 701, 741:
            return "cloud.fog"
        case 711:
            return "smoke"
        case 721:
            return "sun.haze"
        case 731...762:
            return "sun.dust"
        case 771:
            return "wind"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801, 802:
            return "cloud.sun"
        case 803, 804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
    var sunriseDate: String {
        let date = Date(timeIntervalSince1970: sunrise)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    var sunsetDate: String {
        let date = Date(timeIntervalSince1970: sunset)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
}
