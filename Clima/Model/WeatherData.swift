//
//  WeatherData.swift
//  Clima
//
//  Created by Юрий Федоров on 11.04.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Weather: Codable {
    let id: Int 
    let main: String
    let description: String
    let icon: String
}

struct Wind: Codable {
    let speed: Double
    let deg: Double
}

struct Sys: Codable {
    let sunrise: Double
    let sunset: Double
}
