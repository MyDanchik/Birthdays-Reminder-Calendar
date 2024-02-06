import UIKit
import UserNotifications

final class DefaultMainView: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: MainViewModel!
    private var tableView = UITableView()
    var birthdaysList = [Birthdays]() {
        didSet {
            birthdaysList = sortBirthdaysByDate(birthdaysList)
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadBirthdays()
    }
    
    // MARK: - Setup Methods
    
    private func setupUI() {
        view.backgroundColor = .backgroundMainScreen
        title = NSLocalizedString("mainPage.titel", comment: "")
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
    
    // MARK: - Helper Methods
    
    private func sortBirthdaysByDate(_ birthdays: [Birthdays]) -> [Birthdays] {
        return birthdays.sorted { lhs, rhs in
            guard let lhsDate = dateFormatter.date(from: lhs.dateBirthdays ?? ""),
                  let rhsDate = dateFormatter.date(from: rhs.dateBirthdays ?? "") else {
                return false
            }
            
            let currentDate = Date()
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: currentDate)
            
            var lhsNextBirthdayComponents = calendar.dateComponents([.day, .month], from: lhsDate)
            lhsNextBirthdayComponents.year = currentYear
            if let lhsNextBirthday = calendar.date(from: lhsNextBirthdayComponents),
               lhsNextBirthday <= currentDate {
                lhsNextBirthdayComponents.year = currentYear + 1
            }
            
            var rhsNextBirthdayComponents = calendar.dateComponents([.day, .month], from: rhsDate)
            rhsNextBirthdayComponents.year = currentYear
            if let rhsNextBirthday = calendar.date(from: rhsNextBirthdayComponents),
               rhsNextBirthday <= currentDate {
                rhsNextBirthdayComponents.year = currentYear + 1
            }
            
            let lhsComponents = calendar.dateComponents([.day], from: currentDate, to: calendar.date(from: lhsNextBirthdayComponents)!)
            let rhsComponents = calendar.dateComponents([.day], from: currentDate, to: calendar.date(from: rhsNextBirthdayComponents)!)
            
            if let lhsDaysRemaining = lhsComponents.day, let rhsDaysRemaining = rhsComponents.day {
                if lhsDaysRemaining == 365 {
                    return true
                } else if rhsDaysRemaining == 365 {
                    return false
                } else {
                    return lhsDaysRemaining < rhsDaysRemaining
                }
            } else {
                return false
            }
        }
    }
    
}
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter
}()


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
            let alertDelete = UIAlertController(title: NSLocalizedString("mainPage.alertDelete.message", comment: ""), message: "", preferredStyle: .alert)
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("mainPage.alertDelete.no", comment: ""), style: .default, handler: nil))
            alertDelete.addAction(UIAlertAction(title: NSLocalizedString("mainPage.alertDelete.yes", comment: ""), style: .destructive, handler: { _ in
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
