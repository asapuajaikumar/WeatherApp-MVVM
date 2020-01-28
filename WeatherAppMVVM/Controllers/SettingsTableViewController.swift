//
//  SettingsTableViewController.swift
//  WeatherAppMVVM
//
//  Created by Ajaikumar on 03/12/19.
//  Copyright © 2019 Ajaikumar. All rights reserved.
//

import UIKit

protocol SettingsDelegate {
    
    func settingsDone(vm : SettingsViewModel)
}

class SettingsTableViewController: UITableViewController {
    
    private var settingsViewModel = SettingsViewModel()
    var delegate: SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Tableview delegate and  datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingsViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingsItem = self.settingsViewModel.units[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = settingsItem.displayName
        if settingsItem == self.settingsViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // uncheck all cells
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let unit = Unit.allCases[indexPath.row]
        self.settingsViewModel.selectedUnit = unit
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    //MARK: - Done Action
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        if let delegate = self.delegate {
            delegate.settingsDone(vm: self.settingsViewModel)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
