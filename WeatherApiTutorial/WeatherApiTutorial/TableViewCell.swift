//
//  TableViewCell.swift
//  WeatherApiTutorial
//
//  Created by Khoa on 10/11/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    func configureCell(forcast: Forecast) {
        highTempLabel.text = forcast.highTemp
        lowTempLabel.text = forcast.lowTemp
        dayLabel.text = forcast.date
        weatherLabel.text = forcast.weatherType
        weatherImageView.image = UIImage(named: forcast.weatherType)
    }

}
