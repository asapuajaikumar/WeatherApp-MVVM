//
//  AddWeatherCityViewController.swift
//  WeatherAppMVVM
//
//  Created by Ajaikumar on 03/12/19.
//  Copyright © 2019 Ajaikumar. All rights reserved.
//

import UIKit

protocol AddWeatherDelegate {
    
    func addWeatherDidSave(vm: WeatherViewModel)
}

class AddWeatherCityViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    var delegate: AddWeatherDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Save action
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        if let city = cityNameTextField.text {
            let userDefaults = UserDefaults.standard
            let unit = userDefaults.value(forKey: "unit") as! String
            
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=eeb6a5b00a72a602b2b084e31acaf86c&units=\(unit)")!
            
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { data in
                
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherVM
            }
            
            Webservice().load(resource: weatherResource) { result in
                if let weatherVM = result {
                    if let delegate = self.delegate {
                        delegate.addWeatherDidSave(vm: weatherVM)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    //MARK: - Cancel Action
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
