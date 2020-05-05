//
//  WeatherManager.swift
//  Clima
//
//  Created by Юрий Федоров on 11.04.2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error:  Error)
}


struct WeatherManager {

    // "&lang=ru" - piece of request for Russian language
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=5cd9cf3b9da9a8da9baa90badbfc00be&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = weatherURL + "&q=" + cityName
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather[0].description
            let tempMin = decodedData.main.temp_min
            let tempMax = decodedData.main.temp_max
            let pressure = decodedData.main.pressure
            let humidity = decodedData.main.humidity
            let feelsLike = decodedData.main.feels_like
            let windSpeed = decodedData.wind.speed
            let windDeg = decodedData.wind.deg
            let sunrise = decodedData.sys.sunrise
            let sunset = decodedData.sys.sunset
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: description, tempMin: tempMin, tempMax: tempMax, pressure: pressure, humidity: humidity, feelsLike: feelsLike, windSpeed: windSpeed, windDeg: windDeg, sunrise: sunrise, sunset: sunset)
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
