//
//  SingleItemView.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 2.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData

struct SingleItemView: View {
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
    // State for info popup
    @State var popupOpen = false
    
    var body: some View {
        ScrollView {
            VStack {
                // Displays item image
                SingleItemImageView(item: item)
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            // Item brand name
                            Text(item.brand).font(.largeTitle)
                            HStack {
                                Text("SIZE: ")
                                    .fontWeight(.bold)
                                // Item size
                                Text(item.size)
                            }
                        }
                        Spacer()
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
                        // Filters item by id, if item is not in list shows -
                        if (self.shoppingList.firstIndex(where: {$0.value == "\(item.id)"}) == nil) {

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
                            Image(systemName: "info.circle")
                                .onTapGesture {
                                    self.popupOpen = !self.popupOpen
                                }
                                .background(Color.white)
                                .overlay(
                                    VStack {
                                        VStack {
                                            Text("infoText")
                                        }.padding()
                                        .frame(width: 120, height: 150, alignment: .center)
                                        
                                        .font(.system(size: 11))
                                        .background(Color.white)
                                        .foregroundColor(.black)
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
                                        .offset(x: 0, y: -100) // Move the view above the button
                                    }.opacity(popupOpen ? 1 : 0)
                                    
                                )
                        Spacer()
                        // Item price
                        Text("\(item.price) €")
                            .font(.system(size: 25))
                            .foregroundColor(Color.orange)
                            .fontWeight(.bold)
                    }
                }.padding()
                VStack {
                    HStack(alignment: .top) {
                        Text("conditionText")
                            .fontWeight(.bold)
                        // Item condition
                        Text(item.condition)
                        Spacer()
                    }
                    Text("")
                    HStack(alignment: .top) {
                        Text("decscriptionText")
                            .fontWeight(.bold)
                        // Item description
                        Text(item.description)
                        Spacer()
                    }
                }.padding()
            }
            .onAppear { // Toggles keyboard down
                UIApplication.shared.endEditing(true)
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
