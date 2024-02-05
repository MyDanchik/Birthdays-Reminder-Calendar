import PhotosUI
import UIKit

// MARK: - AddBirthdaysViewModel Protocol

protocol AddBirthdaysViewModel {
    func tapOnALertButton()
    func openGalery()
    func openCamera()
    var setupAlert: ((UIAlertController) -> Void)? { get set }
    var setupPHPicker: ((PHPickerViewController) -> Void)? { get set }
    var setupUIImagePicker: ((UIImagePickerController) -> Void)? { get set }
    var ToMainTransition: (() -> Void)? { get set }
    
    func transitionDate()
    
    var transitionReleaseView: ((DefaultDateView) -> Void)? { get set }
    
    func saveNewBirthdays(imageBirthdays: Data?, nameBirthdays: String?, surnameBirthdays: String?, dateBirthdays: String?, ideasBirthdays: String?)
    var saveNewBirthdaysClosure: ((UIAlertController) -> Void)? { get set }
}

// MARK: - DefaultAddBirthdaysViewModel

final class DefaultAddBirthdaysViewModel: AddBirthdaysViewModel {
    var ToMainTransition: (() -> Void)?
    var setupUIImagePicker: ((UIImagePickerController) -> Void)?
    var setupPHPicker: ((PHPickerViewController) -> Void)?
    var setupAlert: ((UIAlertController) -> Void)?
    var transitionReleaseView: ((DefaultDateView) -> Void)?
    
    // MARK: - Transition Methods
    
    func transitionDate() {
        let releaseView = DefaultDateView()
        let releaseViewModel = dateViewModel()
        releaseView.viewModel = releaseViewModel
        transitionReleaseView?(releaseView)
    }
    
    func tapOnALertButton() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("addBirthdaysPage.tapOnALertButton.camera", comment: ""), style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("addBirthdaysPage.tapOnALertButton.galery", comment: ""), style: .default, handler: { _ in
            self.openGalery()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("addBirthdaysPage.tapOnALertButton.cancel", comment: ""), style: .cancel, handler: { _ in
        }))
        setupAlert?(alert)
    }
    
    func openGalery() {
        var configurator = PHPickerConfiguration(photoLibrary: .shared())
        configurator.filter = .images
        configurator.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configurator)
        setupPHPicker?(picker)
    }
    
    func openCamera() {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else { }
        setupUIImagePicker?(imagePicker)
    }
    
    
    // MARK: - Birthdays Saving
    
    var saveNewBirthdaysClosure: ((UIAlertController) -> Void)?
    
    func saveNewBirthdays(imageBirthdays: Data?, nameBirthdays: String?, surnameBirthdays: String?, dateBirthdays: String?, ideasBirthdays: String?) {
        
        guard let imageBirthdays = imageBirthdays, imageBirthdays.count > 0,
              let nameBirthdays = nameBirthdays, nameBirthdays != "",
              let surnameBirthdays = surnameBirthdays, surnameBirthdays != "-",
              let dateBirthdays = dateBirthdays, dateBirthdays != "-",
              let ideasBirthdays = ideasBirthdays, ideasBirthdays != ""
        else {
            let alertEmpty = UIAlertController(title: NSLocalizedString("addBirthdaysPage.alertEmpty", comment: ""), message: "", preferredStyle: .alert)
            alertEmpty.addAction(UIAlertAction(title: NSLocalizedString("addBirthdaysPage.alertOK", comment: ""), style: .destructive, handler: { _ in
            }))
            saveNewBirthdaysClosure?(alertEmpty)
            return
        }
        let result = CoreDataManager.instance.saveBirthdays(imageBirthdays: imageBirthdays, nameBirthdays: nameBirthdays, surnameBirthdays: surnameBirthdays, dateBirthdays: dateBirthdays, ideasBirthdays: ideasBirthdays)
        
        switch result {
        case .success:
            let alertSuccess = UIAlertController(title: NSLocalizedString("addBirthdaysPage.alertSuccess", comment: ""), message: "", preferredStyle: .alert)
            alertSuccess.addAction(UIAlertAction(title: NSLocalizedString("addBirthdaysPage.alertOK", comment: ""), style: .default, handler: { _ in
                self.ToMainTransition?()
            }))
            saveNewBirthdaysClosure?(alertSuccess)
        case .failure(let failure):
            print(failure)
            let alertError = UIAlertController(title: NSLocalizedString("addBirthdaysPage.alertError", comment: ""), message: "", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title:  NSLocalizedString("addBirthdaysPage.alertOK", comment: ""), style: .destructive, handler: { _ in
            }))
            saveNewBirthdaysClosure?(alertError)
        }
    }
}
