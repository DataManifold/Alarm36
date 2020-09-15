//
//  AlarmController.swift
//  Alarm36
//
//  Created by Shean Bjoralt on 9/14/20.
//  Copyright © 2020 Shean Bjoralt. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: AnyObject {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm) {

        let content = UNMutableNotificationContent()
        content.sound = .default
        content.title = alarm.name

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { (_) in
            print("User asked to get a local notification")
        }
    }

    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}

class AlarmController: AlarmScheduler {
    
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []
    
    //MARK: - Helper Function
    
    func toggleEnable(alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        saveToPersistentStore()
    }
    
    //MARK: - CRUD Functions
    
    func addAlarm(name: String, enabled: Bool, fireDate: Date) {
        let newAlarm = Alarm(name: name, enabled: enabled, fireDate: fireDate)
        alarms.append(newAlarm)
        if newAlarm.enabled {
            scheduleUserNotifications(for: newAlarm)
        }
        saveToPersistentStore()
    }
    
    func removeAlarm(alarmToRemove: Alarm) {
        guard let index = alarms.firstIndex(of: alarmToRemove) else { return }
        alarms.remove(at: index)
        cancelUserNotifications(for: alarmToRemove)
        saveToPersistentStore()
    }
    
    func updateAlarm(alarmToUpdate: Alarm, newName: String, newEnabled: Bool, newFireDate: Date) {
        alarmToUpdate.name = newName
        alarmToUpdate.enabled = newEnabled
        alarmToUpdate.fireDate = newFireDate
        cancelUserNotifications(for: alarmToUpdate)
        if alarmToUpdate.enabled {
            scheduleUserNotifications(for: alarmToUpdate)
        }
        saveToPersistentStore()
    }
    
    //MARK: - Persistence
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let filename = "alarms.json"
        let fullURL = documentsDirectory.appendingPathComponent(filename)
        return fullURL
    }
    
    func saveToPersistentStore() {
        do {
            let data =  try JSONEncoder().encode(alarms)
            print(data)
            print(String(data: data, encoding: .utf8)!)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving alarms \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            let alarms = try JSONDecoder().decode([Alarm].self, from: data)
            self.alarms = alarms
        } catch let error {
            print("Error loading data from disk \(error)")
        }
    }
} // End of Class
