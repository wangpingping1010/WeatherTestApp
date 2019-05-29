//
//  DetailViewController.swift
//  WeatherApp_Wang
//
//  Created by Admin on 5/25/19.
//  Copyright © 2019 Jared Stone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var weatherSymbolLbl: UILabel!
    @IBOutlet weak var weatherMainLbl: UILabel!
    @IBOutlet weak var weatherDetailLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var cloudCoverageValueLbl: UILabel!
    @IBOutlet weak var humidityValueLbl: UILabel!
    @IBOutlet weak var pressureValueLbl: UILabel!
    @IBOutlet weak var windSpeedValueLbl: UILabel!
    @IBOutlet weak var windDirectionLbl: UILabel!
    @IBOutlet weak var windDirectionValueLbl: UILabel!
    
    public var weatherInfo : WeatherInformationData!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initUI()
    }
    
    func initUI() {
        self.title = weatherInfo.cityName
        
        let symbolStr = ConvertService.weatherConditionSymbol(fromWeathercode: weatherInfo.weatherCondition[0].identifier)
        weatherSymbolLbl.text = symbolStr
        
        weatherMainLbl.text = weatherInfo.weatherCondition[0].conditionName
        weatherDetailLbl.text = weatherInfo.weatherCondition[0].conditionDescription
        
        let temperature = ConvertService.temperatureDescriptor(fromRawTemperature: weatherInfo.atmosphericInformation.temperatureKelvin)
        temperatureLbl.text = temperature
        
        let localtime = ConvertService.localTime(coordinate: Coordinates(latitude: weatherInfo.coordinates.latitude, longitude: weatherInfo.coordinates.longitude))
        timeLbl.text = localtime
        
        cloudCoverageValueLbl.text = "\(weatherInfo.cloudCoverage.coverage) %"
        humidityValueLbl.text = "\(weatherInfo.atmosphericInformation.humidity) %"
        pressureValueLbl.text = "\(weatherInfo.atmosphericInformation.pressurePsi) hpa"
        
        let windSpeed = ConvertService.windSpeed(windspeed: weatherInfo.windInformation.windspeed)
        windSpeedValueLbl.text = windSpeed
        
        if let windDirection = weatherInfo.windInformation.degrees {
            let winDegree = ConvertService.windDirection(degrees: windDirection)
            windDirectionValueLbl.text = winDegree
        } else {
            windDirectionLbl.isHidden = true
            windDirectionValueLbl.isHidden = true
        }
        
    }

    // MARK: - Button Action
    @IBAction func onGoToList(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
