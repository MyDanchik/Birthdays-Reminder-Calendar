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
    private let descriptionTextView = UITextView()
    
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
        infoView.addSubview(ageLabel)
        
        infoView.addSubview(descriptionTextView)
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
        dateTextLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        dateTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: dateTextLabel.bottomAnchor, constant: 10).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        dateLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10).isActive = true
        ageLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor).isActive = true
        ageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 15).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 20).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -20).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 138).isActive = true
        
        
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundAddScreen
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        
        infoView.backgroundColor = .backgroundAddScreen
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
        dateTextLabel.text = "День рождение"
        dateTextLabel.font = UIFont(name: "Manrope-Medium", size: 12)
        dateTextLabel.textColor = .titleColors
        
        dateLabel.backgroundColor = .clear
        dateLabel.textColor = .titleColors
        dateLabel.font = UIFont(name: "Manrope-Medium", size: 20)
        
        
        ageLabel.backgroundColor = .clear
        ageLabel.textColor = .titleColors
        ageLabel.font = UIFont(name: "Manrope-Medium", size: 20)
        
        descriptionTextView.font = UIFont(name: "Manrope-Regular", size: 14)
        descriptionTextView.backgroundColor = .clear
        descriptionTextView.textColor = .titleColors
        descriptionTextView.isEditable = false
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
                ageLabel.text = " Исполнится: \(age)"
            }
        }
        
        descriptionTextView.text = birthdays.descriptionBirthdays
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
