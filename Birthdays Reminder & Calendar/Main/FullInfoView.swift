import UIKit
import WebKit

final class DefaulFullInfoView: UIViewController {
    
    // MARK: - UI Elements
    
    private let imageView = UIImageView()
    private let infoView = UIView()
    private let birthdaysNameLabel = UILabel()
    private let ratingBirthdaysLabel = UILabel()
    private let defaultRatingBirthdaysLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let descriptionTextView = UITextView()
    private let youtubeWebView = WKWebView()
    private let starImageView = UIImageView()
    
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
        infoView.addSubview(birthdaysNameLabel)
        infoView.addSubview(starImageView)
        infoView.addSubview(ratingBirthdaysLabel)
        infoView.addSubview(defaultRatingBirthdaysLabel)
        infoView.addSubview(releaseDateLabel)
        infoView.addSubview(descriptionTextView)
        infoView.addSubview(youtubeWebView)
    }

    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 296).isActive = true
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 257).isActive = true
        infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        birthdaysNameLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdaysNameLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 29).isActive = true
        birthdaysNameLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 19).isActive = true
        birthdaysNameLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -18).isActive = true
        birthdaysNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.topAnchor.constraint(equalTo: birthdaysNameLabel.bottomAnchor, constant: 14).isActive = true
        starImageView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 19).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        ratingBirthdaysLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingBirthdaysLabel.topAnchor.constraint(equalTo: birthdaysNameLabel.bottomAnchor, constant: 14).isActive = true
        ratingBirthdaysLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 8).isActive = true
        ratingBirthdaysLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        defaultRatingBirthdaysLabel.translatesAutoresizingMaskIntoConstraints = false
        defaultRatingBirthdaysLabel.topAnchor.constraint(equalTo: birthdaysNameLabel.bottomAnchor, constant: 14).isActive = true
        defaultRatingBirthdaysLabel.leadingAnchor.constraint(equalTo: ratingBirthdaysLabel.trailingAnchor, constant: 2).isActive = true
        defaultRatingBirthdaysLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.topAnchor.constraint(equalTo: birthdaysNameLabel.bottomAnchor, constant: 14).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: defaultRatingBirthdaysLabel.trailingAnchor, constant: 8).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.topAnchor.constraint(equalTo: ratingBirthdaysLabel.bottomAnchor, constant: 13).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 19).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -19).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 138).isActive = true
        
        youtubeWebView.translatesAutoresizingMaskIntoConstraints = false
        youtubeWebView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 18).isActive = true
        youtubeWebView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -19).isActive = true
        youtubeWebView.heightAnchor.constraint(equalToConstant: 196).isActive = true
        youtubeWebView.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -52).isActive = true
    }
    
    private func setupUI() {
        view.backgroundColor = .backgroundAddScreen
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFill
        
        infoView.backgroundColor = .backgroundAddScreen
        infoView.layer.cornerRadius = 16
        
        birthdaysNameLabel.backgroundColor = .clear
        birthdaysNameLabel.font = UIFont(name: "Manrope-Bold", size: 24)
        birthdaysNameLabel.numberOfLines = 0
        birthdaysNameLabel.textColor = .titleColors
        
        starImageView.image = UIImage(systemName: "star.fill")
        starImageView.tintColor = .systemYellow
        
        ratingBirthdaysLabel.backgroundColor = .clear
        ratingBirthdaysLabel.font = UIFont(name: "Manrope-Bold", size: 14)
        ratingBirthdaysLabel.textColor = .titleColors
        
        defaultRatingBirthdaysLabel.text = "/10"
        defaultRatingBirthdaysLabel.font = UIFont(name: "Manrope-Regular", size: 14)
        defaultRatingBirthdaysLabel.textColor = .gray
        
        releaseDateLabel.textColor = .gray
        releaseDateLabel.font = UIFont(name: "Manrope-Regular", size: 14)
        
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
        ratingBirthdaysLabel.text = birthdays.surnameBirthdays
        
        if let releaseDate = birthdays.releaseDateBirthdays {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            if let date = dateFormatter.date(from: releaseDate) {
                let yearFormatter = DateFormatter()
                yearFormatter.dateFormat = "yyyy"
                releaseDateLabel.text = yearFormatter.string(from: date)
            }
        }
        
        descriptionTextView.text = birthdays.descriptionBirthdays
    }
}
