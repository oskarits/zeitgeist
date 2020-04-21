//
//  ShoppingHistory.swift
//  zeitgeist
//
//  Created by Tom Paavolainen on 3.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData


struct ShoppingHistory: View {
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: CheckoutNode.getNodes()) var checkoutResults: FetchedResults<CheckoutNode>
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    var body: some View {
        VStack {
            if isLoggedInResults.count > 0 {
                Button(action: {
                    self.addItem(itemID: "123", brand: "Gucci", size: "38/S", price: "50€")
                    print(self.checkoutResults)
                }) {
                    Text("Buy this product")
                }
            }
            else {
                Text("You need to sign in to see shopping history")
            }
        }
    }
    
    //---FUNCTIONS---
    
    //Adds item listing to CoreData
    func addItem(itemID: String, brand: String, size: String, price: String) {
        let node = CheckoutNode(context: managedObjectContext)
        node.idString = itemID
        node.size = size
        node.brand = brand
        node.size = size
        node.price = price
        // node.image = image
        node.isCollected = false
        node.isReserved = true
        node.order = (checkoutResults.last?.order ?? 0) + 1
        print("Order of new item: \(node.order)")
        saveItems()
    }
    
    //Saves the added items to core data
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
