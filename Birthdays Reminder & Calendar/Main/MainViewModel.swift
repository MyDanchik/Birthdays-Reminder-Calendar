import UIKit

protocol MainViewModel {
    func loadBirthdays()
    func transitionToAddNewBirthdays()
    var setupBirthdays: (([Birthdays]) -> Void)? { get set }
    var transition: ((DefaultAddBirthdaysView) -> Void)? { get set }
}

final class DefaultMainViewModel: MainViewModel {
    
    // MARK: - Properties
    
    var setupBirthdays: (([Birthdays]) -> Void)?
    var transition: ((DefaultAddBirthdaysView) -> Void)?
    
    // MARK: - MainViewModel Methods
    
    func loadBirthdays() {
        let operationResult = CoreDataManager.instance.getBirthdays()
        switch operationResult {
        case .success(let birthdays):
            setupBirthdays?(birthdays)
            scheduleNotifications(for: birthdays)
        case .failure(let error):
            print("Failed to load BirthdaysList: \(error)")
        }
    }
    
    func transitionToAddNewBirthdays() {
        let addBirthdaysView = DefaultAddBirthdaysView()
        let addBirthdaysViewModel = DefaultAddBirthdaysViewModel()
        addBirthdaysView.viewModel = addBirthdaysViewModel
        transition?(addBirthdaysView)
    }
    
    
    func scheduleNotifications(for birthdays: [Birthdays]) {
        for birthday in birthdays {
            NotificationManager.shared.scheduleBirthdayNotification(for: birthday)
        }
    }
}
