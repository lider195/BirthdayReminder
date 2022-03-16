import CoreData
import UIKit

final class CoreDataManager {
    static let instance = CoreDataManager()

    func savePerson(_ user: Person) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managerContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "PersonEntity", in: managerContext)!

        let person = NSManagedObject(entity: entity, insertInto: managerContext)
       
        
        person.setValue(user.name, forKey: "name")
        person.setValue(user.surName, forKey: "surName")
        person.setValue(user.date, forKey: "date")
        person.setValue(user.age, forKey: "age")
        person.setValue(user.imagePerson, forKey: "image")
        do {
            try managerContext.save()
        } catch let error as NSError {
            print("error- \(error)")
        }
    }

    func getPerson() -> [Person]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }

        let managerContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonEntity")

        do {
            let object = try managerContext.fetch(fetchRequest)
            var users = [Person]()
            for object in object {
                guard let name = object.value(forKey: "name") as? String,
                      let surName = object.value(forKey: "surName") as? String,
                      let date = object.value(forKey: "date") as? Date,
                      let age = object.value(forKey: "age") as? Int16,
                      let image = object.value(forKey: "image") as? Data else { return nil }
                let user = Person(name: name, surName: surName, date: date, age: age,imagePerson: image)
                users.insert(user, at: 0)
            }
            return users
        } catch let error as NSError {
            print("Error-\(error)")
        }
        return nil
    }

    func deleteEntity(usersArray: [Person], indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonEntity")
        do {
            let objects = try managedContext.fetch(fetchRequest)
            managedContext.delete(objects.reversed()[indexPath.row])
        } catch let error as NSError {
            print(error)
        }
        do {
            try managedContext.save()
            guard let fetchArray = CoreDataManager.instance.getPerson() else { return }
            _ = fetchArray.reversed()
        } catch let error as NSError {
            print(error)
        }
    }

    func deleteAllPerson(_ users: [Person]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonEntity")

        if let users = try? managedContext.fetch(fetchRequest) {
            for user in users {
                managedContext.delete(user)
            }
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error - \(error)")
        }
    }

    private init() {}
}
