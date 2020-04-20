//
//  SearchNavigation.swift
//  zeitgeist
//
//  Created by Jari Pietikäinen on 9.4.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import SwiftUI
import CoreData
import WaterfallGrid

struct SearchNavigation: View {
    
    @ObservedObject var networkingManager = NetworkingManager()
    @State private var shoppingList: [(key: String, value: String)] = [:].sorted{$0.value < $1.value}
    // CoreData
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    var item : ClothingListEntry
    
    var body: some View {
            NavigationLink(destination:
            SingleItemView(item: item)) {
                VStack(alignment: .leading) {
                    HStack {
                        VStack {
                            VStack {
                                ListItem(item: item)
                            }
                        }
                        Spacer()
                        VStack {
                            if (self.shoppingList.firstIndex(where: {$0.value == "\(item.id)"}) != nil) {
                                Image(systemName: "minus.circle").font(Font.system(size: 30, weight: .regular)).onTapGesture {
                                    self.ShoppingCartMinus(index: "\(self.item.id)")
                                }
                            }
                            if (self.shoppingList.firstIndex(where: {$0.value == "\(item.id)"}) == nil) {
                                Image(systemName: "plus.circle").font(Font.system(size: 30, weight: .regular)).onTapGesture {
                                    self.ShoppingCartPlus(key: self.item.brand, value: "\(self.item.id)")
                                    self.addItem(itemID: "\(self.item.id)", brand: self.item.brand, size: self.item.size, price: self.item.price, image: "\(self.item.images[0])")
                                }
                            }
                        }
                    }
                }
            }
        }
    
    
    //---FUNCTIONS---
    
    //Adds item listing to CoreData
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
    
    //Saves the added items to core data
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    //Function when shopping cart icon is pressed
    func ShoppingCartPlus(key: String, value: String) {
        //Adds item info to dictionary
        self.shoppingList.insert((key: key, value: value), at: self.shoppingList.count)
        //Toggles keyboard down
        UIApplication.shared.endEditing(true)
    }
    
    func ShoppingCartMinus(index: String) {
        if self.shoppingList.count > 0 {
            let indx = self.shoppingList.firstIndex(where: {$0.value == index})
            print(indx ?? "nothing")
            if indx != nil {
                self.shoppingList.remove(at: indx ?? 0)
            }
        }
        UIApplication.shared.endEditing(true)
    }
}

struct SearchNavigation_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
