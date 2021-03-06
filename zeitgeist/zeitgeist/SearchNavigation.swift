//
//  SearchNavigation.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 9.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData

struct SearchNavigation: View {
    // Fetches data from URL in NetworkingManager ObservableObject class
    @ObservedObject var networkingManager = NetworkingManager()
    // Local list of items for indexing item for +/- icon
    @State private var shoppingList: [(key: String, value: String)] = [:].sorted{$0.value < $1.value}
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using ItemNode NSManagedObject class
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    // Fetches core data using LoginNode NSManagedObject class
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    // Placeholder for decodable variables
    var item : ClothingListEntry
    
    
    var body: some View {
            NavigationLink(destination:
                // Navigation destination
            SingleItemView(item: item)) {
                VStack(alignment: .leading) {
                    
                    HStack {
                        VStack {
                            VStack {
                                ListItem(item: item)
                            }
                        }
                        Spacer()
                        // If user is logged in
                        if (self.isLoggedInResults.endIndex > 0) {
                            VStack {
                                // Filters item by id, if item is in list shows Reserve
                                if (self.shoppingList.firstIndex(where: {$0.value == "\(item.id)"}) != nil) {

                                    Button(action: {
                                        // Remove item from shoppingList
                                        self.ShoppingCartMinus(index: "\(self.item.id)")
                                    }){
                                        Text("reservedButton")
                                            .padding(10)
                                            .background(Color.green)
                                            .cornerRadius(18)
                                            .foregroundColor(.white)
                                            .font(.system(size: 10))
                                    }
                                }
                                // Filters item by id, if item is not in list shows Reserved
                                if (self.shoppingList.firstIndex(where: {$0.value == "\(item.id)"}) == nil) {
//                                    
                                    Button(action: {
                                        // Add item to shoppingList
                                        self.ShoppingCartPlus(key: self.item.brand, value: "\(self.item.id)")
                                        // Add item to core data
                                        self.addItem(itemID: "\(self.item.id)", brand: self.item.brand, size: self.item.size, price: self.item.price, image: "\(self.item.images[0])")
                                    }){
                                        Text("reserveButton")
                                            .padding(10)
                                            .background(Color.orange)
                                            .cornerRadius(18)
                                            .foregroundColor(.white)
                                            .font(.system(size: 10))
                                    }
                                }
                            }
                        }                        
                    }
                }
        }
        }
    // Adds item listing to CoreData
    func addItem(itemID: String, brand: String, size: String, price: String, image: String) {
        let node = ItemNode(context: managedObjectContext)
        node.idString = itemID
        node.size = size
        node.brand = brand
        node.size = size
        node.price = price
        node.image = image
        node.isCollected = false
        node.isReserved = true
        node.order = (fetchedResults.last?.order ?? 0) + 1
        print("Order of new item: \(node.order)")
        saveItems()
    }
    
    // Saves the added items to core data
    func saveItems() {
        do {
            try managedObjectContext.save()
            print("saved")
        } catch {
            print(error)
        }
    }
    
    // Function when + icon is pressed
    func ShoppingCartPlus(key: String, value: String) {
        // Adds item info to dictionary
        self.shoppingList.insert((key: key, value: value), at: self.shoppingList.count)
        // Toggles keyboard down
        UIApplication.shared.endEditing(true)
    }
    // Function when - icon is pressed
    func ShoppingCartMinus(index: String) {
        if self.shoppingList.count > 0 {
            let indx = self.shoppingList.firstIndex(where: {$0.value == index})
            print(indx ?? "nothing")
            if indx != nil {
                // Removes item info to dictionary
                self.shoppingList.remove(at: indx ?? 0)
            }
        }
        // Toggles keyboard down
        UIApplication.shared.endEditing(true)
    }
}
