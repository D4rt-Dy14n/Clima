//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDegLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        
    }
    @IBAction func locateButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Write your city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
}


//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage.init(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.descriptionLabel.text = weather.description
            self.feelsLikeLabel.text = "Feels like: \(weather.feelsLikeString) ºC"
            self.humidityLabel.text = "Humidity: \(weather.humidityString)%"
            self.pressureLabel.text = "Pressure: \(weather.pressureString) mmHg"
            self.sunriseLabel.text = "🌅: \(weather.sunriseDate)"
            self.sunsetLabel.text = "🌇: \(weather.sunsetDate)"
            self.tempMaxLabel.text = "Max🌡️: \(weather.tempMaxString) ºC"
            self.tempMinLabel.text = "Min🌡️: \(weather.tempMinString) ºC"
            self.windDegLabel.text = "Deg: \(weather.windDegString)"
            self.windSpeedLabel.text = "Wind: \(weather.windSpeedString) m/s"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            locationManager.stopUpdatingLocation()
            return
        }
    }
}
