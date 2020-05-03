//
//  ShoppingCart.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 28.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

struct ShoppingCart: View {
    // Fetches data from URL in NetworkingManager ObservableObject class
    @ObservedObject var networkingManager = NetworkingManager()
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using ItemNode NSManagedObject class
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    // Fetches core data using LoginNode NSManagedObject class
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    // Fetches core data using CheckoutNode NSManagedObject class
    @FetchRequest(fetchRequest: CheckoutNode.getNodes()) var checkoutResults: FetchedResults<CheckoutNode>
    // URL for image fetching
    let url : String = "https://www.zalando-wardrobe.de/api/images/"
    // Number value to save items to core data with index number
    @State private var number : Int = 0
    // Toggle value for updating view
    @State private var updater = false
    var body: some View {
        NavigationView {
            VStack {
                List { // Lists each item in ItemNode core data
                    ForEach(fetchedResults, id: \.self) { node in
                        VStack {
                            if( node.isCollected == true) {
                                HStack {
                                    VStack {
                                        // Displays the image of the fetched item
                                        SearchImageViewComponent(url: "\(self.url)" + "\(node.image)")
                                        Text("\(node.brand)").fontWeight(.medium)
                                        Text("SIZE: \(node.size)").font(.system(size: 11))
                                        Text("\(node.price) €").font(.system(size: 11))
                                            .foregroundColor(Color.orange)
                                            .fontWeight(.regular)
                                    }
                                    
                                    Button(action: {
                                        // Prints checkout results
                                        print(self.checkoutResults)
                                        // Adds item to core data
                                        self.addItem(itemID: node.description, brand: node.brand, size: node.size, price: node.price)
                                        // Places item index number to variable
                                        self.numberToOrder(number: node.order)
                                        // Updates core data that item is collected
                                        self.updateItemNode(node: node)
                                        // Deletes item from core data
                                        self.deleteCore()
                                    }) {
                                        Text("Apple Pay")
                                            .padding()
                                            .font(.title)
                                            .background(Color.black)
                                            .foregroundColor(Color.white)
                                            .cornerRadius(30)
                                            .padding(15)
                                    }
                                }
                            }
                        }
                    }
                    //.onDelete(perform: deleteItems)
                }
            }.navigationBarItems(trailing: EditButton())
                .navigationBarTitle(Text("reservationListTitle"), displayMode: .inline)
        }
        
    }
    // Places item index number to variable
    func numberToOrder(number: Int) {
        self.number = (number - 1)
        print("Current order: \(number)")
    }
    // Updates core data that item is collected
    func updateItemNode(node: ItemNode) {
        let isCollected = false
        let node = node
        node.isCollected = isCollected
        managedObjectContext.performAndWait {
            try? managedObjectContext.save()
        }
    }
    // Function for adding item to core data
    func addItem(itemID: String, brand: String, size: String, price: String) {
        let node = CheckoutNode(context: managedObjectContext)
        node.idString = itemID
        node.size = size
        node.brand = brand
        node.size = size
        node.price = price
        // node.image = image
        node.isCollected = true
        node.isReserved = true
        node.order = (checkoutResults.last?.order ?? 0) + 1
        print("Order of new item: \(node.order)")
        saveItems()
    }
    // Function to save NSManagedObject to core data
    func saveItems() {
        do {
            try managedObjectContext.save()
            print("saved")
        } catch {
            print(error)
        }
        self.updater.toggle()
    }
    // Deletes item from core data
    func deleteCore() {
        let currentOrderString: String = String(self.number + 1)
        var orderArray = ["empty"]
        for i in fetchedResults {
            orderArray.append("\(i.self.order)")
        }
        let filterIndex = orderArray.enumerated().filter { $0.element == currentOrderString }.map { $0.offset }
        if (fetchedResults.count == (orderArray.count - 1) && filterIndex.count > 0) {
            let nodeIndexInt = filterIndex.compactMap { $0 }
            let orderIndex : Int = nodeIndexInt[0] - 1
            let nodeIndex: Int = orderIndex
            print(nodeIndex)
            let node = fetchedResults[nodeIndex]
            managedObjectContext.delete(node)
            print("item deleted")
            if filterIndex.count > 0 {
                saveItems()
            }
        } else {
            print("optional fail")}
    }
}

// For canvas preview
struct ShoppingCart_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCart()
    }
}
