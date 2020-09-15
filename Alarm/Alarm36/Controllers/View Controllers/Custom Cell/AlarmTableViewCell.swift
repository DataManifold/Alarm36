//
//  AlarmTableViewCell.swift
//  Alarm36
//
//  Created by Shean Bjoralt on 9/14/20.
//  Copyright © 2020 Shean Bjoralt. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: AnyObject {
    func switchCellSwitchValueChanged(cell: AlarmTableViewCell)
} // End of Protocol

class AlarmTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //MARK: - Properties
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }

    //MARK: - Helper Functions
    
    func updateViews() {
        guard let alarm = alarm else { return }
        timeLabel.text = alarm.fireDateString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
    
    //MARK: - Actions
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchCellSwitchValueChanged(cell: self)
    }
} // End of Class
