//
//  NotificationsDTO.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import Foundation
// Data Model
// Data Model
struct AppNotificationItem {
    let message: String
    let dateText: String
}

// Sample Data (10 items - mixed ISO8601 string dates)
let notifications: [AppNotificationItem] = [
    AppNotificationItem(message: "Haftalık Aktif görevi tamamlandı. +220 puan.", dateText: "2026-03-12T21:15:00Z"),
    AppNotificationItem(message: "Kategori Avcısı görevi tamamlandı. +120 puan.", dateText: "2026-03-11T09:42:00Z"),
    AppNotificationItem(message: "Elektronik Bonus görevi tamamlandı. +180 puan.", dateText: "2026-03-10T18:30:00Z"),
    AppNotificationItem(message: "Günlük Harcama görevi tamamlandı. +60 puan.", dateText: "2026-03-09T12:05:00Z"),

    AppNotificationItem(message: "Elektronik Bonus görevi tamamlandı. +180 puan.", dateText: "2026-03-08T22:40:00Z"),
    AppNotificationItem(message: "Haftalık Aktif görevi tamamlandı. +220 puan.", dateText: "2026-03-07T08:15:00Z"),
    AppNotificationItem(message: "Günlük Harcama görevi tamamlandı. +60 puan.", dateText: "2026-03-06T19:55:00Z"),
    AppNotificationItem(message: "Kategori Avcısı görevi tamamlandı. +120 puan.", dateText: "2026-03-05T14:10:00Z"),

    AppNotificationItem(message: "Haftalık Aktif görevi tamamlandı. +220 puan.", dateText: "2026-03-04T10:20:00Z"),
    AppNotificationItem(message: "Elektronik Bonus görevi tamamlandı. +180 puan.", dateText: "2026-03-03T16:45:00Z")
]

