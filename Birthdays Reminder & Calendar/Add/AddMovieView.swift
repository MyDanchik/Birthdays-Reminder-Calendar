import PhotosUI
import UIKit

final class DefaultAddBirthdaysView: UIViewController, UINavigationControllerDelegate{
    var viewModel: AddBirthdaysViewModel!
    
    // MARK: - UI Elements
    
    private let addImageView = UIImageView()
    private let addImageButton = UIButton()
    private let nameStackView = UIStackView()
    private let nameTitleLabel = UILabel()
    private let nameLabel = UILabel()
    
    private let nameTextView = UITextView()
    
    private let nameChangeButton = UIButton()
    private let surnameStackView = UIStackView()
    private let surnameLabel = UILabel()
    
    private let surnameTextView = UITextView()
    
    private let ratingValueLabel = UILabel()
    private let ratingChangeButton = UIButton()
    private let releaseStackView = UIStackView()
    private let releaseLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let releaseChangeButton = UIButton()
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
        view.addSubview(nameTextView)
        view.addSubview(surnameTextView)
        
        view.addSubview(nameStackView)
        view.addSubview(surnameStackView)
        view.addSubview(releaseStackView)
        view.addSubview(descriptionTextView)


        releaseStackView.addArrangedSubview(releaseLabel)
        releaseStackView.addArrangedSubview(releaseDateLabel)
        releaseStackView.addArrangedSubview(releaseChangeButton)


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

        nameTextView.translatesAutoresizingMaskIntoConstraints = false
        nameTextView.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 32).isActive = true
        nameTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        nameTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        nameTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        surnameTextView.translatesAutoresizingMaskIntoConstraints = false
        surnameTextView.topAnchor.constraint(equalTo: nameTextView.bottomAnchor, constant: 10).isActive = true
        surnameTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        surnameTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        surnameTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        releaseStackView.translatesAutoresizingMaskIntoConstraints = false
        releaseStackView.topAnchor.constraint(equalTo: surnameTextView.bottomAnchor, constant: 20).isActive = true
        releaseStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        releaseStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        releaseStackView.heightAnchor.constraint(equalToConstant: 84).isActive = true
        releaseStackView.widthAnchor.constraint(equalToConstant: 125).isActive = true
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: releaseStackView.bottomAnchor, constant: 11).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -47).isActive = true 
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundAddScreen
        
        title = "Add new birthday"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .save, primaryAction: UIAction(handler: { [weak self] _ in
            self?.saveBirthdays()
        }))
        navigationItem.backButtonTitle = ""
        
        addImageView.backgroundColor = .circleAddScreen
        addImageView.layer.masksToBounds = true
        addImageView.layer.cornerRadius = 10
        addImageView.contentMode = .scaleAspectFill
        
        addImageButton.backgroundColor = .clear
        addImageButton.setImage(UIImage(named: "addImageBirthdaysView"), for: .normal)
        addImageButton.addTarget(self, action: #selector(tapOnAlertButton), for: .touchUpInside)

        nameTextView.text = "nameTextView"
        nameTextView.backgroundColor = .green
        nameTextView.font = UIFont(name: "Manrope-Regular", size: 14)
        nameTextView.textColor = .titleColors
        
        surnameTextView.text = "surnameTextView"
        surnameTextView.backgroundColor = .red
        surnameTextView.font = UIFont(name: "Manrope-Regular", size: 14)
        surnameTextView.textColor = .titleColors
        
    
        releaseStackView.axis = .vertical
        releaseStackView.alignment = .center
        
        releaseLabel.text = "Date"
        releaseLabel.textColor = .titleColors
        releaseLabel.font = UIFont(name: "Manrope-Medium", size: 18)
        
        releaseDateLabel.text = "-"
        releaseDateLabel.textColor = .titleColors
        releaseDateLabel.font = UIFont(name: "Manrope-Medium", size: 18)
        
        releaseChangeButton.setTitle("Change", for: .normal)
        releaseChangeButton.setTitleColor(.systemBlue, for: .normal)
        releaseChangeButton.addTarget(self, action: #selector(tapOnReleaseChangeButton), for: .touchUpInside)
        releaseChangeButton.titleLabel?.font = UIFont(name: "Manrope-Medium", size: 18)
        
        descriptionTextView.text = "enter a gift Ideas"
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.font = UIFont(name: "Manrope-Regular", size: 14)
        descriptionTextView.textColor = .titleColors
        
    }
    
    @objc func tapOnNameChangeButton() {
    }
    
    @objc func tapOnRatingChangeButton() {
    }
    
    @objc func tapOnReleaseChangeButton() {
        print("12")
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
        viewModel.transitionReleaseView = { [weak self] releaseScreenView in
            self?.navigationController?.pushViewController(releaseScreenView, animated: true)
            releaseScreenView.viewModel.setReleaseClosure = { [weak self] release in
                self?.releaseDateLabel.text = release
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
              let nameBirthdays = nameTextView.text, !nameBirthdays.isEmpty,
              let surnameBirthdays = surnameTextView.text, !surnameBirthdays.isEmpty,
              let releaseDateBirthdays = releaseDateLabel.text, !releaseDateBirthdays.isEmpty,
              let descriptionBirthdays = descriptionTextView.text, !descriptionBirthdays.isEmpty else { return }
        
        viewModel.saveNewBirthdays(imageBirthdays: imageBirthdays,
                               nameBirthdays: nameBirthdays,
                               surnameBirthdays: surnameBirthdays,
                               releaseDateBirthdays: releaseDateBirthdays,
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
            viewModel.saveNewBirthdays(imageBirthdays: image.jpegData(compressionQuality: 1.0), nameBirthdays: nameTextView.text, surnameBirthdays: surnameTextView.text, releaseDateBirthdays: releaseDateLabel.text, descriptionBirthdays: descriptionTextView.text)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
