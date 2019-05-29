//
//  ListTableViewCell.swift
//  WeatherApp_Wang
//
//  Created by Admin on 5/25/19.
//  Copyright © 2019 Jared Stone. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var currentLocationIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func configurationWeatherData(_ weatherData: WeatherInformationData) {
        let weatherConditionSymbol = ConvertService.weatherConditionSymbol(fromWeathercode: weatherData.weatherCondition[0].identifier)
        conditionLbl.text = weatherConditionSymbol
        
        let temperature = ConvertService.temperatureDescriptor(fromRawTemperature: weatherData.atmosphericInformation.temperatureKelvin)
        temperatureLbl.text = temperature
        
        let localtime = ConvertService.localTime(coordinate: Coordinates(latitude: weatherData.coordinates.latitude, longitude: weatherData.coordinates.longitude))
        timeLbl.text = localtime
        
    }
}
