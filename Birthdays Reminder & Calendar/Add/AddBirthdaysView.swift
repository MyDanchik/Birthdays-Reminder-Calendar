import PhotosUI
import UIKit

final class DefaultAddBirthdaysView: UIViewController, UINavigationControllerDelegate{
    var viewModel: AddBirthdaysViewModel!
    
    // MARK: - UI Elements
    
    private let addImageView = UIImageView()
    private let addImageButton = UIButton()

    private let nameTextField = UITextField()

    
    private let surnameTextField = UITextField()
    
    private let dateStackView = UIStackView()
    private let dateLabel = UILabel()
    private let birthdaysDateLabel = UILabel()
    private let birthdaysChangeButton = UIButton()
    private let descriptionTextView = UITextView()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        setupUI()
        setupBindings()
        setupKeyboard()
        setupTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        view.addSubview(addImageView)
        view.addSubview(addImageButton)
        view.addSubview(nameTextField)
        view.addSubview(surnameTextField)
        
        view.addSubview(dateStackView)
        view.addSubview(descriptionTextView)


        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(birthdaysDateLabel)
        dateStackView.addArrangedSubview(birthdaysChangeButton)


    }

    
    private func setupConstraints() {
        addImageView.translatesAutoresizingMaskIntoConstraints = false
        addImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 27).isActive = true
        addImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        addImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        addImageButton.centerXAnchor.constraint(equalTo: addImageView.centerXAnchor).isActive = true
        addImageButton.centerYAnchor.constraint(equalTo: addImageView.centerYAnchor).isActive = true
        addImageButton.heightAnchor.constraint(equalTo: addImageView.heightAnchor, multiplier: 1).isActive = true
        addImageButton.widthAnchor.constraint(equalTo: addImageView.widthAnchor, multiplier: 1).isActive = true

        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 32).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        surnameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20).isActive = true
        dateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dateStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        dateStackView.heightAnchor.constraint(equalToConstant: 84).isActive = true
        dateStackView.widthAnchor.constraint(equalToConstant: 125).isActive = true
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 11).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }
    
    private func setupUI() {
        
        
        let namePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: nameTextField.frame.height))
        let surnamePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: surnameTextField.frame.height))
        
        view.backgroundColor = .backgroundAddScreen
        
        title = "Add new birthday"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save, primaryAction: UIAction(handler: { [weak self] _ in
            self?.saveBirthdays()
        }))
        navigationItem.backButtonTitle = ""
        
        addImageView.backgroundColor = .backgroundCell
        addImageView.layer.masksToBounds = true
        addImageView.layer.cornerRadius = 10
        addImageView.contentMode = .scaleAspectFill
        
        addImageButton.backgroundColor = .clear
        addImageButton.setImage(UIImage(named: "addImageBirthdaysView"), for: .normal)
        addImageButton.addTarget(self, action: #selector(tapOnAlertButton), for: .touchUpInside)

        nameTextField.placeholder = "nameTextView"
        nameTextField.backgroundColor = .backgroundCell
        nameTextField.font = UIFont(name: "Manrope-Regular", size: 18)
        nameTextField.textColor = .titleColors
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.cornerRadius = 10
        nameTextField.leftView = namePaddingView
        nameTextField.leftViewMode = .always
        nameTextField.layer.borderColor = UIColor.borderColors.cgColor
        
        surnameTextField.placeholder = "surnameTextView"
        surnameTextField.backgroundColor = .backgroundCell
        surnameTextField.font = UIFont(name: "Manrope-Regular", size: 18)
        surnameTextField.textColor = .titleColors
        surnameTextField.layer.borderWidth = 1.0
        surnameTextField.layer.cornerRadius = 10
        surnameTextField.leftView = surnamePaddingView
        surnameTextField.leftViewMode = .always
        surnameTextField.layer.borderColor = UIColor.borderColors.cgColor
        
        dateStackView.axis = .vertical
        dateStackView.alignment = .center
        
        dateLabel.text = "Date birthday"
        dateLabel.textColor = .titleColors
        dateLabel.font = UIFont(name: "Manrope-Medium", size: 20)
        
        birthdaysDateLabel.text = "-"
        birthdaysDateLabel.textColor = .titleColors
        birthdaysDateLabel.font = UIFont(name: "Manrope-Medium", size: 18)
        
        birthdaysChangeButton.setTitle("Change", for: .normal)
        birthdaysChangeButton.setTitleColor(.systemBlue, for: .normal)
        birthdaysChangeButton.addTarget(self, action: #selector(tapOnReleaseChangeButton), for: .touchUpInside)
        birthdaysChangeButton.titleLabel?.font = UIFont(name: "Manrope-Medium", size: 18)
        
        descriptionTextView.text = "enter a gift Ideas"
        descriptionTextView.backgroundColor = .backgroundCell
        descriptionTextView.font = UIFont(name: "Manrope-Regular", size: 18)
        descriptionTextView.textColor = .titleColors
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.layer.cornerRadius = 10
        descriptionTextView.layer.borderColor = UIColor.borderColors.cgColor
        
    }
    
    @objc func tapOnNameChangeButton() {
    }
    
    @objc func tapOnRatingChangeButton() {
    }
    
    @objc func tapOnReleaseChangeButton() {
        viewModel.transitionRelease()
        
    }
    
    @objc func tapOnYoutubeChangeButton() {
    }
    
    private func setupBindings() {
        viewModel.setupAlert = { [weak self] alert in
            self?.present(alert, animated: true)
        }
        
        viewModel.setupPHPicker = { [weak self] picker in
            picker.delegate = self
            self?.present(picker, animated: true)
        }
        
        viewModel.setupUIImagePicker = { [weak self] imagePicker in
            imagePicker.delegate = self
            self?.present(imagePicker, animated: true, completion: nil)
        }
    
        viewModel.saveNewBirthdaysClosure = { [weak self] alert in
            self?.present(alert, animated: true)
            self?.viewModel.ToMainTransition = { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
        viewModel.transitionReleaseView = { [weak self] dateScreenView in
            self?.navigationController?.pushViewController(dateScreenView, animated: true)
            dateScreenView.viewModel.setDateClosure = { [weak self] release in
                self?.birthdaysDateLabel.text = release
            }
        }
    }
    
    @objc func tapOnAlertButton() {
        viewModel?.tapOnALertButton()
    }
    
    @objc func openGalery() {
        viewModel.openGalery()
    }
    
    @objc func openCamera() {
        viewModel.openCamera()
    }
    
    private func setupImage(image: UIImage?) {
        if let image = image {
            DispatchQueue.main.async {
                self.addImageView.image = image
                self.addImageButton.setImage(UIImage(), for: .normal)
            }
        }
    }
    
    private func saveBirthdays() {
        guard let imageBirthdays = addImageView.image?.jpegData(compressionQuality: 1.0),
              let nameBirthdays = nameTextField.text, !nameBirthdays.isEmpty,
              let surnameBirthdays = surnameTextField.text, !surnameBirthdays.isEmpty,
              let releaseDateBirthdays = birthdaysDateLabel.text, !releaseDateBirthdays.isEmpty,
              let descriptionBirthdays = descriptionTextView.text, !descriptionBirthdays.isEmpty else { return }
        
        viewModel.saveNewBirthdays(imageBirthdays: imageBirthdays,
                               nameBirthdays: nameBirthdays,
                               surnameBirthdays: surnameBirthdays,
                               dateBirthdays: releaseDateBirthdays,
                               descriptionBirthdays: descriptionBirthdays)
    }
    
    private func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDone))
        view.addGestureRecognizer(tap)
    }
    
    
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            view.frame.origin.y = -keyboardSize.height
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardHide() {
        view.frame.origin.y = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    @objc func tapDone() {
        view.endEditing(true)
    }
}

// MARK: - PHPickerViewControllerDelegate

extension DefaultAddBirthdaysView: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                self.setupImage(image: image as? UIImage)
            }
        }
        dismiss(animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension DefaultAddBirthdaysView: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            setupImage(image: image)
            viewModel.saveNewBirthdays(imageBirthdays: image.jpegData(compressionQuality: 1.0), nameBirthdays: nameTextField.text, surnameBirthdays: surnameTextField.text, dateBirthdays: birthdaysDateLabel.text, descriptionBirthdays: descriptionTextView.text)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

