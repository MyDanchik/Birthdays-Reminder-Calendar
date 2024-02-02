import UIKit

// MARK: - DefaultReleaseView

final class DefaultReleaseView: UIViewController {
    
    // MARK: Properties
    
    var viewModel: ReleaseViewModel!
    
    private let releaseDateLabel = UILabel()
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
        view.addSubview(releaseDateLabel)
        view.addSubview(datePicker)
        view.addSubview(saveButton)
    }

    
    private func setupConstraints() {
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 124).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 88).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -87).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 32).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 194).isActive = true

        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 32).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 148).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -148).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundAddScreen

        releaseDateLabel.text = "Release Date"
        releaseDateLabel.textColor = .titleColors
        releaseDateLabel.textAlignment = .center
        releaseDateLabel.font = UIFont(name: "Manrope-Medium", size: 24)
 
        datePickerTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels

        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.addTarget(self, action: #selector(tapOnSaveButton), for: .touchUpInside)
        saveButton.titleLabel?.font = UIFont(name: "Manrope-Medium", size: 18)
    }

    // MARK: Helper Methods
    
    private func configureBindings() {
        viewModel.setReleaseClosure = { [weak self] release in
            self?.datePickerTextField.text = release
        }
    }

    private func getRelease() -> String? {
        let release = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: release)
    }
    
    // MARK: Actions
    
    @objc func tapOnSaveButton() {
        if let release = getRelease() {
            viewModel.setRelease(release: release)
            navigationController?.popViewController(animated: true)
        }
    }
}
