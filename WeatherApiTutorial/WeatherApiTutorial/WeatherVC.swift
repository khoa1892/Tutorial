//
//  WeatherVC.swift
//  WeatherApiTutorial
//
//  Created by Khoa on 10/11/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWetherImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var currentWeather:CurrentWeather!
    var foreCasts = [Forecast]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            self.downloadForeCastData {
                self.updateMainUI()
            }
        }
    }
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWetherImage.image = UIImage(named: currentWeather.weatherType)
    }
    func downloadForeCastData(completed:@escaping DownloadComplete) {
        //Download data for tableView
        let foreCastURL = URL(string: FORECAST_URL)!
        Alamofire.request(foreCastURL).responseJSON { (responseData) in
            let result = responseData.result
            if let dict = result .value as? [String: AnyObject] {
                if let list = dict["list"] as? [[String: AnyObject]] {
                    for obj in list {
                        let foreCast = Forecast(dic: obj)
                        self.foreCasts.append(foreCast)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
}

extension WeatherVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foreCasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let item = foreCasts[indexPath.row]
        cell.configureCell(forcast: item)
        return cell
    }
    
}
