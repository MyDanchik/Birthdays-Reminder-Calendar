import UIKit
import WebKit

final class DefaulFullInfoView: UIViewController {
    
    // MARK: - UI Elements
    
    private let imageView = UIImageView()
    private let infoView = UIView()
    private let nameView = UIView()
    private let birthdaysNameLabel = UILabel()
    private let birthdaysSurNameLabel = UILabel()
    
    private let dateTextLabel = UILabel()
    private let dateLabel = UILabel()
    private let ideasTextView = UITextView()
    
    private let ageTextLabel = UILabel()
    private let ageLabel = UILabel()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        view.addSubview(imageView)
        view.addSubview(infoView)
        view.addSubview(nameView)
        
        nameView.addSubview(birthdaysNameLabel)
        nameView.addSubview(birthdaysSurNameLabel)
        
        infoView.addSubview(dateTextLabel)
        infoView.addSubview(dateLabel)
        infoView.addSubview(ageTextLabel)
        infoView.addSubview(ageLabel)
        infoView.addSubview(ideasTextView)
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 496).isActive = true
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 457).isActive = true
        infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.bottomAnchor.constraint(equalTo: infoView.topAnchor, constant: 43).isActive = true
        nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        nameView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        
        birthdaysNameLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdaysNameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 10).isActive = true
        birthdaysNameLabel.centerXAnchor.constraint(equalTo: nameView.centerXAnchor).isActive = true
        birthdaysNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        birthdaysSurNameLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdaysSurNameLabel.topAnchor.constraint(equalTo: birthdaysNameLabel.bottomAnchor, constant: 0).isActive = true
        birthdaysSurNameLabel.centerXAnchor.constraint(equalTo: nameView.centerXAnchor).isActive = true
        birthdaysSurNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        dateTextLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTextLabel.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20).isActive = true
        dateTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        dateTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        dateLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        ageTextLabel.translatesAutoresizingMaskIntoConstraints = false
        ageTextLabel.topAnchor.constraint(equalTo: dateTextLabel.bottomAnchor, constant: 10).isActive = true
        ageTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        ageTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.topAnchor.constraint(equalTo: dateTextLabel.bottomAnchor, constant: 10).isActive = true
        ageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        ageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        ideasTextView.translatesAutoresizingMaskIntoConstraints = false
        ideasTextView.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 15).isActive = true
        ideasTextView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20).isActive = true
        ideasTextView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20).isActive = true
        ideasTextView.heightAnchor.constraint(equalToConstant: 138).isActive = true
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundCell
    
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        
        infoView.backgroundColor = .backgroundMainScreen
        infoView.layer.cornerRadius = 16
        
        nameView.backgroundColor = .backgroundCell
        nameView.layer.cornerRadius = 16
        nameView.layer.shadowColor = UIColor.black.cgColor
        nameView.layer.shadowOffset = CGSize(width: 0, height: 2)
        nameView.layer.shadowRadius = 10
        nameView.layer.shadowOpacity = 0.20
        
        birthdaysNameLabel.backgroundColor = .clear
        birthdaysNameLabel.font = UIFont(name: "Manrope-Bold", size: 24)
        birthdaysNameLabel.numberOfLines = 0
        birthdaysNameLabel.textColor = .titleColors
        
        birthdaysSurNameLabel.backgroundColor = .clear
        birthdaysSurNameLabel.font = UIFont(name: "Manrope-Bold", size: 24)
        birthdaysSurNameLabel.numberOfLines = 0
        birthdaysSurNameLabel.textColor = .titleColors
        
        dateTextLabel.backgroundColor = .clear
        dateTextLabel.text = NSLocalizedString("fullInfoPage.dateTextLabel", comment: "") + ":"
        dateTextLabel.font = UIFont(name: "Manrope-Medium", size: 21)
        dateTextLabel.textColor = .titleColors
        
        dateLabel.backgroundColor = .clear
        dateLabel.textColor = .titleColors
        dateLabel.font = UIFont(name: "Manrope-Medium", size: 21)
        
        ageTextLabel.backgroundColor = .clear
        ageTextLabel.text = NSLocalizedString("fullInfoPage.ageTextLabel", comment: "") + ":"
        ageTextLabel.font = UIFont(name: "Manrope-Medium", size: 21)
        ageTextLabel.textColor = .titleColors
        
        ageLabel.backgroundColor = .clear
        ageLabel.textColor = .titleColors
        ageLabel.font = UIFont(name: "Manrope-Medium", size: 21)
        
        ideasTextView.font = UIFont(name: "Manrope-Regular", size: 18)
        ideasTextView.backgroundColor = .backgroundCell
        ideasTextView.textColor = .titleColors
        ideasTextView.isEditable = false
        ideasTextView.layer.cornerRadius = 10
        
        ideasTextView.layer.masksToBounds = false
        ideasTextView.layer.shadowColor = UIColor.black.cgColor
        ideasTextView.layer.shadowOffset = CGSize(width: 0, height: 2)
        ideasTextView.layer.shadowRadius = 10
        ideasTextView.layer.shadowOpacity = 0.20
    }
    
    // MARK: - Public Methods
    
    func configureFullBirthdays(birthdays: Birthdays) {
        if let imageData = birthdays.imageBirthdays, let birthdaysImage = UIImage(data: imageData) {
            imageView.image = birthdaysImage
        } else {
            imageView.image = UIImage(named: "default_image")
        }
        
        birthdaysNameLabel.text = birthdays.nameBirthdays
        birthdaysSurNameLabel.text = birthdays.surnameBirthdays
        
        if let releaseDate = birthdays.dateBirthdays {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let birthDate = dateFormatter.date(from: releaseDate) {
                let age = calculateAge(from: birthDate)
                dateLabel.text = dateFormatter.string(from: birthDate)
                ageLabel.text = "\(age) " + NSLocalizedString("fullInfoPage.ageLabel", comment: "")
            }
        }
        
        ideasTextView.text = birthdays.ideasBirthdays
    }
    
    func calculateAge(from birthday: Date) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        let birthYear = calendar.component(.year, from: birthday)
        let age = currentYear - birthYear
        return age
    }
    
}
