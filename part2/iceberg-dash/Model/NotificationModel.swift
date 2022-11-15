//
//  NotificationModel.swift
//  iceberg-dash
//
//  Created by yury mid on 07.11.2022.
//

import Foundation
import SwiftUI

struct Notification: Hashable {
    let id: UUID = UUID()
    let title: String
    let content: String
    let datetime: Date = Date()
    let icon: Image = Image(systemName: "info.circle")
    var seen: Bool = false
    
    static func == (lhs: Notification, rhs: Notification) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
