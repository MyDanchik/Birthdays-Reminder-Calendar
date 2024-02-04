import CoreData
import UIKit

// MARK: - CoreDataError

enum CoreDataError: Error {
    case error(String)
}

// MARK: - CoreDataManager

final class CoreDataManager {
    static let instance = CoreDataManager()
    private init() {}

    func saveBirthdays(imageBirthdays: Data, nameBirthdays: String, surnameBirthdays: String, dateBirthdays: String, descriptionBirthdays: String) -> Result<Void, CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate not found"))
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "Birthdays", in: managedContext)!

        let birthdays = NSManagedObject(entity: entity, insertInto: managedContext)

        birthdays.setValue(imageBirthdays, forKey: "imageBirthdays")
        birthdays.setValue(nameBirthdays, forKey: "nameBirthdays")
        birthdays.setValue(surnameBirthdays, forKey: "surnameBirthdays")
        birthdays.setValue(dateBirthdays, forKey: "dateBirthdays")
        birthdays.setValue(descriptionBirthdays, forKey: "descriptionBirthdays")

        do {
            try managedContext.save()
            return .success(())
        } catch {
            return .failure(.error("Could not save. \(error)"))
        }
    }
    
    func getBirthdays() -> Result<[Birthdays], CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate not found"))
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Birthdays>(entityName: "Birthdays")

        do {
            let objects = try managedContext.fetch(fetchRequest)
            return .success(objects)
        } catch {
            return .failure(.error("Could not fetch \(error)"))
        }
    }
    
    func deleteBirthdays(_ birthdays: Birthdays) -> Result<Void, CoreDataError> {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return .failure(.error("AppDelegate not found"))
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        do {
            managedContext.delete(birthdays)
            try managedContext.save()
            return .success(())
        } catch {
            return .failure(.error("Error deleting Birthdays: \(error)"))
        }
    }
}
