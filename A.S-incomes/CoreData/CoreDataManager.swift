//
//  CoreDataManager.swift
//  Rawaj
//
//  Created by Monica Girgis Kamel on 02/06/2022.
//

import CoreData

class CoreDataManager{

    public static let shared : CoreDataManager = CoreDataManager()

    private init(){}

    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "A.S-incomes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var context : NSManagedObjectContext!{
        return persistentContainer.viewContext
    }

    //MARK: - Save CoreData
    private func saveContext(){
        if context.hasChanges{
            do{
                try context.save()
            }
            catch let error{
                print("Can't save context:",error)
            }
        }
    }

    //MARK: - Delete CoreData
    func delete(_ obj: NSManagedObject?) {
        guard let deleteObjc = obj else { return }
        context.delete(deleteObjc)
        print("Deleted Succesed")
        saveContext()
    }

    func delete(_ obj: [NSManagedObject]?) {
        guard let deleteObjc = obj else { return }
        deleteObjc.forEach({context.delete($0)})
        print("Deleted Succesed")
        saveContext()
    }
    
    // MARK: - Destinations
    // MARK: - Add Destination
    func addDestinations(dests: [Destination]){
        for dest in dests {
            let item: DestinationCD! = NSEntityDescription.insertNewObject(forEntityName: "DestinationCD", into: context) as? DestinationCD
            item.name = dest.name
            
            saveContext()
        }
    }
    
    // MARK: - Get SubCategories
    func getDestinations()->([DestinationCD]?, [Destination]?){
        do{
            if let items = try context.fetch(DestinationCD.fetchRequest()) as? [DestinationCD], !items.isEmpty{
                var dests: [Destination] = []
                for item in items {
                    let dest = Destination(name: item.name)
                    dests.append(dest)
                }
                
                var arr: [DestinationCD] = []
                items.forEach { dest in
                    if !arr.contains(where: { $0.name == dest.name }){
                        arr.append(dest)
                    }
                }
                
                return (arr, dests)
            }
            return (nil, nil)
        }
        catch let error{
            print("Can't Get items",error)
            return (nil, nil)
        }
    }
    
    // MARK: - Expenses
    // MARK: - Add expense
    func addExpense(amount: Double, date: String, destination: String) {
        let item: ExpenseCD! = NSEntityDescription.insertNewObject(forEntityName: "ExpenseCD", into: context) as? ExpenseCD
        item.amount = amount
        item.date = date
        
        let dest: DestinationCD! = NSEntityDescription.insertNewObject(forEntityName: "DestinationCD", into: context) as? DestinationCD
        dest.name = destination
        
        item.destination = dest
        
        saveContext()
    }
    
    // MARK: - Get expenses
    func getExpenses() -> [ExpenseCD]? {
        do{
            if let items = try context.fetch(ExpenseCD.fetchRequest()) as? [ExpenseCD], !items.isEmpty{
                return (items)
            }
            
            return nil
        }
        catch let error{
            print("Can't Get items",error)
            return nil
        }
    }
}
