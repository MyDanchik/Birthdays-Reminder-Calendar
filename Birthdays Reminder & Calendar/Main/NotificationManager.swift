import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}        
    
    func scheduleBirthdayNotification(for birthday: Birthdays) {
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("mainPage.notification.title", comment: "")
        content.body = "\(birthday.nameBirthdays ?? "") \(birthday.surnameBirthdays ?? "")"
        content.sound = UNNotificationSound.default
        
        guard let birthdayDate = birthday.dateBirthdays,
              let triggerDate = dateFormatter.date(from: birthdayDate) else {
            return
        }
        
        var triggerDateComponents = calendar.dateComponents([.month, .day, .hour, .minute], from: triggerDate)
        triggerDateComponents.hour = 9
        triggerDateComponents.minute = 30
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    private let calendar = Calendar.current
}
