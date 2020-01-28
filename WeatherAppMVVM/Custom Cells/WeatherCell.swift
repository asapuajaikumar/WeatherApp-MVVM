//
//  WeatherCellTableViewCell.swift
//  WeatherAppMVVM
//
//  Created by Ajaikumar on 03/12/19.
//  Copyright © 2019 Ajaikumar. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(_ vm: WeatherViewModel) {
        self.cityNameLabel?.text = vm.name
        self.temperatureLabel?.text = "\(vm.currentTemperature.temperature.formatAsDegree)°"
    }
}
