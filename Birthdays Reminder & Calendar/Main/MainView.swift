import UIKit
import UserNotifications

final class DefaultMainView: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: MainViewModel!
    private var tableView = UITableView()
    var birthdaysList = [Birthdays]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBindings()
        notification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadBirthdays()
        scheduleBirthdayNotifications()
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        view.backgroundColor = .backgroundMainScreen
        title = "Birthdays List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: UIAction(handler: { [weak self] _ in
            self?.transitionToAddBirthdaysView()
        }))
        navigationItem.backButtonTitle = ""
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainViewCell.self, forCellReuseIdentifier: "MainViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .backgroundMainScreen
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupBindings() {
        viewModel.setupBirthdays = { [weak self] birthdays in
            self?.birthdaysList = birthdays.reversed()
        }
        
        viewModel.transition = { [weak self] addBirthdaysView in
            self?.navigationController?.pushViewController(addBirthdaysView, animated: true)
        }
    }
    
    private func transitionToAddBirthdaysView() {
        viewModel.transitionToAddNewBirthdays()
    }
    
    private func notification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Разрешение на отправку уведомлений получено")
                self.scheduleBirthdayNotifications()
            } else {
                print("Ошибка при запросе разрешения на отправку уведомлений: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    // Метод для настройки уведомлений
    private func scheduleBirthdayNotifications() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("Уведомления не разрешены")
                return
            }
            
            for birthday in self.birthdaysList {
                guard let birthdayDateString = birthday.dateBirthdays,
                      let birthdayDate = self.dateFormatter.date(from: birthdayDateString) else {
                    continue
                }
                self.sendBirthdayNotification(date: birthdayDate, birthday: birthday)
            }
        }
    }
    
    // Метод для отправки уведомления
    private func sendBirthdayNotification(date: Date, birthday: Birthdays) {
        
        let content = UNMutableNotificationContent()
        content.title = "День рождения"
        content.body = "Сегодня у \(birthday.nameBirthdays ?? "") \(birthday.surnameBirthdays ?? "") день рождения!"
        content.sound = UNNotificationSound.default
        
        var triggerDate = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: date)
        triggerDate.hour = 15
        triggerDate.minute = 36
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension DefaultMainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdaysList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCell", for: indexPath) as? MainViewCell else {
            return UITableViewCell()
        }
        let birthdays = birthdaysList[indexPath.row]
        cell.configureEntity(birthdays: birthdays)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let birthdays = birthdaysList[indexPath.row]
            let alertDelete = UIAlertController(title: "Удалить напоминание?", message: "", preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction(title: "Нет", style: .default, handler: nil))
            alertDelete.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { _ in
                _ = CoreDataManager.instance.deleteBirthdays(birthdays)
                self.viewModel.loadBirthdays()
            }))
            present(alertDelete, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fullBirthdaysView = DefaulFullInfoView()
        let birthdays = birthdaysList[indexPath.row]
        fullBirthdaysView.configureFullBirthdays(birthdays: birthdays)
        navigationController?.pushViewController(fullBirthdaysView, animated: true)
    }
}
