//
//  ListViewController.swift
//  WeatherApp_Wang
//
//  Created by Admin on 5/25/19.
//  Copyright © 2019 Jared Stone. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var weatherDataArray = [WeatherInformationData]()
    var stationArray = [StationInformationData]()
    var selectedData : WeatherInformationData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshWeatherData), name: Notification.Name(rawValue: "kLocationDataEnabled"), object: nil)
    }
    
    @objc func refreshWeatherData() {
        if let currentLatitude = LocationService.shared.currentLatitude, let currentLongitude = LocationService.shared.currentLongitude {
            stationArray = []
            weatherDataArray = []
            stationArray.append(StationInformationData.init(city: "Current", coordinates: Coordinates(latitude: currentLatitude, longitude: currentLongitude)))
            stationArray.append(StationInformationData.init(city: "Tokyo", coordinates: Coordinates(latitude: 35.69, longitude: 139.69)))
            stationArray.append(StationInformationData.init(city: "London", coordinates: Coordinates(latitude: 42.98, longitude: -81.23)))
            for i in 0..<stationArray.count {
                self.fetchWeatherData(latitude: stationArray[i].coordinates.latitude, longitude: stationArray[i].coordinates.longitude)
            }
        } else {
            stationArray = []
            weatherDataArray = []
            stationArray.append(StationInformationData.init(city: "Tokyo", coordinates: Coordinates(latitude: 35.69, longitude: 139.69)))
            stationArray.append(StationInformationData.init(city: "London", coordinates: Coordinates(latitude: 42.98, longitude: -81.23)))
            for i in 0..<stationArray.count {
                self.fetchWeatherData(latitude: stationArray[i].coordinates.latitude, longitude: stationArray[i].coordinates.longitude)
            }
        }
    }
    
    func fetchWeatherData(latitude: Double, longitude: Double) {
        let urlString = "\(Configuration.BaseURL)?lat=\(latitude)&lon=\(longitude)" +
        "&appid=\(Configuration.APIKey)"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let tempInfo = try JSONDecoder().decode(WeatherInformationData.self, from: data)
                self.weatherDataArray.append(tempInfo)
                if self.weatherDataArray.count == self.stationArray.count {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Something went wrong. Try again later!")
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetailSegue" {
            let vc = segue.destination as! DetailViewController
            vc.weatherInfo = self.selectedData
        }
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedData = self.weatherDataArray[indexPath.row]
        self.performSegue(withIdentifier: "goDetailSegue", sender: self)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        if self.stationArray[indexPath.row].city == "Current" {
            cell.currentLocationIcon.isHidden = false
            cell.cityLbl.text = self.weatherDataArray[indexPath.row].cityName
        } else {
            cell.currentLocationIcon.isHidden = true
            cell.cityLbl.text = self.stationArray[indexPath.row].city
        }
        cell.configurationWeatherData(self.weatherDataArray[indexPath.row])
        return cell
    }
    
    
}
