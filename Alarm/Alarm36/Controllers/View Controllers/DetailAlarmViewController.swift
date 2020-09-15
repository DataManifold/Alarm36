//
//  DetailAlarmViewController.swift
//  Alarm36
//
//  Created by Shean Bjoralt on 9/14/20.
//  Copyright © 2020 Shean Bjoralt. All rights reserved.
//

import UIKit

class DetailAlarmViewController: UITableViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var enableButton: UIButton!
    
    //MARK: - Properties
    
    var alarm: Alarm?
    
    var alarmEnabled = false
    
    //MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        updateEnableButton()
    }
    
    //MARK: - Helper Functions
    
    func updateViews() {
        guard let alarm = alarm else { return }
        nameTextField.text = alarm.name
        alarmDatePicker.date = alarm.fireDate
        alarmEnabled = alarm.enabled
        updateEnableButton()
    }
    
    func updateEnableButton(){
        if alarmEnabled {
            enableButton.setTitle("Disable", for: .normal)
        } else {
            enableButton.setTitle("Enable", for: .normal)
        }
        enableButton.tintColor = alarmEnabled ? .red : .blue
    }
    
    //MARK: - Actions
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmEnabled = !alarmEnabled
        updateEnableButton()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else { return }
        let fireDate = alarmDatePicker.date
        if let alarm = self.alarm {
            AlarmController.shared.updateAlarm(alarmToUpdate: alarm, newName: name, newEnabled: alarmEnabled, newFireDate: fireDate)
        } else {
            AlarmController.shared.addAlarm(name: name, enabled: alarmEnabled, fireDate: fireDate)
        }
        navigationController?.popViewController(animated: true)
    }
} // End of Class
