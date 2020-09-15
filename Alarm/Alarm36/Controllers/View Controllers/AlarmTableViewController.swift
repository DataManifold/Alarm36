//
//  AlarmTableViewController.swift
//  Alarm36
//
//  Created by Shean Bjoralt on 9/14/20.
//  Copyright © 2020 Shean Bjoralt. All rights reserved.
//

import UIKit

class AlarmTableViewController: UITableViewController {

    //MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCustomCell", for: indexPath) as? AlarmTableViewCell else { return UITableViewCell() }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell.alarm = alarm
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.removeAlarm(alarmToRemove: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("In prepare segue")
        if segue.identifier == "toDetailVC" {
            guard let detailVC = segue.destination as? DetailAlarmViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let alarm = AlarmController.shared.alarms[indexPath.row]
            detailVC.alarm = alarm
        }
    }
} // End of Class

extension AlarmTableViewController: SwitchTableViewCellDelegate {
    func switchCellSwitchValueChanged(cell: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleEnable(alarm: alarm)
        cell.updateViews()
    }
} // End of Extension
