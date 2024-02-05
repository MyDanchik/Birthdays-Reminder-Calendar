import UIKit

// MARK: - DefaultDateView

final class DefaultDateView: UIViewController {
    
    // MARK: Properties
    
    var viewModel: dateViewModel!
    
    private let dateLabel = UILabel()
    private let datePicker = UIDatePicker()
    private var datePickerTextField = UITextField()
    private let saveButton = UIButton()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        setupUI()
    }

    // MARK: Setup
    
    private func setupSubviews() {
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
        view.addSubview(saveButton)
    }

    private func setupConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 124).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 88).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -87).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 32).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 194).isActive = true

        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 32).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -140).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundAddScreen

        dateLabel.text = NSLocalizedString("datePage.dateLabel", comment: "")
        dateLabel.textColor = .titleColors
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont(name: "Manrope-Medium", size: 24)
 
        datePickerTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels

        saveButton.setTitle(NSLocalizedString("datePage.saveButton", comment: ""), for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.addTarget(self, action: #selector(tapOnSaveButton), for: .touchUpInside)
        saveButton.titleLabel?.font = UIFont(name: "Manrope-Medium", size: 18)
    }

    // MARK: Helper Methods
    
    private func configureBindings() {
        viewModel.setDateClosure = { [weak self] release in
            self?.datePickerTextField.text = release
        }
    }

    private func getDate() -> String? {
        let date = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
    
    // MARK: Actions
    
    @objc func tapOnSaveButton() {
        if let date = getDate() {
            viewModel.setDate(date: date)
            navigationController?.popViewController(animated: true)
        }
    }
}
