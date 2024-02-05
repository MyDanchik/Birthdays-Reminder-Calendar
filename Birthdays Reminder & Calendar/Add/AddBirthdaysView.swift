import PhotosUI
import UIKit

final class DefaultAddBirthdaysView: UIViewController, UINavigationControllerDelegate, UITextViewDelegate {
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
    private let ideasTextView = UITextView()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        setupUI()
        setupBindings()
        setupTap()
        setupTextViewDelegate()
        setupTextViewKeyboard()
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
        view.addSubview(ideasTextView)
        
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(birthdaysDateLabel)
        dateStackView.addArrangedSubview(birthdaysChangeButton)
    }
    
    private func setupConstraints() {
        addImageView.translatesAutoresizingMaskIntoConstraints = false
        addImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        addImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        addImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        addImageButton.centerXAnchor.constraint(equalTo: addImageView.centerXAnchor).isActive = true
        addImageButton.centerYAnchor.constraint(equalTo: addImageView.centerYAnchor).isActive = true
        addImageButton.heightAnchor.constraint(equalTo: addImageView.heightAnchor, multiplier: 1).isActive = true
        addImageButton.widthAnchor.constraint(equalTo: addImageView.widthAnchor, multiplier: 1).isActive = true
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 30).isActive = true
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
        
        ideasTextView.translatesAutoresizingMaskIntoConstraints = false
        ideasTextView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 11).isActive = true
        ideasTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        ideasTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        ideasTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }
    
    private func setupUI() {
        
        let namePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: nameTextField.frame.height))
        let surnamePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: surnameTextField.frame.height))
        
        view.backgroundColor = .backgroundAddScreen
        
        title = NSLocalizedString("addBirthdaysPage.title", comment: "")
        
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
        
        nameTextField.placeholder = NSLocalizedString("addBirthdaysPage.nameTextField", comment: "")
        nameTextField.backgroundColor = .backgroundCell
        nameTextField.font = UIFont(name: "Manrope-Regular", size: 18)
        nameTextField.textColor = .titleColors
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.cornerRadius = 10
        nameTextField.leftView = namePaddingView
        nameTextField.leftViewMode = .always
        nameTextField.layer.borderColor = UIColor.borderColors.cgColor
        
        surnameTextField.placeholder = NSLocalizedString("addBirthdaysPage.surnameTextField", comment: "")
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
        
        dateLabel.text = NSLocalizedString("addBirthdaysPage.dateLabel", comment: "")
        dateLabel.textColor = .titleColors
        dateLabel.font = UIFont(name: "Manrope-Medium", size: 20)
        
        birthdaysDateLabel.text = "-"
        birthdaysDateLabel.textColor = .titleColors
        birthdaysDateLabel.font = UIFont(name: "Manrope-Medium", size: 18)
        
        birthdaysChangeButton.setTitle(NSLocalizedString("addBirthdaysPage.birthdaysChangeButton", comment: ""), for: .normal)
        birthdaysChangeButton.setTitleColor(.systemBlue, for: .normal)
        birthdaysChangeButton.addTarget(self, action: #selector(tapOnDateChangeButton), for: .touchUpInside)
        birthdaysChangeButton.titleLabel?.font = UIFont(name: "Manrope-Medium", size: 18)
        
        ideasTextView.text = NSLocalizedString("addBirthdaysPage.ideasTextView", comment: "")
        ideasTextView.backgroundColor = .backgroundCell
        ideasTextView.font = UIFont(name: "Manrope-Regular", size: 18)
        ideasTextView.textColor = .titleColors
        ideasTextView.layer.borderWidth = 1.0
        ideasTextView.layer.cornerRadius = 10
        ideasTextView.layer.borderColor = UIColor.borderColors.cgColor
        
    }
    @objc func tapOnDateChangeButton() {
        viewModel.transitionDate()
        
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
              let dateBirthdays = birthdaysDateLabel.text, !dateBirthdays.isEmpty,
              let ideasBirthdays = ideasTextView.text, !ideasBirthdays.isEmpty else { return }
        
        viewModel.saveNewBirthdays(imageBirthdays: imageBirthdays,
                                   nameBirthdays: nameBirthdays,
                                   surnameBirthdays: surnameBirthdays,
                                   dateBirthdays: dateBirthdays,
                                   ideasBirthdays: ideasBirthdays)
    }
    
    private func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDone))
        view.addGestureRecognizer(tap)
    }
    private func setupTextViewDelegate() {
        ideasTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    private func setupTextViewKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UITextView.textDidEndEditingNotification, object: nil)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
            viewModel.saveNewBirthdays(imageBirthdays: image.jpegData(compressionQuality: 1.0), nameBirthdays: nameTextField.text, surnameBirthdays: surnameTextField.text, dateBirthdays: birthdaysDateLabel.text, ideasBirthdays: ideasTextView.text)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

