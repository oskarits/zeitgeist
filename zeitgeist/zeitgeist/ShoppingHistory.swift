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
    // Allows the use of core data
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    // Fetches core data using CheckoutNode NSManagedObject class
    @FetchRequest(fetchRequest: CheckoutNode.getNodes()) var checkoutResults: FetchedResults<CheckoutNode>
    // Fetches core data using LoginNode NSManagedObject class
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    // Fetches core data using ItemNode NSManagedObject class
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    // Variable for showing alert
    @State private var showingAlert = false
    // Variable for hiding alert
    @State private var shouldHide = false

    var body: some View {
        VStack {
            // If logged in
            if isLoggedInResults.count > 0 {
                // Default item for sale
                VStack {
                    Spacer()
                    Image("wolfShirt")
                            .frame(width: 150, height: 50)
                    Spacer()
                    Text("Wolfie")
                        .fontWeight(.bold)
                        .font(.headline)
                    Text("L/XL")
                        .font(.subheadline)
                    Text("9000€")
                        .foregroundColor(.orange)
                        .font(.subheadline)
                    Spacer()
                    // Button to buy item
                    Button(action: {
                        // Adds item to core data
                        self.addItem(itemID: "123", brand: "Wolfie", size: "L/XL", price: "50€")
                        // Prints checkout results
                        print(self.checkoutResults)
                        // Shows alert
                        self.showingAlert = true
                        // Hides alert
                        self.shouldHide = true
                    }) {
                        Text("Apple Pay")
                            .padding()
                            .font(.title)
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                            .frame(width: 250, height: 80)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Purchace confirmation"), message: Text("Thank you for using self-checkout. \n You can see your previous purchases in the Profile tab. "), dismissButton: .default(Text("OK")))                                }
                                }
                            .opacity(shouldHide ? 0 : 1)
                }
            }
            else { // If not signed in
                Text("You need to sign in to see shopping history")
            }
        }
    }
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
            print("saved")
        } catch {
            print(error)
        }
    }
}
// For canvas preview
struct ShoppingHistory_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingHistory()
    }
}
