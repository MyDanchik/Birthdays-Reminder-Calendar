import UIKit

final class MainViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let containerView = UIView()
    private let birthdaysImage = UIImageView()
    private let infoView = UIView()
    private let nameLabel = UILabel()
    private let surnameLabel = UILabel()
    private let birthdaysLabel = UILabel()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(birthdaysImage)
        containerView.addSubview(infoView)
        infoView.addSubview(nameLabel)
        infoView.addSubview(surnameLabel)
        infoView.addSubview(birthdaysLabel)
    }

    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        birthdaysImage.translatesAutoresizingMaskIntoConstraints = false
        birthdaysImage.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        birthdaysImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        birthdaysImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        birthdaysImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.3).isActive = true
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        infoView.leadingAnchor.constraint(equalTo: birthdaysImage.trailingAnchor).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -15).isActive = true
        
        surnameLabel.translatesAutoresizingMaskIntoConstraints = false
        surnameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        surnameLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 15).isActive = true
        surnameLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -15).isActive = true
        
        
        birthdaysLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdaysLabel.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 0).isActive = true
        birthdaysLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 15).isActive = true
        birthdaysLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -15).isActive = true
    }
    
    private func setupUI() {
        contentView.backgroundColor = .backgroundMainScreen
        
        containerView.backgroundColor = .backgroundCell
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = 8
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 10
        containerView.layer.shadowOpacity = 0.20
        
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "Manrope-Medium", size: 18)
        nameLabel.textAlignment = .right
        nameLabel.textColor = .titleColors
        
        surnameLabel.numberOfLines = 0
        surnameLabel.font = UIFont(name: "Manrope-Medium", size: 18)
        surnameLabel.textAlignment = .right
        surnameLabel.textColor = .titleColors
        
        birthdaysLabel.numberOfLines = 0
        birthdaysLabel.font = UIFont(name: "Manrope-Bold", size: 18)
        birthdaysLabel.textAlignment = .right
        birthdaysLabel.textColor = .titleColors

        
        birthdaysImage.clipsToBounds = true
        birthdaysImage.layer.cornerRadius = 8
        birthdaysImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        birthdaysImage.contentMode = .scaleAspectFill
    }
    
    // MARK: - Public Methods
    
    func configureEntity(birthdays: Birthdays) {
        if let imageData = birthdays.imageBirthdays, let birthdaysImage = UIImage(data: imageData) {
            self.birthdaysImage.image = birthdaysImage
        } else {
            self.birthdaysImage.image = UIImage(named: "default_image")
        }
        nameLabel.text = birthdays.nameBirthdays
        surnameLabel.text = birthdays.surnameBirthdays

        if let releaseDate = birthdays.dateBirthdays {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            if let birthDate = dateFormatter.date(from: releaseDate) {
                let age = calculateAge(from: birthDate)
                birthdaysLabel.text = "Возраст: \(age)"
            }
        }
    }

    func calculateAge(from birthday: Date) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: currentDate)
        return ageComponents.year ?? 0
    }
}


