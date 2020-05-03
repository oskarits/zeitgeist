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
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    
    @State private var showingAlert = false
    @State private var shouldHide = false
    

    var body: some View {
        VStack {
            if isLoggedInResults.count > 0 {
//                VStack {
//                    ShoppingCart()
//                }
              
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
                    Button(action: {
                        self.addItem(itemID: "123", brand: "Wolfie", size: "L/XL", price: "50€")
                        print(self.checkoutResults)
                        self.showingAlert = true
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

struct ShoppingHistory_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingHistory()
    }
}
