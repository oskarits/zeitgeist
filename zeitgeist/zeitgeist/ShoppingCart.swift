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
    
    @ObservedObject var networkingManager = NetworkingManager()
    @Environment(\.managedObjectContext) var managedObjectContext: NSManagedObjectContext
    @FetchRequest(fetchRequest: ItemNode.getNodes()) var fetchedResults: FetchedResults<ItemNode>
    @FetchRequest(fetchRequest: LoginNode.getNodes()) var isLoggedInResults: FetchedResults<LoginNode>
    @FetchRequest(fetchRequest: CheckoutNode.getNodes()) var checkoutResults: FetchedResults<CheckoutNode>
    let url : String = "https://www.zalando-wardrobe.de/api/images/"
    @State private var number : Int = 0
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(fetchedResults, id: \.self) { node in
                        VStack {
                            if( node.isCollected == true) {
                                HStack {
                                    VStack {
                                        SearchImageViewComponent(url: "\(self.url)" + "\(node.image)")
                                        Text("\(node.brand)").fontWeight(.medium)
                                        Text("SIZE: \(node.size)").font(.system(size: 11))
                                        Text("\(node.price) €").font(.system(size: 11))
                                            .foregroundColor(Color.orange)
                                            .fontWeight(.regular)
                                    }
                                    
                                    Button(action: {
                                        print(self.checkoutResults)
                                        self.addItem(itemID: node.description, brand: node.brand, size: node.size, price: node.price)
                                        self.numberToOrder(number: node.order)
                                        self.updateItemNode(node: node)
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
    
    // ---------FUNCTIONS--------
    
    func numberToOrder(number: Int) {
        self.number = (number - 1)
        print("---------")
        print("Current order: \(number)")
        
    }
    
    func updateItemNode(node: ItemNode) {
        let isCollected = false
        let node = node
        node.isCollected = isCollected
        managedObjectContext.performAndWait {
            try? managedObjectContext.save()
        }
    }
    
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
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    func deleteCore() {
        let currentOrderString: String = String(self.number + 1)
        var orderArray = ["empty"]
        for i in fetchedResults {
            orderArray.append("\(i.self.order)")
        }
        let filterIndex = orderArray.enumerated().filter { $0.element == currentOrderString }.map { $0.offset }
        print("all orders ", orderArray)
        print("index of the selected order: ", filterIndex)
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
                print("list saved")
            }
        } else {
            print("optional fail")}
    }
}

struct ShoppingCart_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCart()
    }
}
