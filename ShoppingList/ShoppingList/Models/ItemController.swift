//
//  ItemController.swift
//  ShoppingList
//
//  Created by Carlotta Chen on 1/21/22.
//

import Foundation

class ItemController {
    static let shared = ItemController()
    var items: [Item] = []
    
    func createShoppingItem(name: String, notes: String?) {
        let newItem = Item(name: name, notes: notes)
        items.append(newItem)
        saveToPersistenceStore()
    }
    
    func updateShoppingItem(item: Item, name: String, notes: String?) {
        item.name = name
        item.notes = notes
        saveToPersistenceStore()
    }
    
    func togglePurchased(item: Item) {
        item.purchased.toggle()
        saveToPersistenceStore()
    }
    
    func delete(item: Item) {
        guard let index = items.firstIndex(of: item) else { return }
        items.remove(at: index)
        saveToPersistenceStore()
    }
    
    // Persistence Store
    
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Item.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: createPersistenceStore())
        } catch {
            print("We had an error saving to our persistence store.")
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            let fetchedItems = try JSONDecoder().decode([Item].self, from: data)
            items = fetchedItems
        } catch {
            print("We had an error loading from our persistence store.")
            print(error)
            print(error.localizedDescription)
        }
    }
    
}
