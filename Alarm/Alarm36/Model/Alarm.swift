//
//  Alarm.swift
//  Alarm36
//
//  Created by Shean Bjoralt on 9/14/20.
//  Copyright © 2020 Shean Bjoralt. All rights reserved.
//

import Foundation

class Alarm: Codable {
    
    var name: String
    var enabled: Bool
    var fireDate: Date
    
    let uuid: String = UUID().uuidString
    var fireDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL dd, h:mm a"
        return dateFormatter.string(from: fireDate)
    }
    
    init(name: String, enabled: Bool, fireDate: Date) {
        self.name = name
        self.enabled = enabled
        self.fireDate = fireDate
    }
} // End of Class

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.name == rhs.name && lhs.enabled == rhs.enabled && lhs.fireDate == rhs.fireDate && lhs.uuid == rhs.uuid
    }
} // End of Extension
