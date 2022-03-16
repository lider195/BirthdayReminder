import UserNotifications

struct NotificationManagers {
    static func notification(name: String, date: Date, hour: Int, minut: Int) {
        let content = UNMutableNotificationContent()
        content.body = "Today is a birthday - \(name)"
        content.sound = .defaultRingtone
        content.title = "Happy birthday to your friend"

        var dateComponent = Calendar.current.dateComponents([.month, .day, .hour, .minute],
                                                            from: date)

        dateComponent.hour = hour
        dateComponent.minute = minut

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent,
                                                    repeats: true)
        let request = UNNotificationRequest(identifier: "id",
                                            content: content,
                                            trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
}
